<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>경로 찾기</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_GOOGLE_API_KEY&callback=initMap" async defer></script>
    <style>
        #map {
            height: 500px;
            width: 100%;
        }
    </style>
    <script>
        let map, directionsService, directionsRenderer;

        function initMap() {
            directionsService = new google.maps.DirectionsService();
            directionsRenderer = new google.maps.DirectionsRenderer();
            
            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 14,
                center: { lat: 37.5665, lng: 126.9780 } // 서울 좌표
            });
            directionsRenderer.setMap(map);
        }

        function calculateRoute() {
            const destination = document.getElementById("destination").value.trim();

            if (!destination) {
                alert("목적지를 입력해주세요!");
                return;
            }

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    const origin = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    
                    const request = {
                        origin: origin,
                        destination: destination,
                        travelMode: google.maps.TravelMode.DRIVING
                    };
                    
                    directionsService.route(request, function (result, status) {
                        if (status === google.maps.DirectionsStatus.OK) {
                            directionsRenderer.setDirections(result);
                        } else {
                            alert("경로를 찾을 수 없습니다: " + status);
                        }
                    });
                });
            } else {
                alert("현재 위치를 가져올 수 없습니다.");
            }
        }
    </script>
</head>
<body onload="initMap()">
    <h1>경로 찾기</h1>
    <label for="destination">목적지:</label>
    <input type="text" id="destination" placeholder="예: 강남역">
    <button onclick="calculateRoute()">경로 찾기</button>
    <div id="map"></div>
</body>
</html>