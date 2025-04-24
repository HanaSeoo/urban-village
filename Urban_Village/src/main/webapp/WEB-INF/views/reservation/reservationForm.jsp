<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보 확인 및 결제</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	<style>
	    body {
      background-color: #f7f7f7;
      font-family: 'Helvetica Neue', sans-serif;
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
/* --- End Background Overlay --- */

#bg-video {
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   object-fit: cover;
   z-index: -2;
}
    .pay-container {
      max-width: 600px;
      margin: 40px auto;
      background: white;
      border-radius: 16px;
      padding: 30px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.05);
    }

    .pay-title {
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 25px;
      color: #222;
    }

    .pay-form-label {
      font-weight: 600;
      color: #333;
    }

    .pay-list-group-item {
      border: none;
      background-color: transparent;
      padding: 12px 0;
      border-bottom: 1px solid #eaeaea;
    }

    .pay-list-group-item:last-child {
      border-bottom: none;
    }

    .pay-list-group-item span {
      font-size: 1rem;
      color: #555;
    }

    .pay-list-group-item .fw-bold {
      color: #000;
    }

    .pay-coupon-text {
      color: #008489;
      font-weight: 600;
    }

    .pay-total {
      font-size: 1.2rem;
      font-weight: bold;
      color: #000;
    }

    .pay-original-price {
      font-size: 0.85rem;
      color: #999;
    }

    .pay-button-primary {
      background-color: #ff5a5f;
      border: none;
      color: white;
      font-size: 1.1rem;
      padding: 14px;
      border-radius: 8px;
      width: 100%;
      transition: background-color 0.2s ease;
    }

    .pay-button-primary:hover {
      background-color: #e04850;
    }

    .pay-modal-content {
      border-radius: 12px;
    }

    .pay-modal-title {
      font-weight: 600;
      color: #222;
    }

    .pay-coupon-btn {
      background-color: #00a699;
      border: none;
      color: white;
      padding: 6px 12px;
      border-radius: 6px;
      font-size: 0.9rem;
    }

    .pay-coupon-btn:hover {
      background-color: #007d74;
    }

    .pay-coupon-cancel-btn {
      background-color: transparent;
      border: 1px solid #ccc;
      color: #666;
      padding: 6px 12px;
      border-radius: 6px;
      font-size: 0.9rem;
    }

    .pay-coupon-cancel-btn:hover {
      border-color: #aaa;
      color: #333;
    }

    .pay-form-control {
      border-radius: 8px;
    }

    .pay-list-group {
      border-radius: 8px;
      background-color: #fafafa;
      padding: 16px;
    }
	</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    console.log("✅ DOM 로드 완료");
    // 이 부분에서 IMP 초기화하지 말고 아래에서 함
});

//결제 요청 함수는 전역으로 선언
window.requestPay = function() {
    console.log("결제 요청 시작");
    if (window.IMP) {
        // 세션에서 가져온 값으로 설정
        const name = "${sessionScope.accommodation.accommodation_name}"; // 세션에서 숙소 이름 가져오기
        const amount = parseInt(document.getElementById('finalPriceInput').value, 10); // 스크립트에서 가져온 결제 금액
        const merchant_uid = document.getElementById('reservationIdInput').value; 
        const member_name = "${sessionScope.memberName}"; // 세션에서 예약자 이름 가져오기
        const isLogin = "${sessionScope.loginId}"; // 세션에서 로그인 상태 가져오기

        if (!isLogin) {
            alert("❌ 로그인 후 결제 가능합니다.");
            return;
        }

        const buyer_email = "${sessionScope.memberEmail}"; // 세션에서 이메일 가져오기
        const buyer_tel = "${sessionScope.memberPhone}"; // 세션에서 전화번호 가져오기

        // 결제 요청
        window.IMP.request_pay({
            pg: "nice", // 결제 PG사
            pay_method: "card", // 결제 방법 (카드)
            merchant_uid: merchant_uid, // 주문 고유 번호 (숙소 ID)
            name: name, // 상품 이름
            amount: amount, // 결제 금액
            buyer_email: buyer_email, // 예약자 이메일
            buyer_name: member_name, // 예약자 이름
            buyer_tel: buyer_tel, // 예약자 전화번호
        }, function(rsp) {
            if (rsp.success) {
                alert("✅ 결제가 완료되었습니다!");
                document.getElementById("paymentForm").submit();

            } else {
                alert("❌ 결제에 실패했습니다.\n사유: " + rsp.error_msg);
            }
        });
    } else {
        console.error("❌ IMP가 정의되지 않았습니다. 페이지를 새로고침해 주세요.");
        alert("결제 모듈이 로드되지 않았습니다. 페이지를 새로고침 후 다시 시도해주세요.");
    }
};
</script>
</head>
<body>
<video autoplay muted loop id="bg-video">
   <source
      src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
      type="video/mp4">
</video>
	<div class="pay-container">
		<h2 class="pay-title">🛏️ 예약 정보 확인</h2>
		<form id="paymentForm" action="/Urban_Village/reservation/reservation.do" method="post">

			<div class="mb-3">
				<label class="pay-form-label">숙소 이름</label>
				<input type="text" class="form-control pay-form-control" name="accommodation_name"
					value="${sessionScope.accommodation.accommodation_name}" readonly>
			</div>
			<div class="mb-3">
				<label class="pay-form-label">숙소 ID</label>
				<input type="text" class="form-control pay-form-control" name="accommodation_id"
					value="${sessionScope.accommodation.accommodation_id}" readonly>
			</div>
			<div class="mb-3">
				<label class="pay-form-label">예약 번호</label>
				<input type="text" class="form-control pay-form-control" name="reservation_id" id="reservationIdInput"
					value="<%= new Random().nextInt(900000) + 100000 %>" readonly>
			</div>
			<div class="mb-3">
				<label class="pay-form-label">예약자 성함</label>
				<input type="text" class="form-control pay-form-control" name="id" value="${sessionScope.memberName}"
					readonly>
			</div>
	<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        ${sessionScope.errorMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% session.removeAttribute("errorMessage"); %> <%-- 메시지 표시 후 세션에서 제거 --%>
</c:if>
			<div class="mb-3">
				<label class="pay-form-label">체크인 날짜</label>
				<input type="date" class="form-control pay-form-control" id="checkinInput" name="checkin_date" required>
			</div>
			<div class="mb-3">
				<label class="pay-form-label">체크아웃 날짜</label>
				<input type="date" class="form-control pay-form-control" id="checkoutInput" name="checkout_date"
					required>
			</div>
			<div class="mb-3">
				<label class="pay-form-label">게스트 수</label>
				<input type="number" class="form-control pay-form-control" id="guestsInput" name="guest_count" required>
			</div>

			<div class="mb-3">
				<label class="pay-form-label">💰 결제 상세 내역</label>
				<ul class="list-group pay-list-group">
					<li class="list-group-item pay-list-group-item d-flex justify-content-between"><span>숙박비</span><span
						id="basePrice">- 원</span></li>
					<li class="list-group-item pay-list-group-item d-flex justify-content-between"><span>수수료
							(10%)</span><span id="feePrice">- 원</span></li>
					<li class="list-group-item pay-list-group-item d-flex justify-content-between"><span>청소비</span><span
						id="cleaningFee">5,000원</span></li>
					<li
						class="list-group-item pay-list-group-item d-flex justify-content-between align-items-center">
						<span>쿠폰 할인</span>
						<div class="d-flex align-items-center">
							<span id="couponAmount" class="me-3 text-success fw-bold">0원</span>
							<button type="button" class="btn btn-sm btn-outline-success me-2 pay-coupon-btn"
								onclick="applyCoupon()">쿠폰 사용</button>
							<button type="button" id="cancelCouponBtn"
								class="btn btn-sm btn-outline-danger pay-coupon-cancel-btn" style="display: none;"
								onclick="cancelCoupon()">취소</button>
						</div>
					</li>
					<li
						class="list-group-item pay-list-group-item d-flex justify-content-between fw-bold align-items-center">
						<div>
							<div>총 결제 금액</div>
							<div id="originalPriceText" class="text-muted pay-original-price"></div>
						</div> <span id="finalPriceText">- 원</span>
					</li>
				</ul>

				<input type="hidden" id="totalPriceInput" name="total_price">
				<input type="hidden" id="finalPriceInput" name="final_price">
				<input type="hidden" id="couponIdInput" name="coupon_id">
			</div>

			<button type="button" class="btn btn-primary w-100 pay-button-primary" onclick="requestPay()">💳 결제하기</button>

		</form>
	</div>

	<div class="modal fade" id="couponModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content pay-modal-content">
				<div class="modal-header">
					<h5 class="modal-title pay-modal-title">🎟️ 쿠폰 선택</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<ul class="list-group">
						<c:forEach var="coupon" items="${couponList}">
							<li
								class="list-group-item d-flex justify-content-between align-items-center pay-list-group-item">
								<div>
									<strong>${coupon.coupon_name}</strong> (${coupon.discount}% 할인)<br>
									<small>만료일: ${coupon.expiration_date}</small>
								</div>
								<button type="button" class="btn btn-sm btn-success pay-coupon-btn"
									data-discount="${coupon.discount}"
									data-coupon-id="${coupon.coupon_id}"
									onclick="selectCoupon(this)">선택</button>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
document.addEventListener('DOMContentLoaded', function () {
    const checkin = localStorage.getItem('reservationCheckin');
    const checkout = localStorage.getItem('reservationCheckout');
    const guests = localStorage.getItem('reservationGuests');
    const totalStr = localStorage.getItem('reservationTotalPrice');

    if (checkin) document.getElementById('checkinInput').value = checkin;
    if (checkout) document.getElementById('checkoutInput').value = checkout;
    if (guests) document.getElementById('guestsInput').value = guests;

    if (totalStr) {
        const total = parseInt(totalStr, 10);
        window.originalTotal = total;
        window.currentTotal = total; // 현재 총 금액을 추적하는 변수

        const cleaningFee = 5000;
        const fee = Math.round(total * 0.1);  // 수수료 10%
        const basePrice = total - cleaningFee - fee;

        // 값 업데이트
        document.getElementById('basePrice').textContent = basePrice.toLocaleString() + '원';
        document.getElementById('feePrice').textContent = fee.toLocaleString() + '원';

        // 할인 전 / 후 표시
        document.getElementById('finalPriceText').textContent = total.toLocaleString() + '원';
        document.getElementById('originalPriceText').textContent = '할인전금액 :'+total.toLocaleString()+'원';

        // form 전송용
        document.getElementById('totalPriceInput').value = total;
        document.getElementById('finalPriceInput').value = total;
        document.getElementById('couponIdInput').value = ''; // 초기 쿠폰 ID 비움

        console.log("✅ 총 금액 로딩 완료:", total);
    } else {
        console.log("🔴 예약 정보 로드 실패");
    }
});

// 쿠폰 적용 시
function applyCoupon() {
    const modal = new bootstrap.Modal(document.getElementById('couponModal'));
    modal.show();
}

// 쿠폰 선택 후 적용
function selectCoupon(element) {
    const discountPercent = parseFloat(element.getAttribute('data-discount'));
    const couponId = element.getAttribute('data-coupon-id');

    const total = window.originalTotal;
    const discountAmount = Math.round(total * (discountPercent / 100));
    const newTotal = total - discountAmount;

    // 쿠폰 할인 금액 표시
    document.getElementById('couponAmount').textContent = '-' + discountAmount.toLocaleString() + '원';

    // 최종 결제 금액 업데이트
    document.getElementById('finalPriceText').textContent = newTotal.toLocaleString() + '원';

    // '할인 전' 금액은 원래 금액 그대로 유지
    document.getElementById('originalPriceText').textContent = '할인전금액 :'+total.toLocaleString()+'원';

    // form 전송용
    document.getElementById('finalPriceInput').value = newTotal;
    document.getElementById('couponIdInput').value = couponId;

    // 쿠폰 취소 버튼 보이기
    document.getElementById('cancelCouponBtn').style.display = 'inline-block';

    // 현재 총 금액 업데이트
    window.currentTotal = newTotal;

    // 모달 닫기
    const modal = bootstrap.Modal.getInstance(document.getElementById('couponModal'));
    modal.hide();
}

// 쿠폰 취소 시
function cancelCoupon() {
    // 쿠폰 할인 금액 초기화
    document.getElementById('couponAmount').textContent = '0원';

    // 최종 결제 금액을 원래 금액으로 되돌림
    document.getElementById('finalPriceText').textContent = window.originalTotal.toLocaleString() + '원';

    // form 전송용
    document.getElementById('finalPriceInput').value = window.originalTotal;
    document.getElementById('couponIdInput').value = ''; // 쿠폰 ID 초기화

    // 쿠폰 취소 버튼 숨기기
    document.getElementById('cancelCouponBtn').style.display = 'none';

    // 현재 총 금액 업데이트
    window.currentTotal = window.originalTotal;

    // '할인 전' 금액 다시 표시
    document.getElementById('originalPriceText').textContent = '할인전금액 :'+window.originalTotal.toLocaleString()+'원';
}



</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
   
</script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
    // 스크립트 로드 후 초기화
    if (window.IMP) {
        console.log("✅ 아임포트 로드 성공");
        window.IMP.init("imp58174884");
    } else {
        console.error("❌ 아임포트 로드 실패");
        // 1초 후 다시 시도
        setTimeout(function() {
            if (window.IMP) {
                console.log("✅ 아임포트 지연 로드 성공");
                window.IMP.init("imp58174884");
            } else {
                console.error("❌ 아임포트 지연 로드 실패");
            }
        }, 1000);
    }
</script>
		
</body>
</html>