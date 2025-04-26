<%@page
	import="com.test.Urban_Village.accommodation.dto.AccommodationDTO"%>
<%@page import="java.util.Random"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
// 현재 시간을 타임스탬프로 사용
long currentTimestamp = System.currentTimeMillis();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>

<!-- 달력 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<!-- 한국어 로케일 -->

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4144168e9f9cd514608615aac5e437e5&autoload=false&libraries=services"></script>

<style>
.heart {
	font-size: 24px;
	cursor: pointer;
	color: #ccc;
}

.heart.active {
	color: red;
}

.hidden {
	display: none;
}

.error-message {
	font-size: 0.9em;
	color: red;
	margin-top: 4px;
	margin-bottom: 8px;
}

.accommodation-image-container {
	position: relative;
	width: 800px; /* 숙소 이미지 전체 컨테이너 너비 */
	height: 500px; /* 숙소 이미지 컨테이너 높이 */
	margin: 0 auto; /* 중앙 배치 */
	border: 1px solid #ddd;
	border-radius: 10px;
	overflow: hidden;
	padding: 10px;
}

.accommodation-image {
	width: 100%; /* 컨테이너 크기에 맞춤 */
	height: auto; /* 비율 유지하며 크기 조정 */
	object-fit: cover; /* 비율 유지하며 크기 조정 */
}

/* 이전 및 다음 버튼 스타일 */
.image-navigation {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	width: 100%;
	display: flex;
	justify-content: space-between;
	pointer-events: none; /* 버튼 이외의 영역 클릭 방지 */
}

.nav-button {
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	border-radius: 50%;
	width: 50px;
	height: 50px;
	font-size: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	pointer-events: auto; /* 버튼 클릭 허용 */
}

.nav-button:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

/* 후기 이미지 스타일 */
.review-images img {
	width: 100px; /* 작게 표시 */
	height: 80px;
	object-fit: cover; /* 비율 유지하며 크기 조정 */
	margin: 5px;
	border: 1px solid #ddd;
	border-radius: 5px;
	cursor: pointer;
}

/* 모달 스타일 */
.modal-overlay {
	display: none; /* 초기에는 숨김 */
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 1); /* 완전한 검은색 배경 */
	justify-content: center;
	align-items: center;
	z-index: 9999; /* 가장 위에 표시 */
}

/* 모달 컨텐츠 */
.modal-content {
	position: relative;
	max-width: 80%; /* 모달 너비 */
	max-height: 80%; /* 모달 높이 */
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 10px;
}

/* 모달 이미지 */
.modal-content img {
	width: auto;
	height: auto;
	max-width: 100%;
	max-height: 100%;
	display: block;
}

/* 닫기 버튼 스타일 */
.close-button {
	position: absolute;
	top: 20px; /* 상단 위치 */
	left: 20px; /* 좌측 위치 */
	background: transparent; /* 배경 없음 */
	color: white; /* 텍스트 색상 */
	border: none;
	font-size: 18px; /* 텍스트 크기 */
	font-weight: bold; /* 텍스트 굵기 */
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 5px; /* 아이콘과 텍스트 간격 */
}

.close-button:hover {
	color: #ff6666; /* 호버 시 색상 변경 */
	text-decoration: underline; /* 호버 시 밑줄 추가 */
}

.close-button:focus {
	outline: none;
}

/* 이전 및 다음 버튼 스타일 */
.modal-nav-button {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: rgba(255, 255, 255, 0.5); /* 반투명 배경 */
	color: black;
	border: none;
	border-radius: 50%;
	width: 40px;
	height: 40px;
	font-size: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	z-index: 1001;
}

#modalPrevButton {
	left: 10px;
}

#modalNextButton {
	right: 10px;
}

.modal-nav-button:hover {
	background-color: rgba(255, 255, 255, 0.8); /* 호버 시 배경색 변경 */
}

/* 별점 스타일 */
.star {
	color: #ffc107; /* 노란색 */
	font-size: 20px; /* 별 크기 */
}

.star-empty {
	color: #ddd; /* 비어있는 별의 색상 */
	font-size: 20px; /* 별 크기 */
}
/*베스트숙소랑 인기숙소 글자 깜빡이는거*/
@keyframes blink { 
0% {
opacity: 1;
}50%{ opacity : 0;
}100% { opacity : 1;
}
}

.blink-text {
	text-align: center;
	color: red;
	animation: blink 1s infinite;
}

/*이미지 네모 칸안에 여러개 담는거*/
.image-grid-container {
	display: grid;
	grid-template-columns: 1.5fr 1fr;
	border-radius: 15px;
	overflow: hidden;
	max-width: 1000px;
	margin: 0 auto;
	padding: 15px;
}

.main-image {
	width: 100%;
	aspect-ratio: 3/2;
	overflow: hidden;
	padding: 8px;
}

.main-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 10px;
}

.sub-images {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-template-rows: repeat(2, 1fr);
	gap: 8px;
	height: 100%;
}

.sub-image {
	width: 100%;
	aspect-ratio: 1/1.05;
	overflow: hidden;
}

.sub-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 10px;
}

.more-button button {
	width: 100%;
	height: 100%;
	font-size: 13px;
	font-weight: bold;
	border: none;
	background-color: rgba(255, 255, 255, 0.9);
	border-radius: 10px;
	cursor: pointer;
}

.detail-image-list {
	display: flex;
	flex-direction: column;
	gap: 40px; /* 이미지 간 간격 */
	align-items: center; /* 가운데 정렬 */
	margin-top: 16px;
}

.detail-image-item {
	width: 600px; /* 너비 고정 */
	height: 400px; /* 높이 고정 */
	object-fit: contain; /* 비율 유지하면서 자르기 */
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}
/* flatpickr 달력 스타일 */
.flatpickr-day.reserved,
.flatpickr-day.flatpickr-disabled.reserved {
    background-color: #dc3545 !important; /* 빨간색 배경 */
    color: white !important; /* 흰색 글자 */
    border: 1px solid #dc3545 !important; /* 빨간색 테두리 (선택 사항) */
    cursor: not-allowed !important; /* 선택 불가 커서 */
    opacity: 1 !important; /* 불투명하게 표시 */
    text-decoration: line-through; /* 텍스트에 가로줄 (선택 사항) */
}

.flatpickr-day.reserved:hover,
.flatpickr-day.reserved.selected {
    background-color: #dc3545(255, 0, 0, 0.4) !important;
    color: white !important;
}
.flatpickr-day.reserved:hover {
    background-color: #dc3545 !important; /* 호버 시에도 빨간색 유지 */
    color: white !important;
}
/* 기본 달력 스타일 개선 */
.flatpickr-calendar {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15) !important;
    border-radius: 8px !important;
}

.flatpickr-day.selected, 
.flatpickr-day.startRange, 
.flatpickr-day.endRange {
    background-color: #007bff !important;
    border-color: #007bff !important;
    color: white !important;
}

.flatpickr-day.selected.inRange, 
.flatpickr-day.startRange.inRange, 
.flatpickr-day.endRange.inRange, 
.flatpickr-day.inRange {
    background-color: rgba(0, 123, 255, 0.2) !important;
    border-color: rgba(0, 123, 255, 0.2) !important;
    color: #333 !important;
}

.flatpickr-day:hover {
    background-color: #f0f0f0 !important;
}

/* 오늘 날짜 강조 */
.flatpickr-day.today {
    border-color: #ff6b6b !important;
    background-color: rgba(255, 107, 107, 0.1) !important;
    font-weight: bold !important;
}

.flatpickr-day.today:hover {
    background-color: rgba(255, 107, 107, 0.2) !important;
}
</style>
</head>
<body>

	<main class="container mt-4">
		<div class="d-flex justify-content-between align-items-center">

			<h1 class="fw-bold">🌟
				${sessionScope.accommodation.accommodation_name}</h1>
		</div>
		<p name="commodation_id">숙소 ID
			:${sessionScope.accommodation.accommodation_id}</p>
		<div class="container mt-4">
			<%-- 이미지 분리하는겨 --%>
			<c:set var="imageStr"
				value="${sessionScope.accommodation.accommodation_photo}" />
			<c:set var="images" value="${fn:split(imageStr, ',')}" />

			<div class="image-grid-container">
				<div class="main-image">
					<c:if test="${not empty images}">
						<img
							src="${contextPath}/download.do?imageFileName=${images[0]}&accommodation_id=${sessionScope.accommodation.accommodation_id}"
							alt="숙소 메인 이미지" />
					</c:if>
				</div>
				<div class="sub-images">
					<c:forEach var="img" items="${images}" varStatus="status">
						<c:if test="${status.index > 0 && status.index < 5}">
							<div class="sub-image">
								<img
									src="${contextPath}/download.do?imageFileName=${img}&accommodation_id=${sessionScope.accommodation.accommodation_id}"
									alt="숙소 서브 이미지" />
							</div>
						</c:if>
					</c:forEach>
					<c:if test="${fn:length(images) > 1}">
						<div class="sub-image more-button">
							<button onclick="openImageModal()">사진 모두 보기</button>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		<div>
			<c:forEach var="bestAcc" items="${sessionScope.hostBestAccIdList}">
				<c:if
					test="${sessionScope.accommodation.accommodation_id eq bestAcc.accommodation_id}">
					<h3>
						<p class="blink-text">★ 호스트 추천 숙소 ★</p>
					</h3>
				</c:if>
			</c:forEach>
		</div>
		<c:forEach var="topList" items="${topList}">
			<c:if
				test="${sessionScope.accommodation.accommodation_id eq topList}">
				<h3>
					<p class="blink-text">★예약 1위 숙소★</p>
				</h3>
			</c:if>
		</c:forEach>
		<div class="row">
			<div class="col-md-6">
				<h3 class="fw-bold">${sessionScope.accommodation.price}원/박</h3>

				<input type="text" id="checkin" class="form-control mb-2"
					placeholder="YYYY-MM-DD" readonly> <input type="text"
					id="checkout" class="form-control mb-2" placeholder="YYYY-MM-DD"
					readonly> <label>인원:</label> <select id="guests"
					class="form-control mb-2">
					<option value="1">1명</option>
					<option value="2">2명</option>
					<option value="3">3명</option>
					<option value="4">4명</option>
				</select>
				<p class="fw-bold">
					총 금액: <span id="totalPrice">₩0</span>
				</p>
				<button type="button" class="btn btn-danger w-100"
					onclick="goToReservation()">예약하기</button>

			</div>

			<div class="col-md-6">
				<h3>편의시설 확인</h3>
				<ul>
					<li>✅ WiFi ${sessionScope.accommodation.wifi_avail}</li>
					<li>✅ 침실 갯수 ${sessionScope.accommodation.room_count}</li>
					<li>✅ 화장실 갯수 ${sessionScope.accommodation.bathroom_count}</li>
					<li>✅ 침대 갯수 ${sessionScope.accommodation.bed_count}</li>
				</ul>
				<h3>숙소 규칙</h3>
				<ul>
					<li>🚫 반려동물 금지</li>
					<li>🚫 금연</li>
					<li>🔇 밤 10시 이후 정숙</li>
				</ul>
			</div>
		</div>

		<h3 class="mt-4">위치 :
			${sessionScope.accommodation.accommodation_address}</h3>
		<div id="map" style="width: 100%; height: 400px; background: #ddd;"></div>



		<div class="detailImage">
			<h2>숙소 상세 이미지</h2>
			<c:if test="${not empty images}">
				<div class="detail-image-list">
					<c:forEach var="img" items="${images}" varStatus="status">
						<img class="detail-image-item"
							src="${contextPath}/download.do?imageFileName=${img}&accommodation_id=${sessionScope.accommodation.accommodation_id}" />
					</c:forEach>
				</div>
			</c:if>
		</div>




		<h3 class="mt-4">📝 후기</h3>
		<div id="reviews">
			<c:if test="${not empty reviews}">
				<c:forEach var="review" items="${reviews}">
					<div class="review-item">
						<p>
							<strong>${review.id}</strong> (
							<fmt:formatDate value="${review.created_at}"
								pattern="yyyy년 MM월 dd일 HH시 mm분" />
							):
						</p>
						<div>
							<span>평점: </span>
							<c:forEach begin="1" end="${review.rating}">
								<span class="star">★</span>
							</c:forEach>
							<c:forEach begin="${review.rating + 1}" end="5">
								<span class="star-empty">☆</span>
							</c:forEach>
						</div>
						<p>${review.review_data}</p>
						<c:if test="${not empty review.review_photo}">
							<div class="review-images">
								<c:forEach var="photo"
									items="${fn:split(review.review_photo, ',')}">
									<img
										src="${contextPath}/download1.do?imageFileName=${photo}&review_id=${review.review_id}&timestamp=<%= currentTimestamp %>"
										alt="리뷰 이미지"
										onclick="showModal(this.src, [...document.querySelectorAll('.review-images img')].map(el => el.src))">
								</c:forEach>
							</div>
						</c:if>
					</div>
					<hr>
				</c:forEach>
			</c:if>
			<c:if test="${empty reviews}">
				<p>아직 후기가 없습니다. 첫 번째 후기를 작성해보세요!</p>
			</c:if>
		</div>

		<!-- 이미지 확대 모달 -->
		<div class="modal-overlay" id="imageModal">
			<div class="modal-content">
				<!-- 닫기 버튼 수정 -->
				<button class="close-button" onclick="closeModal()">✖ 닫기</button>
				<img id="modalImage" src="" alt="확대 이미지">
				<!-- 이전 및 다음 버튼 -->
				<button class="modal-nav-button" id="modalPrevButton"
					onclick="showPrevImage()">◀</button>
				<button class="modal-nav-button" id="modalNextButton"
					onclick="showNextImage()">▶</button>
			</div>
		</div>
	</main>

	<script>
// 전역 변수 선언
let imageArray = [];
let currentImageIndex = 0;

// 계산 함수
// 가격 계산 함수
function calculatePrice() {
    const checkinValue = document.getElementById("checkin").value;
    const checkoutValue = document.getElementById("checkout").value;
    const pricePerNight = Number("${sessionScope.accommodation.price}"); // 숙박 요금 가져오기
    const totalPriceElement = document.getElementById("totalPrice");

    console.log("calculatePrice 호출:", checkinValue, checkoutValue, pricePerNight);

    if (checkinValue && checkoutValue) {
        try {
            const checkinDate = new Date(checkinValue);
            const checkoutDate = new Date(checkoutValue);

            // 날짜 차이 계산 (일 단위)
            const timeDiff = checkoutDate.getTime() - checkinDate.getTime();
            const dayDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));

            console.log(`숙박 일수: ${dayDiff}일`);

            if (dayDiff > 0) {
                const totalPrice = dayDiff * pricePerNight;
                totalPriceElement.textContent = "₩" + totalPrice.toLocaleString(); // 총 가격 업데이트
            } else {
                totalPriceElement.textContent = "₩0";
            }
        } catch (e) {
            console.error("가격 계산 중 오류 발생:", e);
            totalPriceElement.textContent = "₩0";
        }
    } else {
        totalPriceElement.textContent = "₩0";
    }
}

// 지도 초기화 함수
function initKakaoMap() {
    kakao.maps.load(() => {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.653, 127.236),
            level: 5
        };
        var map = new kakao.maps.Map(container, options);
        var roadAddress = '${sessionScope.accommodation.accommodation_address}';
        var geocoder = new kakao.maps.services.Geocoder();

        geocoder.addressSearch(roadAddress, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="padding:5px; text-align: center; font-weight: bold; white-space: nowrap;">숙소 : ${sessionScope.accommodation.accommodation_name}</div>'
                });
                infowindow.open(map, marker);
                map.setCenter(coords);
            } else {
                alert("주소를 찾을 수 없습니다.");
            }
        });
    });
}

window.onload = initKakaoMap;

// 예약 페이지 이동 함수
function goToReservation() {
    let checkin = document.getElementById("checkin").value;
    let checkout = document.getElementById("checkout").value;
    let guests = document.getElementById("guests").value;
    let pricePerNight = Number("${sessionScope.accommodation.price}");
    let hasError = false;

    // 기존 에러 메시지 제거
    document.querySelectorAll(".error-message").forEach(el => el.remove());

    // 체크인 유효성 검사
    if (!checkin) {
        if (!document.getElementById("checkin").nextElementSibling?.classList.contains("error-message")) {
            let errorMsg = document.createElement("p");
            errorMsg.className = "error-message";
            errorMsg.textContent = "체크인 날짜를 선택해주세요.";
            document.getElementById("checkin").insertAdjacentElement('afterend', errorMsg);
        }
        document.getElementById("checkin").focus();
        hasError = true;
    }

    // 체크아웃 유효성 검사
    if (!checkout) {
        if (!document.getElementById("checkout").nextElementSibling?.classList.contains("error-message")) {
            let errorMsg = document.createElement("p");
            errorMsg.className = "error-message";
            errorMsg.textContent = "체크아웃 날짜를 선택해주세요.";
            document.getElementById("checkout").insertAdjacentElement('afterend', errorMsg);
        }
        document.getElementById("checkout").focus();
        hasError = true;
    } else if (checkin && checkout && (checkin >= checkout)) {
        if (!document.getElementById("checkout").nextElementSibling?.classList.contains("error-message")) {
            let errorMsg = document.createElement("p");
            errorMsg.className = "error-message";
            errorMsg.textContent = "체크아웃 날짜는 체크인 날짜 이후여야 합니다.";
            document.getElementById("checkout").insertAdjacentElement('afterend', errorMsg);
        }
        document.getElementById("checkin").focus();
        hasError = true;
    }

    // 인원수 유효성 검사
    if (!guests || isNaN(guests) || Number(guests) < 1) {
        if (!document.getElementById("guests").nextElementSibling?.classList.contains("error-message")) {
            let errorMsg = document.createElement("p");
            errorMsg.className = "error-message";
            errorMsg.textContent = "인원수를 선택해주세요.";
            document.getElementById("guests").insertAdjacentElement('afterend', errorMsg);
        }
        document.getElementById("guests").focus();
        hasError = true;
    }

    if (hasError) {
        return;
    }

    // 야간 및 총 가격 계산
    let nights = (new Date(checkout) - new Date(checkin)) / (1000 * 60 * 60 * 24);
    let totalPrice = nights > 0 ? nights * pricePerNight : 0;

    // 로컬 스토리지 저장
    localStorage.setItem('reservationCheckin', checkin);
    localStorage.setItem('reservationCheckout', checkout);
    localStorage.setItem('reservationGuests', guests);
    localStorage.setItem('reservationTotalPrice', totalPrice);

    // 디버깅 메시지
    console.log("예약 정보 저장 완료, 페이지 이동 시도");
    console.log("이동할 경로:", "/Urban_Village/reservation/reservationForm.do");

    // 예약 페이지로 이동
    window.location.href = "${contextPath}/reservation/reservationForm.do";
}

// 이미지 모달 관련 함수
// 모달 표시 함수
function showModal(imageSrc, images, type = 'review') {
    const modal = document.getElementById("imageModal");
    const modalImage = document.getElementById("modalImage");
    const prevButton = document.getElementById("modalPrevButton");
    const nextButton = document.getElementById("modalNextButton");
    
    // 현재 활성화된 모달 타입 저장
    modal.dataset.modalType = type;
    
    // 이미지 배열 초기화 및 현재 인덱스 설정
    imageArray = images;
    currentImageIndex = images.indexOf(imageSrc);

    if (currentImageIndex === -1) {
        console.error("현재 이미지가 배열에서 찾을 수 없습니다.");
        currentImageIndex = 0; // 기본값 설정
    }

    modalImage.src = imageSrc; // 확대할 이미지 설정
    modal.style.display = "flex"; // 모달 표시
    
    // 네비게이션 버튼 표시 결정
    prevButton.style.display = imageArray.length > 1 ? "flex" : "none";
    nextButton.style.display = imageArray.length > 1 ? "flex" : "none";
    
    // 현재 위치에 따른 이전/다음 버튼 활성화
    updateNavigationButtons();
}

// 이전 이미지 표시 함수
function showPrevImage() {
    if (currentImageIndex > 0) {
        currentImageIndex--;
        document.getElementById("modalImage").src = imageArray[currentImageIndex];
        updateNavigationButtons();
    }
}

// 다음 이미지 표시 함수
function showNextImage() {
    if (currentImageIndex < imageArray.length - 1) {
        currentImageIndex++;
        document.getElementById("modalImage").src = imageArray[currentImageIndex];
        updateNavigationButtons();
    }
}

// 네비게이션 버튼 상태 업데이트 함수
function updateNavigationButtons() {
    const prevButton = document.getElementById("modalPrevButton");
    const nextButton = document.getElementById("modalNextButton");
    
    // 첫 번째 이미지일 경우 이전 버튼 비활성화
    if (currentImageIndex === 0) {
        prevButton.style.opacity = "0.5";
        prevButton.style.cursor = "not-allowed";
    } else {
        prevButton.style.opacity = "1";
        prevButton.style.cursor = "pointer";
    }
    
    // 마지막 이미지일 경우 다음 버튼 비활성화
    if (currentImageIndex >= imageArray.length - 1) {
        nextButton.style.opacity = "0.5";
        nextButton.style.cursor = "not-allowed";
    } else {
        nextButton.style.opacity = "1";
        nextButton.style.cursor = "pointer";
    }
}

// 모달 닫기
function closeModal() {
    const modal = document.getElementById("imageModal");
    modal.style.display = "none"; // 모달 숨기기
}

//사진 모두 보기 버튼 클릭 함수
function openImageModal() {
    // 숙소 이미지 URL 수집
    const allAccommodationImages = [];
    
    // 모든 숙소 이미지 엘리먼트 가져오기 (메인 이미지와 서브 이미지 모두)
    const mainImage = document.querySelector('.main-image img');
    const subImages = document.querySelectorAll('.sub-image img:not(.more-button img)');
    
    // 메인 이미지 추가
    if (mainImage) {
        allAccommodationImages.push(mainImage.src);
    }
    
    // 서브 이미지들 추가
    subImages.forEach(img => {
        if (img && img.src) {
            allAccommodationImages.push(img.src);
        }
    });
    
    // 상세 이미지 섹션의 이미지들도 추가
    const detailImages = document.querySelectorAll('.detail-image-item');
    detailImages.forEach(img => {
        if (img && img.src && !allAccommodationImages.includes(img.src)) {
            allAccommodationImages.push(img.src);
        }
    });
    
    // 디버깅 로그
    console.log("처리된 이미지 URL:", allAccommodationImages);
    
    // 첫 번째 이미지로 모달 열기
    if (allAccommodationImages.length > 0) {
        showModal(allAccommodationImages[0], allAccommodationImages, 'accommodation');
    } else {
        alert("표시할 이미지가 없습니다.");
    }
}

// 후기 더보기 기능
function toggleReviews() {
    document.querySelectorAll(".review.hidden").forEach(el => el.classList.toggle("hidden"));
}

// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    // 로컬스토리지 초기화
    localStorage.removeItem('reservationCheckin');
    localStorage.removeItem('reservationCheckout');
    localStorage.removeItem('reservationGuests');
    localStorage.removeItem('reservationTotalPrice');

    // input 초기화
    const checkinInput = document.getElementById('checkin');
    const checkoutInput = document.getElementById('checkout');
    const guestsInput = document.getElementById('guests');
    
    if (checkinInput) checkinInput.value = "";
    if (checkoutInput) checkoutInput.value = "";
    if (guestsInput) guestsInput.selectedIndex = 0; // 첫 번째 옵션 선택
    
    // 리뷰 이미지 클릭 이벤트
    document.querySelectorAll('.review-images img').forEach(img => {
        img.addEventListener('click', () => {
            const reviewImages = [...document.querySelectorAll('.review-images img')].map(el => el.src);
            showModal(img.src, reviewImages, 'review');
        });
    });
});


//Flatpickr 및 날짜 처리를 위한 코드
let reservedDates = [];
$(document).ready(function() {
    const accommodationId = "${sessionScope.accommodation.accommodation_id}";
    
    $.ajax({
        url: "${contextPath}/reservation/getReservedDates.do",
        type: "get",
        data: { accommodation_id: accommodationId },
        success: function(result) {
            console.log("서버에서 받은 데이터:", result);
            
            // 데이터가 있는지 확인
            if (result && Array.isArray(result) && result.length > 0) {
                // 날짜 범위 생성 및 달력 초기화
                reservedDates = processReservationDates(result);
                initFlatpickr(reservedDates);
            } else {
                // 데이터가 없으면 빈 배열로 달력 초기화
                console.log("예약 데이터가 없습니다.");
                initFlatpickr([]);
            }
        },
        error: function(xhr, status, error) {
            console.error("Ajax 요청 실패:", error);
            // 오류 발생시 빈 배열로 달력 초기화
            initFlatpickr([]);
        }
    });
});

function processReservationDates(dateRanges) {
    const disabledDates = [];
    try {
        dateRanges.forEach(range => {
            if (!range || !range.CHECKIN_DATE || !range.CHECKOUT_DATE) {
                console.warn("유효하지 않은 예약 데이터:", range);
                return;
            }

            const checkinDate = new Date(range.CHECKIN_DATE);
            const checkoutDate = new Date(range.CHECKOUT_DATE);
            let currentDate = new Date(checkinDate);

            while (currentDate <= checkoutDate) {
                const year = currentDate.getFullYear();
                const month = String(currentDate.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1 필요
                const day = String(currentDate.getDate()).padStart(2, '0');
                const formattedDate = year + "-" + month + "-" + day; // 백틱 대신 + 연산자 사용
                disabledDates.push(formattedDate);
                currentDate.setDate(currentDate.getDate() + 1);
            }
        });
    } catch (e) {
        console.error("날짜 처리 중 오류 발생:", e);
    }
    console.log("비활성화될 날짜 목록:", disabledDates);
    return disabledDates;
}


function initFlatpickr(disabledDates) {
    // HTML 요소를 텍스트 입력으로 변경 (필요 시)
    if ($("#checkin").attr("type") === "date") {
        $("#checkin").attr("type", "text").attr("readonly", true);
    }
    if ($("#checkout").attr("type") === "date") {
        $("#checkout").attr("type", "text").attr("readonly", true);
    }

    // flatpickr 설정 전 기존 인스턴스 제거 (있는 경우)
    if ($("#checkin")[0]._flatpickr) {
        $("#checkin")[0]._flatpickr.destroy();
    }
    if ($("#checkout")[0]._flatpickr) {
        $("#checkout")[0]._flatpickr.destroy();
    }

    console.log("Flatpickr 초기화 (Range Mode) - 비활성화할 날짜:", disabledDates);

    flatpickr("#checkin", {
        mode: "range", // Range 모드 활성화 (하나의 input에 연결)
        dateFormat: "Y-m-d",
        disable: disabledDates, // 예약된 날짜 선택 불가
        locale: "ko",
        minDate: "today",
        onChange: function(selectedDates, dateStr) {
            console.log("checkinPicker onChange 이벤트 발생:", selectedDates, dateStr);
            if (selectedDates.length === 2) {
                // 두 날짜가 모두 선택되었을 경우, 체크인/체크아웃 input에 값 설정
                const [checkinDate, checkoutDate] = selectedDates;
                $("#checkin").val(flatpickr.formatDate(checkinDate, "Y-m-d"));
                $("#checkout").val(flatpickr.formatDate(checkoutDate, "Y-m-d"));
                calculatePrice();
            } else if (selectedDates.length === 1) {
                // 시작 날짜만 선택되었을 경우, 체크인 input에만 값 설정
                $("#checkin").val(flatpickr.formatDate(selectedDates[0], "Y-m-d"));
                $("#checkout").val(""); // 체크아웃 input 초기화
                $("#totalPrice").text("₩0"); // 시작 날짜만 선택 시 가격 초기화
            } else {
                // 선택이 취소되었을 경우
                $("#checkin").val("");
                $("#checkout").val("");
                $("#totalPrice").text("₩0");
            }
        },
        onMonthChange: function(selectedDates, dateStr, instance) {
            applyReservedStyle(instance, disabledDates);
        },
        onYearChange: function(selectedDates, dateStr, instance) {
            applyReservedStyle(instance, disabledDates);
        }
    });

    // 체크아웃 input 필드는 이제 Flatpickr 인스턴스를 가지지 않습니다.
    // Range 모드는 하나의 input 엘리먼트에 적용됩니다.

    console.log("Flatpickr (Range Mode) 초기화 완료 (checkin input)");
}

// 예약된 날짜에 스타일 적용 (선택 불가 시각적으로 표시)
function applyReservedStyle(instance, disabledDates) {
    instance.days.forEach((dayElement, index) => {
        const date = instance.days[index].dateObj;
        const formattedDate = flatpickr.formatDate(date, "Y-m-d");
        if (disabledDates.includes(formattedDate)) {
            dayElement.classList.add("reserved");
            dayElement.setAttribute("title", "이미 예약된 날짜입니다."); // 추가적인 설명
        } else {
            dayElement.classList.remove("reserved");
            dayElement.removeAttribute("title");
        }
    });
}




</script>
</body>
</html>