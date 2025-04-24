<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<title>숙소 예약</title>
<style>
/* 기존 스타일 유지 */
.accommodation {
	border: none;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
	max-width: 400px;
	background-color: #fff;
	transition: transform 0.2s;
}

.accommodation:hover {
	transform: scale(1.02);
}

.accommodation>a {
	text-decoration: none;
	color: black;
	display: block;
}

.accommodation img {
	width: 100%;
	height: 250px;
	object-fit: cover;
}

.details {
	padding: 16px;
}

.details h3 {
	margin: 0;
	font-size: 18px;
	font-weight: 600;
}

.details p {
	margin: 4px 0;
	color: #555;
	font-size: 14px;
}

.heart-icon {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 22px;
	cursor: pointer;
	color: white;
	text-shadow: 0 0 4px rgba(0, 0, 0, 0.5);
	z-index: 2;
}

.heart-icon.liked {
	color: red;
}

.accommodation {
	position: relative;
}

@keyframes blinker {
	0% {
		opacity: 1;
		transform: scale(1);
		box-shadow: 0 0 10px 2px rgba(255, 193, 7, 0.8);
	}
	50% {
		opacity: 0.3;
		transform: scale(1.1);
		box-shadow: 0 0 20px 5px rgba(255, 193, 7, 1);
	}
	100% {
		opacity: 1;
		transform: scale(1);
		box-shadow: 0 0 10px 2px rgba(255, 193, 7, 0.8);
	}
}

.host-recommendation {
	position: absolute;
	top: 10px;
	left: 10px;
	background-color: #ffc107;
	color: #000;
	padding: 6px 10px;
	border-radius: 6px;
	font-size: 0.95em;
	font-weight: bold;
	z-index: 10;
	animation: blinker 0.8s ease-in-out infinite;
	text-shadow: 1px 1px 2px #fff;
}


/* 새로운 슬라이더 스타일 */
.hero-slider-wrapper {
	width: 100%;
	height: 500px;
	position: relative;
	overflow: hidden;
	margin-bottom: 50px;
}

.hero-slides {
	position: absolute;
	width: 100%;
	height: 100%;
}

.hero-slide {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	opacity: 0;
	transition: opacity 1s ease-in-out;
	background-position: center;
	background-size: cover;
}

.hero-slide.active {
	opacity: 1;
	z-index: 10;
}

.slide-content {
	position: absolute;
	bottom: 80px;
	left: 50%;
	transform: translateX(-50%);
	background-color: rgba(0, 0, 0, 0.7);
	color: white;
	padding: 20px 30px;
	border-radius: 10px;
	text-align: center;
	max-width: 600px;
	width: 80%;
	z-index: 20;
}

.slide-content h3 {
	margin-top: 0;
	margin-bottom: 10px;
	font-size: 24px;
}

.slide-content p {
	margin: 0;
	font-size: 16px;
}

/* 네비게이션 버튼 */
.slide-nav {
	position: absolute;
	bottom: 30px;
	left: 0;
	right: 0;
	text-align: center;
	z-index: 30;
}

.slide-nav-dots {
	display: inline-flex;
	background-color: rgba(0, 0, 0, 0.5);
	padding: 8px 15px;
	border-radius: 20px;
	gap: 10px;
}

.slide-dot {
	width: 14px;
	height: 14px;
	border-radius: 50%;
	background-color: rgba(255, 255, 255, 0.5);
	cursor: pointer;
	transition: all 0.3s ease;
	border: none;
}

.slide-dot.active {
	background-color: white;
	transform: scale(1.2);
}

.slide-arrow {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	width: 50px;
	height: 50px;
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	border-radius: 50%;
	font-size: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: background-color 0.3s ease;
	z-index: 30;
}

.slide-arrow:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

.slide-arrow.prev {
	left: 20px;
}

.slide-arrow.next {
	right: 20px;
}

/* 슬라이드 진행 표시기 */
.progress-bar {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 4px;
	background-color: rgba(255, 255, 255, 0.7);
	width: 0;
	z-index: 40;
	transition: width 0.1s linear;
}

/* 기존 스타일 유지 (짧게 요약) */
.accommodation, .about-us-container, .accommodations {
	/* 기존 스타일 유지... */
	
}

.prev-button, .next-button {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background: none;
	border: none;
	font-size: 2em;
	color: white;
	cursor: pointer;
	padding: 10px;
	z-index: 10;
	opacity: 0.7;
	transition: opacity 0.3s ease;
}

.prev-button:hover, .next-button:hover {
	opacity: 1;
}

.prev-button {
	left: 20px;
}

.next-button {
	right: 20px;
}

/* About Us 섹션 스타일은 유지 */
.about-us-container {
	padding: 50px 20px;
	text-align: center;
	background-color: #f9f9f9;
}

.about-us-title {
	font-size: 2.5em;
	margin-bottom: 30px;
}

.about-us-content {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-wrap: wrap; /* 화면이 작아지면 아래로 내려가도록 */
	max-width: 1200px;
	margin: 0 auto;
}

.about-us-image {
	flex: 1;
	max-width: 300px;
	margin: 20px;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	opacity: 0;
	transform: translateX(-50px);
	transition: opacity 0.5s ease-out, transform 0.5s ease-out;
}

.about-us-image.show {
	opacity: 1;
	transform: translateX(0);
}

.about-us-image img {
	width: 100%;
	display: block;
	height: auto;
	object-fit: cover;
}

.about-us-text {
	flex: 2;
	min-width: 300px;
	padding: 20px;
	text-align: left;
	opacity: 0;
	transform: translateX(50px);
	transition: opacity 0.5s ease-out 0.3s, transform 0.5s ease-out 0.3s;
	/* 약간의 딜레이 */
}

.about-us-text.show {
	opacity: 1;
	transform: translateX(0);
}

.about-us-paragraph {
	line-height: 1.6;
	margin-bottom: 15px;
}

.accommodations {
	display: grid;
	/* 3개의 카드를 동일한 너비로 배치하고 최소 너비도 고정 */
	grid-template-columns: repeat(3, minmax(350px, 1fr));
	/* 예시 너비: 350px */
	gap: 20px;
	padding: 20px;
}

.accommodation-card {
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.accommodation-card a {
	display: flex;
	flex-direction: column;
	text-decoration: none;
	color: inherit;
	width: 100%;
	height: 100%;
}

.image-container {
	position: relative;
	width: 100%;
	/* 목표 비율에 맞춰 높이 설정 (예: 가로:세로 = 4:3 비율) */
	padding-bottom: 75%; /* (세로 / 가로) * 100 = (3 / 4) * 100 = 75% */
	overflow: hidden;
	border-bottom: 1px solid #eee;
}

.image-container img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 자르기 */
}

.host-recommendation {
	position: absolute;
	top: 10px;
	left: 10px;
	background-color: #ffc107;
	color: white;
	padding: 5px 8px;
	border-radius: 5px;
	font-size: 0.9em;
	z-index: 10;
}

@
keyframes blinker { 50% {
	opacity: 0;
}

}
.blink {
	animation: blinker 1s linear infinite;
}

.heart-icon {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 1.2em;
	color: #ccc;
	cursor: pointer;
	z-index: 10;
}

.heart-icon.liked {
	color: red;
}

.details {
	padding: 15px;
}

.details h3 {
	margin-top: 0;
	font-size: 1.2em;
	margin-bottom: 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.info-row {
	display: flex;
	align-items: center;
	margin-bottom: 8px;
	font-size: 0.9em;
	color: #777;
}

.info-row p:first-child {
	margin-right: 5px;
	color: #ffc107;
}

.price {
	font-weight: bold;
	color: #333;
	margin-bottom: 10px;
}

.review-summary, .no-review {
	font-size: 0.9em;
	color: #555;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

/* 슬라이더 인디케이터 스타일 추가 */
.slider-indicators {
	position: absolute;
	bottom: 20px;
	left: 50%;
	transform: translateX(-50%);
	display: flex;
	gap: 10px;
	z-index: 10;
}

.slider-indicator {
	width: 12px;
	height: 12px;
	border-radius: 50%;
	background-color: rgba(255, 255, 255, 0.5);
	cursor: pointer;
	transition: all 0.3s ease;
}

.slider-indicator.active {
	background-color: white;
	transform: scale(1.2);
	box-shadow: 0 0 5px rgba(255, 255, 255, 0.7);
}

.search-bar {
	width: 95%;
	margin-bottom: 10px;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
const contextPath = '${contextPath}';

function toggleWishlist(element, memberId, accommodationId) {
    $.ajax({
        url: contextPath + '/wishList/check.do',
        method: 'POST',
        data: {
            memberId: memberId,
            accommodationId: accommodationId
        },
        success: function(response) {
            if (response === "true") {
                // 이미 찜한 상태면 제거
                removeFromWishlist(memberId, accommodationId, element);
            } else {
                // 찜 안한 상태면 추가
                addToWishlist(memberId, accommodationId, element);
            }
        },
        error: function() {
            alert("고객으로 로그인을 해주세요. 찜 처리 중 오류가 발생했습니다.");
        }
    });
}

function addToWishlist(memberId, accommodationId, element) {
    $.ajax({
        url: contextPath + '/wishList/add.do',
        method: 'POST',
        data: {
            memberId: memberId,
            accommodationId: accommodationId
        },
        success: function(response) {
            if (response == "1") {
                // 찜 성공 시 하트 아이콘 상태 변경
                $(element).addClass("liked").html("&#9829;"); // ♥
                alert("위시리스트에 추가되었습니다."); // 추가 성공 메시지
            }
        },
        error: function() {
            alert("찜 추가 중 오류 발생");
        }
    });
}

function removeFromWishlist(memberId, accommodationId, element) {
    $.ajax({
        url: contextPath + '/wishList/remove.do',
        method: 'POST',
        data: {
            memberId: memberId,
            accommodationId: accommodationId
        },
        success: function(response) {
            if (response == "1") {
                // 찜 제거 시 하트 아이콘 원래대로
                $(element).removeClass("liked").html("&#9825;"); // ♡
                alert("위시리스트에서 제거되었습니다."); // 삭제 성공 메시지
            }
        },
        error: function() {
            alert("찜 삭제 중 오류 발생");
        }
    });
}

$(document).ready(function() {
    // about-us 섹션 애니메이션
    $(window).scroll(function() {
        var scrollPosition = $(window).scrollTop();
        var aboutUsContainer = $('.about-us-container');
        var aboutUsOffsetTop = aboutUsContainer.offset().top;
        var windowHeight = $(window).height();

        // about-us 컨테이너의 상단이 윈도우 하단보다 위에 있고,
        // about-us 컨테이너의 하단이 윈도우 상단보다 아래에 있을 때 (화면에 보일 때)
        if (aboutUsOffsetTop < scrollPosition + windowHeight && aboutUsOffsetTop + aboutUsContainer.outerHeight() > scrollPosition) {
            $('.about-us-image').addClass('show');
            $('.about-us-text').addClass('show');
        }
    });
});
/*위에 사진 슬라이더*/
document.addEventListener('DOMContentLoaded', function() {
        // 슬라이드 요소들
        const slides = document.querySelectorAll('.hero-slide');
        const prevButton = document.querySelector('.slide-arrow.prev');
        const nextButton = document.querySelector('.slide-arrow.next');
        const dotsContainer = document.querySelector('.slide-nav-dots');
        const progressBar = document.querySelector('.progress-bar');
        
        // 변수 초기화
        let currentSlide = 0;
        let slideInterval;
        const intervalTime = 4000; // 4초
        const slidesCount = slides.length;
        
        // 닷 네비게이션 생성
        for (let i = 0; i < slidesCount; i++) {
            const dot = document.createElement('button');
            dot.classList.add('slide-dot');
            if (i === 0) dot.classList.add('active');
            dot.setAttribute('data-slide', i);
            dot.addEventListener('click', () => {
                goToSlide(i);
                resetInterval();
            });
            dotsContainer.appendChild(dot);
        }
        
        // 초기 프로그레스 바 시작
        startProgressBar();
        
        // 슬라이드 전환 함수
        function goToSlide(n) {
            // 현재 활성화된 슬라이드 비활성화
            slides[currentSlide].classList.remove('active');
            document.querySelector('.slide-dot.active').classList.remove('active');
            
            // 새 슬라이드 활성화
            currentSlide = (n + slidesCount) % slidesCount;
            slides[currentSlide].classList.add('active');
            document.querySelectorAll('.slide-dot')[currentSlide].classList.add('active');
            
            // 프로그레스 바 리셋
            resetProgressBar();
        }
        
        // 다음 슬라이드로 이동
        function nextSlide() {
            goToSlide(currentSlide + 1);
        }
        
        // 이전 슬라이드로 이동
        function prevSlide() {
            goToSlide(currentSlide - 1);
        }
        
        // 프로그레스 바 시작
        function startProgressBar() {
            // 프로그레스 바 초기화
            progressBar.style.width = '0%';
            
            // 애니메이션 적용
            progressBar.style.transition = `width ${intervalTime}ms linear`;
            progressBar.style.width = '100%';
        }
        
        // 프로그레스 바 리셋
        function resetProgressBar() {
            progressBar.style.transition = 'none';
            progressBar.style.width = '0%';
            
            // 리플로우 강제
            void progressBar.offsetWidth;
            
            // 애니메이션 다시 시작
            startProgressBar();
        }
        
        // 인터벌 리셋
        function resetInterval() {
            clearInterval(slideInterval);
            slideInterval = setInterval(() => {
                nextSlide();
            }, intervalTime);
            startProgressBar();
        }
        
        // 버튼 이벤트 리스너
        prevButton.addEventListener('click', () => {
            prevSlide();
            resetInterval();
        });
        
        nextButton.addEventListener('click', () => {
            nextSlide();
            resetInterval();
        });
        
        // 키보드 이벤트 리스너
        document.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowLeft') {
                prevSlide();
                resetInterval();
            } else if (e.key === 'ArrowRight') {
                nextSlide();
                resetInterval();
            }
        });
        
        // 자동 슬라이드 시작
        resetInterval();
        
        // 페이지 가시성 변경 시 인터벌 관리
        document.addEventListener('visibilitychange', () => {
            if (document.hidden) {
                clearInterval(slideInterval);
            } else {
                resetInterval();
                resetProgressBar();
            }
        });
        
        // 슬라이더에 마우스 호버 시 일시정지
        const sliderWrapper = document.querySelector('.hero-slider-wrapper');
        sliderWrapper.addEventListener('mouseenter', () => {
            clearInterval(slideInterval);
            progressBar.style.animationPlayState = 'paused';
        });
        
        sliderWrapper.addEventListener('mouseleave', () => {
            resetInterval();
            resetProgressBar();
        });
        
        // 터치 이벤트를 위한 변수
        let touchStartX = 0;
        let touchEndX = 0;
        
        // 터치 이벤트 리스너
        sliderWrapper.addEventListener('touchstart', (e) => {
            touchStartX = e.changedTouches[0].screenX;
        }, { passive: true });
        
        sliderWrapper.addEventListener('touchend', (e) => {
            touchEndX = e.changedTouches[0].screenX;
            handleSwipe();
        }, { passive: true });
        
        // 스와이프 처리
        function handleSwipe() {
            const swipeThreshold = 50; // 스와이프 감지 임계값
            
            if (touchEndX < touchStartX - swipeThreshold) {
                // 왼쪽으로 스와이프
                nextSlide();
                resetInterval();
            } else if (touchEndX > touchStartX + swipeThreshold) {
                // 오른쪽으로 스와이프
                prevSlide();
                resetInterval();
            }
        }
    });

</script>
</head>

<body>

	<!-- 새로운 슬라이더 구현 -->
	<div class="hero-slider-wrapper">
		<div class="hero-slides">
			<div class="hero-slide active"
				style="background-image: url('${contextPath}/resources/WebSiteImages/aaa.png')">
				<div class="slide-content">
					<h3>한옥과 현대적 감각의 조화</h3>
					<p>동묘앞 도보 5분 거리 스테이</p>
				</div>
			</div>
			<div class="hero-slide"
				style="background-image: url('${contextPath}/resources/WebSiteImages/abc.png')">
				<div class="slide-content">
					<h3>5-6월 얼리투숙 시 10% 할인</h3>
					<p>서촌 여행을 계획 중이라면 이곳으로</p>
				</div>
			</div>
			<div class="hero-slide"
				style="background-image: url('${contextPath}/resources/WebSiteImages/bbb.jpg')">
				<div class="slide-content">
					<h3>한적한 곳에서의 휴식</h3>
					<p>자연과 함께하는 시간</p>
				</div>
			</div>
			<div class="hero-slide"
				style="background-image: url('${contextPath}/resources/WebSiteImages/ccc.jpg')">
				<div class="slide-content">
					<h3>기획&마케팅 분야 8인의 베스트 스테이</h3>
					<p>완벽한 서울 도심 속 힐링</p>
				</div>
			</div>
			<div class="hero-slide"
				style="background-image: url('${contextPath}/resources/WebSiteImages/ddd.jpg')">
				<div class="slide-content">
					<h3>신규 오픈 숙소</h3>
					<p>지금 예약하고 할인 혜택 받기</p>
				</div>
			</div>
			<div class="hero-slide"
				style="background-image: url('${contextPath}/resources/WebSiteImages/eee.jpeg')">
				<div class="slide-content">
					<h3>휴식이 필요할 때</h3>
					<p>편안한 분위기의 객실</p>
				</div>
			</div>
			<div class="hero-slide"
				style="background-image: url('${contextPath}/resources/WebSiteImages/fff.jpg')">
				<div class="slide-content">
					<h3>도심 속 한적한 공간</h3>
					<p>여유로운 시간을 만끽하세요</p>
				</div>
			</div>
			<div class="hero-slide"
				style="background-image: url('${contextPath}/resources/WebSiteImages/ggg.jpg')">
				<div class="slide-content">
					<h3>특별한 날을 위한 특별한 공간</h3>
					<p>최고의 뷰와 서비스</p>
				</div>
			</div>
		</div>

		<!-- 프로그레스 바 -->
		<div class="progress-bar"></div>

		<!-- 네비게이션 화살표 -->
		<button class="slide-arrow prev">&#10094;</button>
		<button class="slide-arrow next">&#10095;</button>

		<!-- 슬라이드 네비게이션 닷 -->
		<div class="slide-nav">
			<div class="slide-nav-dots">
				<!-- 자바스크립트로 동적 생성 -->
			</div>
		</div>
	</div>


	<div class="container">
		<form method="get"
			action="${contextPath}/accommodation/searchAccommodation">
			<div class="search-bar">
				<input type="text" name="keyword" placeholder="어디로 떠날까요?">
				<button>검색</button>
			</div>
		</form>

		<div class="categories-container">
			<div class="categories">
				<a
					href="${contextPath}/accommodation/searchAddress?keyword=김천ㆍ칠곡ㆍ고령ㆍ성주">김천
					ㆍ 칠곡 ㆍ 고령 ㆍ 성주</a> <a
					href="${contextPath}/accommodation/searchAddress?keyword=구미ㆍ상주ㆍ의성ㆍ문경">구미
					ㆍ 상주 ㆍ 의성 ㆍ 문경</a> <a
					href="${contextPath}/accommodation/searchAddress?keyword=예천ㆍ안동ㆍ영주ㆍ봉화">예천
					ㆍ 안동 ㆍ 영주 ㆍ 봉화</a> <a
					href="${contextPath}/accommodation/searchAddress?keyword=영양ㆍ울진ㆍ영덕ㆍ청송">영양
					ㆍ 울진 ㆍ 영덕 ㆍ 청송</a> <a
					href="${contextPath}/accommodation/searchAddress?keyword=포항ㆍ영천ㆍ경주ㆍ경산">포항
					ㆍ 영천 ㆍ 경주 ㆍ 경산</a> <a
					href="${contextPath}/accommodation/searchAddress?keyword=한옥ㆍ울릉ㆍ청도ㆍ독도">울릉
					ㆍ 청도 ㆍ 독도</a>
			</div>
		</div>
		<div style="text-align: right; margin: 20px;">
			<form method="get" action="${contextPath}/accommodation/sortedList">
				<button type="submit" name="sort" value="reservation"
					class="sort-button-icon">
					<i class="fas fa-star"></i> 예약 많은 순
				</button>
				<button type="submit" name="sort" value="views"
					class="sort-button-icon">
					<i class="fas fa-eye"></i> 조회수 많은 순
				</button>
			</form>
		</div>
		<div class="accommodations">
            <c:forEach items="${searchResults}" var="accommodation">
				<div class="accommodation-card">
					<div class="image-container">
						<a
							href="${pageContext.request.contextPath}/accommodation/accommodationPage.do?accommodation_id=${accommodation.accommodation_id}&accommodation_name=${accommodation.accommodation_name}">
							<c:set var="imageStr"
								value="${accommodation.accommodation_photo}" /> <c:set
								var="images" value="${fn:split(imageStr, ',')}" /> <img
							src="${contextPath}/download.do?imageFileName=${images[0]}&accommodation_id=${accommodation.accommodation_id}&timestamp=<%= System.currentTimeMillis() %>"
							alt="${accommodation.accommodation_name}"> <c:forEach
								var="bestAcc" items="${hostBestAccIdList}">
								<c:if
									test="${accommodation.accommodation_id eq bestAcc.accommodation_id}">
									<p class="host-recommendation blink">★ 호스트 추천 숙소 ★</p>
								</c:if>
							</c:forEach>
						</a> 
						<c:forEach items="${accommodationList}" var="accommodationList">
						<span class="heart-icon ${accommodationList.liked ? 'liked' : ''}"
							onclick="event.stopPropagation(); toggleWishlist(this, '${loginId}', '${accommodation.accommodation_id}')">
							&#10084; </span>
						</c:forEach>
					</div>
					<a
						href="${pageContext.request.contextPath}/accommodation/accommodationPage.do?accommodation_id=${accommodation.accommodation_id}&accommodation_name=${accommodation.accommodation_name}">
						<div class="details">
							<h3>${accommodation.accommodation_name}</h3>
							<div class="info-row">
								<p>★ ${accommodation.averageRating}</p>
								<c:set var="addrParts"
									value="${fn:split(accommodation.accommodation_address, ' ')}" />
								<p>${addrParts[0]}${addrParts[1]}</p>
							</div>
							<p>수용인원 : ${accommodation.capacity}명</p>
							<p class="price">₩ ${accommodation.price} / 박</p>
							<c:if test="${not empty accommodation.latestReview}">
								<p class="review-summary">게스트 한마디:
									${accommodation.latestReview}</p>
							</c:if>
							<c:if test="${empty accommodation.latestReview}">
								<p class="no-review">아직 리뷰가 없습니다.</p>
							</c:if>
								<p>조회수: ${accommodation.view_count}</p>
								<p>예약수: ${accommodation.reservation_count}</p>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>

		<div class="about-us-container">
			<h2 class="about-us-title">저희가 이 사이트를 만든 이유</h2>
			<div class="about-us-content">
				<div class="about-us-image">
					<img src="${contextPath}/resources/WebSiteImages/aaa.png"
						alt="여행 사진 1">
				</div>
				<div class="about-us-text">
					<p class="about-us-paragraph">저희는 여행을 사랑하고, 특히 아름다운 경상북도의 숨겨진
						보석 같은 숙소들을 발견하는 것을 좋아합니다.</p>
					<p class="about-us-paragraph">기존의 숙박 예약 플랫폼들은 너무 많은 정보와 복잡한
						인터페이스로 사용자들이 진정으로 원하는 숙소를 찾기 어렵게 만들 때가 많습니다.</p>
					<p class="about-us-paragraph">그래서 저희는 경상북도의 특별하고 매력적인 숙소들을 한눈에
						보여주고, 쉽고 빠르게 예약할 수 있는 플랫폼을 만들고자 했습니다.</p>
					<p class="about-us-paragraph">저희의 목표는 사용자들이 번거로움 없이 완벽한 숙소를 찾아
						행복한 여행 경험을 만드는 데 기여하는 것입니다.</p>
				</div>
				<div class="about-us-image">
					<img src="${contextPath}/resources/WebSiteImages/ggg.jpg"
						alt="여행 사진 2">
				</div>
			</div>
		</div>
</body>
</html>