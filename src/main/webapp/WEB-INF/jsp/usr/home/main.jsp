<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>버스 정류장 검색</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/daisyui@2.51.5/dist/full.css" rel="stylesheet" type="text/css">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
    .custom-bg {
      background-image: url('https://source.unsplash.com/1600x900/?bus,city');
      background-size: cover;
      background-position: center;
      min-height: 100vh;
    }
  </style>
</head>
<body class="custom-bg">

  <div class="flex flex-col items-center justify-center min-h-screen bg-black bg-opacity-50 p-4">
    <div class="bg-white p-8 rounded-xl shadow-lg w-full max-w-md">
      <h1 class="text-3xl font-bold mb-4 text-center">버스 정류장 검색</h1>
      <p class="mb-4 text-center text-gray-600">목적지를 입력하고 가까운 버스 정류장을 찾아보세요!</p>
      <form id="busStationForm">
        <div class="form-control mb-4">
          <label class="label">
            <span class="label-text">목적지 입력</span>
          </label>
          <input type="text" id="destination" class="input input-bordered w-full" placeholder="예: 서울역, 강남역">
        </div>
        <div class="flex justify-between">
          <button type="button" id="searchButton" class="btn btn-primary w-1/2 mr-2">검색</button>
          <button type="button" id="clearButton" class="btn btn-secondary w-1/2">초기화</button>
        </div>
      </form>
      <div id="result" class="mt-6 hidden">
        <h2 class="text-xl font-semibold">검색 결과</h2>
        <p id="stationInfo" class="text-gray-700 mt-2"></p>
      </div>
    </div>
  </div>
  
  <script>
    document.getElementById('searchButton').addEventListener('click', function () {
      const destination = document.getElementById('destination').value.trim();
      if (!destination) {
        alert("목적지를 입력해주세요!");
        return;
      }
      
      document.getElementById('stationInfo').innerText = `목적지 "${destination}" 주변의 버스 정류장을 검색 중입니다...`;
      document.getElementById('result').classList.remove('hidden');
    });

    document.getElementById('clearButton').addEventListener('click', function () {
      document.getElementById('destination').value = '';
      document.getElementById('result').classList.add('hidden');
    });
  </script>
</body>
</html>