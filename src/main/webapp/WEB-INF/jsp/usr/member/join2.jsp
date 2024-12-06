<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Register</title>

<!-- Custom fonts for this template-->
<link
	href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css"
	rel="stylesheet">

</head>

<body
	class="bg-gradient-primary d-flex justify-content-center align-items-center"
	style="height: 100vh;">
	<div class="container">
		<div class="card o-hidden border-0 shadow-lg mx-auto"
			style="max-width: 600px; width: 100%;">
			<div class="card-body p-0">
				<div class="row justify-content-center">
					<div class="col-lg-12 d-flex justify-content-center">
						<div class="p-5" style="width: 100%;">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">회원가입</h1>
							</div>
							<form action="doJoin" method="post"
								onsubmit="joinForm_onSubmit(this); return false;">
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" name="loginId" class="form-control form-control-user"
											placeholder="아이디">
										<input id="loginIdDupChkMsg" class="mt-2 text-sm h-5 w-96">
									</div>

									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text"  name="name" class="form-control form-control-user"
											placeholder="이름">
									</div>
								</div>
								
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user"
											 placeholder="비밀번호">
									</div>
									<div class="col-sm-6">
										<input type="text" class="form-control form-control-user"
											 placeholder="비밀번호 확인">
									</div>
								</div>			
									<tr>
									    <td colspan="2">
									        <div class="flex justify-center">
									            <button type="submit" class="btn btn-active btn-wide">가입</button>
									        </div>
									    </td>
									</tr>
									
							</form>
							<hr>
							<div class="text-center">
								<a class="small" href="forgot-password.html">비밀번호를 잊어버리셨나요?</a>
							</div>
							<div class="text-center">
								<a class="small" href="/usr/member/login">기존 계정이 있다면 로그인해
									주세요!</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		let validLoginId = null;

		const joinForm_onSubmit = function(form) {
			form.loginId.value = form.loginId.value.trim();
			form.loginPw.value = form.loginPw.value.trim();
			form.pwChk.value = form.pwChk.value.trim();
			form.name.value = form.name.value.trim();

			if (form.loginId.value.length == 0) {
				alert('아이디를 입력해주세요');
				form.loginId.focus();
				return;
			}

			if (form.loginId.value != validLoginId) {
				alert('[ ' + form.loginId.value + ' ] 은(는) 사용할 수 없는 아이디입니다');
				form.loginId.value = '';
				form.loginId.focus();
				return;
			}

			if (form.loginPw.value.length == 0) {
				alert('비밀번호를 입력해주세요');
				form.loginPw.focus();
				return;
			}

			if (form.name.value.length == 0) {
				alert('이름을 입력해주세요');
				form.name.focus();
				return;
			}

			if (form.loginPw.value != form.pwChk.value) {
				alert('비밀번호가 일치하지 않습니다');
				form.loginPw.value = '';
				form.pwChk.value = '';
				form.loginPw.focus();
				return;
			}

			form.submit();
		}

		const loginIdDupChk = function(el) {
			el.value = el.value.trim();

			let loginIdDupChkMsg = $('#loginIdDupChkMsg');

			if (el.value.length == 0) {
				loginIdDupChkMsg.removeClass('text-green-500');
				loginIdDupChkMsg.addClass('text-red-500');
				loginIdDupChkMsg.html(`<span>아이디는 필수 입력 정보입니다</span>`);
				return;
			}

			$.ajax({
				url : '/usr/member/loginIdDupChk',
				type : 'GET',
				data : {
					loginId : el.value
				},
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						loginIdDupChkMsg.removeClass('text-red-500');
						loginIdDupChkMsg.addClass('text-green-500');
						loginIdDupChkMsg
								.html(`<span>\${data.resultMsg }</span>`);
						validLoginId = el.value;
					} else {
						loginIdDupChkMsg.removeClass('text-green-500');
						loginIdDupChkMsg.addClass('text-red-500');
						loginIdDupChkMsg
								.html(`<span>\${data.resultMsg }</span>`);
						validLoginId = null;
					}
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			})
		}
	</script>
</body>