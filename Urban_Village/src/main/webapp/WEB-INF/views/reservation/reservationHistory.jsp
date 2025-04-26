<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
java.util.Date today = new java.util.Date(); // 현재 날짜
pageContext.setAttribute("today", today); // JSP에서 사용할 수 있도록 설정
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>숙소 예약 내역</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f9f7f2;
	color: #333;
	line-height: 1.6;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

body::before {
	/* --- Background Overlay for Readability --- */
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(253, 252, 249, 0.3); /* 배경 이미지 위에 반투명 흰색 오버레이 */
	z-index: -1;
}

.main-content {
	flex: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 15px;
}

.containerHistory {
	width: 100%;
	max-width: 800px;
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	margin: 15px 0;
}

h1 {
	font-size: 2rem;
	font-weight: 500;
	margin-bottom: 30px;
	text-align: center;
	color: #333;
}

.reservation-item {
	border: 1px solid #eee;
	padding: 20px;
	margin-bottom: 20px;
	border-radius: 8px;
	box-shadow: 0 3px 10px rgba(0, 0, 0, 0.03);
	transition: transform 0.3s ease;
}

.reservation-item:hover {
	transform: translateY(-3px);
}

.row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 12px;
}

.label {
	font-weight: 500;
	color: #333;
}

.value {
	color: #666;
}

.fee-info {
	margin-top: 15px;
	padding-top: 15px;
	border-top: 1px solid #eee;
}

.fee-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 8px;
	font-size: 0.9rem;
	color: #666;
}

.total-row {
	display: flex;
	justify-content: space-between;
	margin-top: 15px;
	padding-top: 15px;
	border-top: 2px solid #eee;
	font-weight: 600;
	font-size: 1.1rem;
}

.btnReview, .btn {
	display: inline-block;
	margin-top: 20px;
	padding: 12px 25px;
	background-color: transparent;
	color: #333;
	border: 1px solid #ccc;
	border-radius: 30px;
	text-align: center;
	text-decoration: none;
	font-size: 0.9rem;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s;
}

.btnReview:hover, .btn:hover {
	background-color: #333;
	color: #fff;
	border-color: #333;
}

.btn.cancel {
	color: #ff5a5f;
	border-color: #ff5a5f;
}

.btn.cancel:hover {
	background-color: #ff5a5f;
	color: #fff;
}

.empty-reservations {
	text-align: center;
	margin-top: 40px;
	padding: 30px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.empty-reservations p {
	font-size: 1.1rem;
	color: #666;
	margin-bottom: 20px;
}

.empty-reservations a {
	text-decoration: none;
	color: inherit;
	display: inline-block;
}

/* 헤더와 푸터 스타일 */
.footer {
	background-color: #f9f7f2;
	padding: 15px 0;
	text-align: center;
	border-bottom: 1px solid #eee;
}

.footer {
	border-top: 1px solid #eee;
	border-bottom: none;
	margin-top: auto;
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
</style>
</head>
<body>
	<video autoplay muted loop id="bg-video">
		<source
			src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
			type="video/mp4">
	</video>


	<div class="main-content">
		<div class="containerHistory">
			<h1>예약 내역</h1>
			<c:if test="${empty reservations}">
				<div class="empty-reservations">
					<p>예약 내역이 없습니다.</p>
					<a href="${contextPath}/accommodation/main.do" class="btn">새
						예약하기</a>
				</div>
			</c:if>
			<c:forEach var="reservation" items="${reservations}">
				<div class="reservation-item">
					<div class="row">
						<div class="label">예약 번호</div>
						<div class="value">${reservation.reservation_id}</div>
					</div>
					<div class="row">
						<div class="label">숙소 이름</div>
						<div class="value">${reservation.accommodation_name}</div>
					</div>
					<div class="row">
						<div class="label">숙소 아이디</div>
						<div class="value">${reservation.accommodation_id}</div>
					</div>
					<div class="row">
						<div class="label">체크인</div>
						<div class="value">
							<fmt:formatDate value="${reservation.checkin_date}"
								pattern="yyyy-MM-dd" />
						</div>
					</div>
					<div class="row">
						<div class="label">체크아웃</div>
						<div class="value">
							<fmt:formatDate value="${reservation.checkout_date}"
								pattern="yyyy-MM-dd" />
						</div>
					</div>
					<div class="row">
						<div class="label">게스트 수</div>
						<div class="value">${reservation.guest_count}</div>
					</div>
					<div class="row">
						<div class="label">청소비</div>
						<div class="value">
							<fmt:formatNumber value="5000" pattern="#,###" />
							원
						</div>
					</div>
					<div class="row">
						<div class="label">수수료 (10%)</div>
						<div class="value">
							<fmt:formatNumber value="${reservation.total_price * 0.1}"
								pattern="#,###" />
							원
						</div>
					</div>
					<div class="row">
						<div class="label">합산 금액</div>
						<div class="value"><fmt:formatNumber value="${reservation.total_price}"
								pattern="#,###" />
							 원</div>
					</div>
					<div class="row">
						<div class="label">쿠폰 할인</div>
						<div class="value text-success">
							<c:choose>
								<c:when test="${not empty reservation.coupon_id}">-<fmt:formatNumber
										value="${reservation.total_price - reservation.final_price}"
										pattern="#,###" /> 원
            					</c:when>
								<c:otherwise> 0 원
           					    </c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="total-row">
						<div class="label">총 가격</div>
						<div class="value">
							<fmt:formatNumber value="${reservation.final_price}"
								pattern="#,###" />
							원
						</div>
					</div>
					<c:choose>
						<c:when test="${reservation.checkin_date > today}">
							<button class="btn cancel"
								onclick="confirmCancel('${reservation.reservation_id}')">
								예약 취소</button>
						</c:when>
						<c:when test="${reservation.checkout_date < today}">
							<a
								href="${contextPath}/review/write?reservation_id=${reservation.reservation_id}&accommodation_name=${reservation.accommodation_name}&accommodation_id=${reservation.accommodation_id}"
								class="btnReview">후기 작성</a>
						</c:when>
						<c:otherwise>
							<p>사용중입니다.</p>
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		</div>
	</div>

	<script>
		// 예약 취소 확인 함수
		function confirmCancel(reservationId) {
			const userConfirmed = confirm("예약을 취소하시겠습니까?");
			if (userConfirmed) {
				// cancel.do 엔드포인트를 호출하여 데이터베이스와 결제 취소를 모두 처리
				const form = document.createElement('form');
				form.method = 'POST';
				form.action = '${contextPath}/reservation/delReservation.do';

				const input = document.createElement('input');
				input.type = 'hidden';
				input.name = 'reservation_id';
				input.value = reservationId;

				form.appendChild(input);
				document.body.appendChild(form);
				form.submit();
			}
		}
	</script>
</body>
</html>