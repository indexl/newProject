<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>지도 경로</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=${google.maps.api.key}&callback=initMap" async defer></script>
    <script>
        function initMap() {
            const routeData = JSON.parse('${routeData}');
            if (routeData.routes && routeData.routes.length > 0) {
                const directionsRenderer = new google.maps.DirectionsRenderer();
                const directionsService = new google.maps.DirectionsService();
                const map = new google.maps.Map(document.getElementById("map"), {
                    zoom: 14,
                    center: routeData.routes[0].legs[0].start_location
                });
                directionsRenderer.setMap(map);

                const request = {
                    origin: routeData.routes[0].legs[0].start_address,
                    destination: routeData.routes[0].legs[0].end_address,
                    travelMode: google.maps.TravelMode.DRIVING
                };

                directionsService.route(request, function (result, status) {
                    if (status === "OK") {
                        directionsRenderer.setDirections(result);
                    } else {
                        alert("경로를 찾을 수 없습니다: " + status);
                    }
                });
            } else {
                alert("경로 정보를 가져올 수 없습니다.");
            }
        }
    </script>
</head>
<body>
    <h1>지도 경로</h1>
    <div id="map" style="height: 500px;"></div>
</body>
</html>