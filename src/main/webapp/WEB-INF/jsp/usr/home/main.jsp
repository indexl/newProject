<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="/WEB-INF/jsp/common/sidebar.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>교통 서비스</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
		    body {
		        margin: 0;  /* body의 기본 마진 제거 */
		        padding: 0; /* body의 기본 패딩 제거 */
		        min-height: 100vh;  /* 최소 높이를 뷰포트 높이로 설정 */
		        background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);  /* 전체 배경에 그라데이션 적용 */
		    }
		
		    .content-section {
		        padding: 0;  /* 패딩 제거 */
		        min-height: 100vh;  /* 전체 높이 설정 */
		    }

        .hero-section {
            padding: 60px 0;
            color: white;
            margin: 0;
        }

        .feature-card {
            border-radius: 15px;
            transition: transform 0.3s ease;
            background: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            height: 250px;  /* 모든 카드의 높이를 동일하게 설정 */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .feature-card:hover {
            transform: translateY(-10px);
        }

        .icon-circle {
            width: 80px;
            height: 80px;
            background: #eef2ff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }

        .features-container {
            display: flex;
            justify-content: center;
            margin: 0 auto;
            max-width: 900px;
        }

        .custom-btn {
            padding: 15px 30px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .custom-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }
    </style>
</head>
<body>

    <!-- 메인 콘텐츠 영역 -->
    <div class="content-section">
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row justify-content-center text-center">
                    <div class="col-md-8">
                        <h1 class="display-4 fw-bold mb-4">미래의 교통을 선도합니다</h1>
                        <p class="lead mb-5">스마트하고 효율적인 교통 솔루션으로 더 나은 미래를 만들어갑니다</p>
                        <a href="#" class="btn btn-light btn-lg custom-btn">시작하기</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-5">
            <div class="container">
                <div class="features-container">
                    <div class="row g-4 justify-content-center">
                        <div class="col-md-4">
                            <div class="feature-card p-4">
                                <div class="icon-circle">
                                    <i class="fas fa-bus fa-2x text-primary"></i>
                                </div>
                                <h3 class="h5 text-center mb-3">스마트 버스</h3>
                                <p class="text-muted text-center">실시간 위치 추적 및 도착 정보 제공</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="feature-card p-4">
                                <div class="icon-circle">
                                    <i class="fas fa-bus fa-2x text-primary"></i>
                                </div>
                                <h3 class="h5 text-center mb-3">철도 서비스</h3>
                                <p class="text-muted text-center">편리하고 신속한 철도 교통망</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="feature-card p-4">
                                <div class="icon-circle">
                                    <i class="fas fa-bus fa-2x text-primary"></i>
                                </div>
                                <h3 class="h5 text-center mb-3">카셰어링</h3>
                                <p class="text-muted text-center">경제적이고 환경친화적인 이동 수단</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>