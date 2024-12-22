<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/sidebar.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실시간 위치 공유</title>
    <!-- Firebase SDK -->
    <script type="module">
        // Firebase 설정 (기존과 동일)
        import { initializeApp } from 'https://www.gstatic.com/firebasejs/9.23.0/firebase-app.js';
        import { getDatabase, ref, set, onValue, remove } from 'https://www.gstatic.com/firebasejs/9.23.0/firebase-database.js';

        const firebaseConfig = {
            apiKey: "AIzaSyB5nFk9H6Bv-DDIV4D--7mJ03DT0KtEf3k",
            authDomain: "indexl-e3f8b.firebaseapp.com",
            databaseURL: "https://indexl-e3f8b-default-rtdb.firebaseio.com",
            projectId: "indexl-e3f8b"
        };

        const app = initializeApp(firebaseConfig);
        const database = getDatabase(app);

        window.database = database;
        window.dbRef = ref;
        window.dbSet = set;
        window.dbOnValue = onValue;
        window.dbRemove = remove;
    </script>
    
    <!-- 네이버 지도 -->
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ukkuio3cf4"></script>
    <!-- QR코드 -->
    <script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>
    
    <style>
        /* 기존 스타일 유지 */
        body { 
            margin: 0; 
            padding: 20px; 
            font-family: Arial, sans-serif; 
        }
        #map { 
            width: 100%;
            height: 400px;
            max-width: 800px;
            margin: 20px auto;
            border-radius: 8px;
            border: 1px solid #ddd;
        }
        .status {
            text-align: center;
            padding: 10px;
            margin: 10px auto;
            max-width: 800px;
            border-radius: 4px;
            background-color: #f8f9fa;
        }
        #qrcode {
            text-align: center;
            margin: 20px auto;
            max-width: 200px;
        }
        /* 마커 정보창 스타일 */
        .bus-stop-info {
            padding: 10px;
            min-width: 150px;
            text-align: center;
            border-radius: 4px;
            background-color: white;
            border: 1px solid #ddd;
        }
        .bus-stop-info h4 {
            margin: 0 0 5px 0;
            font-size: 14px;
        }
        .bus-stop-info p {
            margin: 0;
            font-size: 12px;
            color: #666;
        }
        .bus-stop-info button {
            margin-top: 8px;
            padding: 4px 8px;
            background-color: #1e90ff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .bus-stop-info button:hover {
            background-color: #187bcd;
        }
        @media (max-width: 768px) {
            .desktop-only { display: none; }
        }
        @media (min-width: 769px) {
            .mobile-only { display: none; }
        }
    </style>
</head>
<body>
    <div id="status" class="status">연결 중...</div>
    
    <div id="qrcode" class="desktop-only">
        <p>휴대폰으로 스캔하세요</p>
    </div>

    <div id="map"></div>

    <script>
        let map;
        let marker = null;
        let busStopMarkers = [];
        let currentInfoWindow = null;

        const initialLocation = {
            latitude: 37.5666805,
            longitude: 126.9784147
        };

        // 고유한 공유 ID 생성 (기존과 동일)
        const urlParams = new URLSearchParams(window.location.search);
        let shareId = urlParams.get('id');
        
        if (!shareId) {
            shareId = Math.random().toString(36).substring(2, 8);
            window.history.replaceState(null, '', `?id=${shareId}`);
        }

        function isMobile() {
            return /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
        }

        if (!isMobile() && document.getElementById('qrcode')) {
            new QRCode(document.getElementById('qrcode'), {
                text: window.location.href,
                width: 200,
                height: 200
            });
        }

        function resetLocation() {
            if (shareId) {
                window.dbRemove(window.dbRef(window.database, `locations/${shareId}`));
            }
        }

        // 두 지점 사이의 거리 계산 (미터 단위)
        function calculateDistance(lat1, lon1, lat2, lon2) {
            const R = 6371e3; // 지구의 반지름 (미터)
            const φ1 = lat1 * Math.PI/180;
            const φ2 = lat2 * Math.PI/180;
            const Δφ = (lat2-lat1) * Math.PI/180;
            const Δλ = (lon2-lon1) * Math.PI/180;

            const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
                    Math.cos(φ1) * Math.cos(φ2) *
                    Math.sin(Δλ/2) * Math.sin(Δλ/2);
            const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

            return R * c;
        }

        function updateBusStops(center) {
            // 기존 버스정류장 마커 및 정보창 제거
            busStopMarkers.forEach(marker => {
                if (marker.infoWindow) {
                    marker.infoWindow.close();
                }
                marker.setMap(null);
            });
            busStopMarkers = [];

            // 테스트용 버스정류장 데이터 (7자리 ID 형식으로 수정)
            const testStops = [
                { id: "1234567", name: "대전복합터미널", lat: center.lat() + 0.002, lng: center.lng() + 0.002 },
                { id: "2345678", name: "서대전역", lat: center.lat() - 0.002, lng: center.lng() - 0.002 },
                { id: "3456789", name: "대전시청", lat: center.lat() + 0.004, lng: center.lng() - 0.001 }
            ];

            // 1km 반경 내의 정류장만 필터링
            const nearbyStops = testStops.filter(stop => {
                const distance = calculateDistance(
                    center.lat(), center.lng(),
                    stop.lat, stop.lng
                );
                return distance <= 1000; // 1km = 1000m
            });

            // 필터링된 정류장에 마커 생성
            nearbyStops.forEach(stop => {
                const position = new naver.maps.LatLng(stop.lat, stop.lng);
                
                // 마커 생성
                const marker = new naver.maps.Marker({
                    position: position,
                    map: map
                });

                // 정보창 내용
                const contentString = `
                    <div class="bus-stop-info">
                        <h4>${stop.name}</h4>
                        <p>정류장 ID: ${stop.id}</p>
                        <button onclick="viewBusInfo('${stop.id}')">버스 정보 보기</button>
                    </div>
                `;

                // 정보창 생성
                const infoWindow = new naver.maps.InfoWindow({
                    content: contentString,
                    maxWidth: 250,
                    backgroundColor: "white",
                    borderWidth: 1,
                    borderColor: "#ddd",
                    anchorSize: new naver.maps.Size(10, 10)
                });

                // 클릭 이벤트 추가
                naver.maps.Event.addListener(marker, 'click', function() {
                    if (currentInfoWindow) {
                        currentInfoWindow.close();
                    }
                    infoWindow.open(map, marker);
                    currentInfoWindow = infoWindow;
                });

                marker.infoWindow = infoWindow;
                busStopMarkers.push(marker);
            });
        }

        function updateLocation(position) {
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;
            
            window.dbSet(window.dbRef(window.database, `locations/${shareId}`), {
                latitude: lat,
                longitude: lng,
                timestamp: Date.now()
            });
        }

        function displayLocation(lat, lng) {
            const location = new naver.maps.LatLng(lat, lng);

            if (marker) {
                marker.setPosition(location);
            } else {
                marker = new naver.maps.Marker({
                    position: location,
                    map: map
                });
            }

            map.setCenter(location);
            updateBusStops(location);
            document.getElementById('status').textContent = '위치앱을 켠 상태로';
        }

        function initialize() {
            resetLocation();

            map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(initialLocation.latitude, initialLocation.longitude),
                zoom: 15,
                zoomControl: true,
                mapTypeControl: true
            });

            // 지도 이동 완료 이벤트
            naver.maps.Event.addListener(map, 'idle', function() {
                updateBusStops(map.getCenter());
            });

            if (isMobile() && "geolocation" in navigator) {
                navigator.geolocation.watchPosition(updateLocation, error => {
                    document.getElementById('status').textContent = 
                        `위치 오류: ${error.message}`;
                }, {
                    enableHighAccuracy: true,
                    timeout: 10000,
                    maximumAge: 0
                });
            }

            window.dbOnValue(window.dbRef(window.database, `locations/${shareId}`), (snapshot) => {
                const data = snapshot.val();
                if (data) {
                    displayLocation(data.latitude, data.longitude);
                } else {
                    displayLocation(initialLocation.latitude, initialLocation.longitude);
                }
            });
        }

        window.addEventListener('beforeunload', resetLocation);
        window.onload = initialize;
    </script>
</body>
</html>