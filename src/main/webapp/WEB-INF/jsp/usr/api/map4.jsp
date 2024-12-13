<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<<<<<<< HEAD

<%@ include file="/WEB-INF/jsp/common/sidebar.jsp"%>
=======
<%@ include file="/WEB-INF/jsp/common/sidebar.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>대전 버스 길찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .search-box {
            margin: 20px 0;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }
        .location-input {
            margin: 10px 0;
        }
        .result-box {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .search-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-button:hover {
            background-color: #45a049;
        }
        input[type="text"] {
            padding: 8px;
            width: 300px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .bus-route {
            margin-top: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-left: 4px solid #4CAF50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>대전 버스 길찾기</h1>
        
        <div class="search-box">
            <div class="location-input">
                <label>출발지: </label>
                <span id="currentLocation">위치 확인 중...</span>
            </div>
            <div class="location-input">
                <label>목적지: </label>
                <input type="text" id="destination" placeholder="목적지를 입력하세요">
                <button class="search-button" onclick="searchRoute()">길찾기</button>
            </div>
        </div>
        
        <div class="result-box" id="routeResult">
            <!-- 검색 결과가 여기에 표시됩니다 -->
        </div>
    </div>

    <script>
        // 현재 위치 정보를 저장할 객체
        let currentLocation = {
            lat: null,
            lng: null
        };

        // 현재 위치 가져오기
        function getCurrentLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        currentLocation.lat = position.coords.latitude;
                        currentLocation.lng = position.coords.longitude;
                        
                        // 위치 정보를 주소로 변환 (Reverse Geocoding)
                        reverseGeocode(currentLocation.lat, currentLocation.lng);
                    },
                    (error) => {
                        console.error("Error getting location:", error);
                        document.getElementById('currentLocation').textContent = 
                            "위치 확인 실패";
                    },
                    {
                        enableHighAccuracy: true,
                        timeout: 5000,
                        maximumAge: 0
                    }
                );
            } else {
                document.getElementById('currentLocation').textContent = 
                    "위치 서비스를 지원하지 않는 브라우저입니다.";
            }
        }

        // 위경도를 주소로 변환
        function reverseGeocode(lat, lng) {
            // 카카오 맵 API를 사용하여 주소 변환
            // 실제 구현 시에는 카카오 맵 API 키가 필요합니다
            $.ajax({
                url: `https://dapi.kakao.com/v2/local/geo/coord2address.json?x=${lng}&y=${lat}`,
                headers: {
                    'Authorization': 'd39ebf45ab30101c92bd6b1126db076c'
                },
                success: function(response) {
                    const address = response.documents[0].address.address_name;
                    document.getElementById('currentLocation').textContent = address;
                },
                error: function() {
                    document.getElementById('currentLocation').textContent = 
                        `위도: ${lat.toFixed(6)}, 경도: ${lng.toFixed(6)}`;
                }
            });
        }

        // 경로 검색
        function searchRoute() {
            const destination = document.getElementById('destination').value;
            if (!destination) {
                alert('목적지를 입력해주세요');
                return;
            }

            // 로딩 표시
            document.getElementById('routeResult').innerHTML = 
                '<div style="text-align: center">경로를 검색 중입니다...</div>';

            // 서버에 경로 검색 요청
            $.ajax({
                url: '/api/route/search',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    startLat: currentLocation.lat,
                    startLng: currentLocation.lng,
                    destination: destination
                }),
                success: function(response) {
                    displayRoute(response);
                },
                error: function(error) {
                    document.getElementById('routeResult').innerHTML = 
                        '<div style="color: red">경로 검색 중 오류가 발생했습니다.</div>';
                }
            });
        }

        // 검색 결과 표시
        function displayRoute(route) {
            const resultDiv = document.getElementById('routeResult');
            let html = '<h2>검색 결과</h2>';

            if (route.routes && route.routes.length > 0) {
                route.routes.forEach((route, index) => {
                    html += `
                        <div class="bus-route">
                            <h3>경로 ${index + 1}</h3>
                            <p>버스 번호: ${route.busNumber}</p>
                            <p>승차 정류장: ${route.startStop}</p>
                            <p>하차 정류장: ${route.endStop}</p>
                            <p>예상 소요 시간: ${route.duration}분</p>
                        </div>
                    `;
                });
            } else {
                html += '<p>검색된 경로가 없습니다.</p>';
            }

            resultDiv.innerHTML = html;
        }

        // 페이지 로드 시 위치 정보 가져오기
        window.onload = getCurrentLocation;

        // Enter 키로 검색 가능하도록 설정
        document.getElementById('destination').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchRoute();
            }
        });
    </script>
</body>
</html>
>>>>>>> f69a36ae011612141db15df28c317a751f2b4592
