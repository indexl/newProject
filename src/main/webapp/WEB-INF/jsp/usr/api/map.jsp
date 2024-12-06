<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>검색 후 마커 표시하기</title>
</head>
<body>
<div>
    <input type="text" id="searchInput" placeholder="주소를 입력하세요" style="width:300px;" onkeyup="checkEnter(event)">
    <button onclick="searchLocation()">검색</button>
</div>
<div id="map" style="width:100%;height:350px;margin-top:10px;"></div>

<div id="clickLatlng"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d39ebf45ab30101c92bd6b1126db076c&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), 
        level: 3 
    };

var map = new kakao.maps.Map(mapContainer, mapOption);


var marker = new kakao.maps.Marker({ 
    position: map.getCenter()
}); 
marker.setMap(map);


var geocoder = new kakao.maps.services.Geocoder();


function searchLocation() {
    var address = document.getElementById('searchInput').value;
    
  
    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
        
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            marker.setPosition(coords); 
            map.setCenter(coords);
            
         
            var message = '검색한 위치의 위도는 ' + coords.getLat() + ' 이고, ';
            message += '경도는 ' + coords.getLng() + ' 입니다';
            document.getElementById('clickLatlng').innerHTML = message;
        } else {
            alert("검색 결과가 없습니다. 주소를 확인해주세요.");
        }
    });
}


function checkEnter(event) {
    if (event.keyCode === 13) {
        searchLocation();
    }
}


kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    var latlng = mouseEvent.latLng; 
    
    marker.setPosition(latlng); 
    
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    
    var resultDiv = document.getElementById('clickLatlng'); 
    resultDiv.innerHTML = message;
});
</script>
</body>
</html>