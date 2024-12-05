<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%> 
    
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Login</title>

    <!-- Custom fonts for this template-->
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin-2.min.css" rel="stylesheet">

</head>
</html>
<body class="bg-gradient-primary d-flex justify-content-center align-items-center" style="height: 100vh;">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg mx-auto" style="max-width: 500px; width: 100%;">
            <div class="card-body p-0">
                <div class="row justify-content-center">
                    <div class="col-lg-12 d-flex justify-content-center">
                        <div class="p-5" style="width: 100%;">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">로그인</h1>
                            </div>
                            <form class="user">
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user"
                                        id="exampleInputEmail" aria-describedby="emailHelp"
                                        placeholder="아이디">
                                </div>
                                <div class="form-group">
                                    <input type="password" class="form-control form-control-user"
                                        id="exampleInputPassword" placeholder="비밀번호">
                                </div>
                                <div class="form-group">
                                    <div class="custom-control custom-checkbox small">
                                        <input type="checkbox" class="custom-control-input" id="customCheck">
                                        <label class="custom-control-label" for="customCheck">아이디 기억하기</label>
                                    </div>
                                </div>
                                <a href="index.html" class="btn btn-primary btn-user btn-block">
                                    로그인
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgot-password.html">비밀번호를 잊어버리셨나요?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="/usr/member/join">계정이 없다면 회원가입 해주세요!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>