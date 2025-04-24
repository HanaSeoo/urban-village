<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Urban & Village 로그인</title>
<style>
body {
	margin: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background-size: cover;
	color: white;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#bg-video {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	z-index: -2;
}


.overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	z-index: -1;
}

.branding-text {
	position: absolute;
	top: 5%;
	width: 100%;
	text-align: center;
	font-size: 48px;
	letter-spacing: 20px;
	font-weight: bold;
}

.login-page {
	position: relative;
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: 150px 100px 100px;
	flex-wrap: wrap;
}

.advertisement {
	
	display: flex;
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	text-align: center; /* 텍스트 가운데 정렬 */
	width: 25%; /* 광고 영역 너비 조정 */
	max-width: 250px; /* 최대 광고 너비 */
	height: 450px; /* 높이 유지 */
	position: relative;
	overflow: hidden;
	border-radius: 15px; /* 모서리 둥글게 */
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); /* 부드러운 그림자 */
	flex-shrink: 0; /* 크기 줄어들지 않도록 */
	margin-top: 60px;
	width: 25%;
}

.advertisement-slide {
	display: none;
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지 비율 유지하며 채우기 */
	border-radius: 15px;
	position: absolute;
	top: 0;
	left: 0;

}

.advertisement-slide.active {
	display: block;
}

.login-container {
	background-color: rgba(255, 255, 255, 0.1);
	padding: 40px;
	border-radius: 12px;
	backdrop-filter: blur(8px);
	width: 400px;
	z-index: 10;
}

.login-container h2 {
	margin-bottom: 20px;
	text-align: center;
}

.input-group {
	margin-bottom: 15px;
}

.input-group label {
	display: block;
	margin-bottom: 5px;
}

.input-field {
	width: 94.5%;
	padding: 10px;
	border-radius: 6px;
	border: none;
}

.login-button {
	width: 100%;
	padding: 12px;
	background-color: #ff385c;
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

.social-login {
	margin-top: 30px;
	text-align: center;
}

.social-button {
	display: block;
	margin-bottom: 10px;
	padding: 10px;
	background-color: #4285F4;
	color: #ffffff;
	text-decoration: none;
	border-radius: 6px;
}



.signup-link {
	text-align: center;
	margin-top: 15px;
	font-size: 14px;
}

.signup-link a {
	color: #fff;
	text-decoration: underline;
}
/* Footer ��Ÿ�� */
.footer {
	background-color: #f8f8f8;
	padding: 20px;
	text-align: center;
	border-top: 1px solid #ddd;
	font-size: 0.8em;
	color: #777;
}

.footer-links {
	margin-bottom: 10px;
}

.footer-links a {
	color: #777;
	text-decoration: none;
	margin: 0 10px;
}

.footer-details {
	line-height: 1.5;
}
.branding-link {
	position: absolute;
	top: 5%;
	left: 0;
	width: 100%;
	text-align: center;
	font-size: 48px;
	letter-spacing: 20px;
	font-weight: bold;
	color: white;
	text-decoration: none;
	cursor: pointer;
	z-index: 10; /* 확실하게 클릭 가능하게 최상단으로! */
}



</style>
<c:choose>
	<c:when test='${param.result == "loginFailed"}'>
		<script>
                alert('아이디나 비밀번호가 틀립니다. 다시 로그인 하세요.');
            </script>
	</c:when>
	<c:when test="${param.result == 'logout' }">
		<script>
                alert('로그아웃 되었습니다. 다시 로그인 하세요.');
            </script>
	</c:when>
	<c:when test="${param.result == 'notLogin' }">
		<script>
                alert('로그인이 되어 있지 않습니다. 로그인 하세요.');
            </script>
	</c:when>
</c:choose>

</head>
<body>
	<video autoplay muted loop playsinline id="bg-video">
    <source src="/Urban_Village/resources/WebSiteImages/bg.mp4" type="video/mp4">
</video>

<div class="overlay"></div>

<!-- ✅ a 태그로 수정 -->
<a href="/Urban_Village/" class="branding-link">Urban & Village</a>




	<div class="login-page">
		<div class="advertisement left-ad">
			<img src="/Urban_Village/resources/image/test.jpg"
				class="advertisement-slide active" alt="광고1"> <img
				src="/Urban_Village/resources/image/test2.jpg"
				class="advertisement-slide" alt="광고2">
		</div>

		<div class="login-container">
			<form action="/Urban_Village/member/login.do" method="post"
				class="login-form">
				<h2>로그인</h2>
				<div class="input-group">
					<label for="id">아이디</label> <input type="text" id="id" name="id"
						class="input-field" required>
				</div>
				<div class="input-group">
					<label for="pwd">비밀번호</label> <input type="password" id="pwd"
						name="pwd" class="input-field" required>
				</div>
				<button type="submit" class="login-button">로그인</button>

				<div class="social-login">
					<h2>소셜 로그인</h2>
					 <a
						href="https://accounts.google.com/o/oauth2/v2/auth?scope=email%20profile&access_type=online&include_granted_scopes=true&response_type=code&state=state_parameter_passthrough_value&redirect_uri=http://localhost:8080/Urban_Village/oauth2callback&client_id=69381954362-11abld4f76jr615qrjqpqoa1ffjok517.apps.googleusercontent.com"
						class="social-button">
						Google 로그인 </a>
				</div>

				<div class="signup-link">
					계정이 없으신가요? <a href="/Urban_Village/member/joinMember.do">회원가입</a>
				</div>
				<div class="signup-link">
					비밀번호를 잊으셨나요? <a href="/Urban_Village/member/findPwd.do">암호찾기</a>
				</div>
			</form>
		</div>

		<div class="advertisement right-ad">
			<img src="/Urban_Village/resources/image/test3.jpg"
				class="advertisement-slide active" alt="광고3"> <img
				src="/Urban_Village/resources/image/test4.jpg"
				class="advertisement-slide" alt="광고4">
		</div>
	</div>
	<div class="footer">
		<div class="footer-links">
			<a href="#">© 2025 Urban&Villiage, Inc.</a> <a href="#">개인 정보 처리
				방침</a> <a href="#">쿠키 정책</a> <a href="#">이용 약관</a> <a href="#">사이트 맵</a>
			<a href="#">한국의 변경된 환불 정책</a> <a href="#">회사 세부 정보</a>
		</div>
		<div class="footer-details">
			웹사이트: Urban&Villiage Ireland UC, private unlimited company, 8 Hanover
			Quay, Dublin 2, D02 DP23 Ireland. (Dermot Clark, Allan Pättwell,
			Andrea Finnegan, VAT 번호: IE9827384L) <a href="mailto:naver.com">알아서
				찾아보쇼</a>. 사이트, 010-1111-1111. 호스팅 서비스 제공업체가 아닙니다. 본 서비스에서 이루어지는 숙박 계약의
			당사자가 아닙니다. 이용자에게 숙소를 제공하는 호스트에게 있습니다.
		</div>
	</div>
	<script>
    //동영상 광고 계속 돌아가게 하는 스크립트
    document.addEventListener('DOMContentLoaded', function () {
        const leftAds = document.querySelectorAll('.left-ad .advertisement-slide');
        const rightAds = document.querySelectorAll('.right-ad .advertisement-slide');
        let leftIndex = 0;
        let rightIndex = 0;

        function changeAd(ads, index, nextIndex) {
            ads[index].classList.remove('active');
            ads[nextIndex].classList.add('active');
        }

        setInterval(() => {
            let nextLeftIndex = (leftIndex + 1) % leftAds.length;
            changeAd(leftAds, leftIndex, nextLeftIndex);
            leftIndex = nextLeftIndex;

            let nextRightIndex = (rightIndex + 1) % rightAds.length;
            changeAd(rightAds, rightIndex, nextRightIndex);
            rightIndex = nextRightIndex;
        }, 5000);
    });

</script>
</body>
</html>
