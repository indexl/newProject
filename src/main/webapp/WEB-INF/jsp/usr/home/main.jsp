<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Coming Soon - Start Bootstrap Theme</title>

        <!-- Favicon and linking static resources -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.ico" />

        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

        <!-- Google fonts-->
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Tinos:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&amp;display=swap" rel="stylesheet" />

        <!-- Core theme CSS (includes Bootstrap) -->
        <link href="${pageContext.request.contextPath}/static/css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Background Video-->
        <video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
            <source src="${pageContext.request.contextPath}/static/assets/mp4/bg.mp4" type="video/mp4" />
        </video>

        <!-- Masthead-->
        <div class="masthead">
            <div class="masthead-content text-white">
                <div class="container-fluid px-4 px-lg-0">
                    <h1 class="fst-italic lh-1 mb-4">버스정류장 시스템</h1>
                    <p class="mb-5">버스정류장을 착안하여 사용자로 하여금 
                    <br>더 추가된 정보를 제공합니다.  </p>
                    <!-- * * * * * * * * * * * * * * *-->
                    <!-- * * SB Forms Contact Form * *-->
                    <!-- * * * * * * * * * * * * * * *-->
                    <form id="contactForm" data-sb-form-api-token="API_TOKEN">
                        <!-- 아이디 입력란 -->
                        <div class="mb-3">
                            <input class="form-control" id="username" type="text" placeholder="아이디를 입력해주세요..." aria-label="Enter username" data-sb-validations="required" oninput="checkInputs()" />
                        </div>
                        
                        <!-- 비밀번호 입력란 -->
                        <div class="mb-3">
                            <input class="form-control" id="password" type="password" placeholder="비밀번호를 입력해주세요..." aria-label="Enter password" data-sb-validations="required" oninput="checkInputs()" />
                        </div>
                        
                        <!-- 로그인 및 회원가입 버튼 -->
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary" id="submitButton" type="submit" disabled>로그인</button>
                            <button class="btn btn-secondary" id="signupButton" type="button">회원가입</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Social Icons-->
        <div class="social-icons">
            <div class="d-flex flex-row flex-lg-column justify-content-center align-items-center h-100 mt-3 mt-lg-0">
                <a class="btn btn-dark m-3" href="#!"><i class="fab fa-twitter"></i></a>
                <a class="btn btn-dark m-3" href="#!"><i class="fab fa-facebook-f"></i></a>
                <a class="btn btn-dark m-3" href="#!"><i class="fab fa-instagram"></i></a>
            </div>
        </div>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${pageContext.request.contextPath}/static/js/scripts.js"></script>
        <!-- SB Forms JS-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

        <script>
            function checkInputs() {
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                const submitButton = document.getElementById('submitButton');

                // Enable submit button if both username and password are entered
                if (username && password) {
                    submitButton.disabled = false;
                } else {
                    submitButton.disabled = true;
                }
            }
        </script>
    </body>
</html>
