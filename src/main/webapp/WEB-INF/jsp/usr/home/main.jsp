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
        <!-- 아이콘 수정 -->
        <link rel="icon" type="image/x-icon" href="/assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Tinos:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&amp;display=swap" rel="stylesheet" />
        <!-- CSS 경로 수정 -->
        <link href="/css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Background Video 수정 -->
        <video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
            <source src="/assets/mp4/bg.mp4" type="video/mp4" />
        </video>
        <!-- Masthead-->
        <div class="masthead">
            <div class="masthead-content text-white">
                <div class="container-fluid px-4 px-lg-0">
                    <h1 class="fst-italic lh-1 mb-4">Our Website is Coming Soon</h1>
                    <p class="mb-5">We're working hard to finish the development of this site. Sign up below to receive updates and to be notified when we launch!</p>
                    <!-- * * * * * * * * * * * * * * *-->
                    <!-- * SB Forms Contact Form * *-->
                    <!-- * * * * * * * * * * * * * * *-->
                    <form id="contactForm" data-sb-form-api-token="API_TOKEN">
                        <div class="row input-group-newsletter">
                            <div class="col"><input class="form-control" id="email" type="email" placeholder="Enter email address..." aria-label="Enter email address..." data-sb-validations="required,email" /></div>
                            <div class="col-auto"><button class="btn btn-primary disabled" id="submitButton" type="submit">Notify Me!</button></div>
                        </div>
                        <div class="invalid-feedback mt-2" data-sb-feedback="email:required">An email is required.</div>
                        <div class="invalid-feedback mt-2" data-sb-feedback="email:email">Email is not valid.</div>
                        <div class="d-none" id="submitSuccessMessage">
                            <div class="text-center mb-3 mt-2">
                                <div class="fw-bolder">Form submission successful!</div>
                                To activate this form, sign up at
                                <br />
                                <a href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>
                            </div>
                        </div>
                        <div class="d-none" id="submitErrorMessage">
                            <div class="text-center text-danger mb-3 mt-2">Error sending message!</div>
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
        <script src="js/scripts.js"></script>
        <!-- SB Forms JS-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>