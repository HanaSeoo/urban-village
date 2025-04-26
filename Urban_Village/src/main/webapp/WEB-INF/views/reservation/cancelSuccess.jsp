<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>예약 취소 완료</title>
<style>
/* 예약 취소 완료 페이지 스타일 */

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
.cancel-success-wrap {
    max-width: 800px;
    margin: 50px auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0,0,0,0.1);
}

.cancel-header {
    text-align: center;
    margin-bottom: 30px;
}

.success-icon {
    width: 80px;
    height: 80px;
    background-color: #28a745;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40px;
    margin: 20px auto;
}

.cancel-details {
    margin-bottom: 30px;
}

.detail-table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
}

.detail-table th, .detail-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #ddd;
}

.detail-table th {
    width: 35%;
    text-align: left;
    color: #555;
    background-color: #f9f9f9;
}

.refund-info {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 5px;
    color: #666;
    font-size: 14px;
    margin-top: 20px;
}

.button-area {
    text-align: center;
    margin-top: 30px;
}

.button-area .btn {
    margin: 0 10px;
    padding: 10px 25px;
}


</style>
</head>
<body>
<video autoplay muted loop id="bg-video">
   <source
      src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
      type="video/mp4">
</video>
    <div class="container">
        <div class="cancel-success-wrap">
            <div class="cancel-header">
                <h2>예약 취소가 완료되었습니다</h2>
                <div class="success-icon">✓</div>
            </div>
            
            <div class="cancel-details">
                <h3>취소 내역</h3>
                <table class="detail-table">
                    <tr>
                        <th>예약 번호</th>
                        <td>${cancelInfo.reservation_id}</td>
                    </tr>
                    <tr>
                        <th>숙소명</th>
                        <td>${cancelInfo.accommodation_name}</td>
                    </tr>
                    <tr>
                        <th>체크인</th>
                        <td>${cancelInfo.checkin_date}</td>
                    </tr>
                    <tr>
                        <th>체크아웃</th>
                        <td>${cancelInfo.checkout_date}</td>
                    </tr>
                    <tr>
                        <th>환불 금액</th>
                        <td><fmt:formatNumber value="${cancelInfo.amount}"
								pattern="#,###" />원</td>
                    </tr>
                    <tr>
                        <th>취소 일시</th>
                        <td>${cancelInfo.cancel_date}</td>
                    </tr>
                </table>
                
                <div class="refund-info">
                    <p>환불은 결제 수단에 따라 1~3일 내에 처리됩니다.</p>
                    <p>궁금하신 점은 고객센터로 문의해 주세요.</p>
                </div>
            </div>
            
            <div class="button-area">
                <a href="${pageContext.request.contextPath}/reservation/reservationHistory.do" class="btn btn-primary">예약 내역으로 돌아가기</a>
            </div>
        </div>
    </div>
</body>
</html>