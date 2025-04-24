<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>쿠폰 목록 - Urban&Village</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    body {
      margin: 0;
      font-family: 'Arial', sans-serif;
      background-color: #fdfdfd;
      color: #333;
      padding: 20px;
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

    .container {
      max-width: 1100px;
      margin: 0 auto;
    }

    .coupon-container {
      padding: 20px;
    }

    .coupon-header {
      text-align: center;
      margin-bottom: 40px;
    }

    .coupon-header h1 {
      font-size: 2.5em;
      font-weight: bold;
      color: #800020;
    }

    .coupon-header p {
      color: #800020;
    }

    .coupon-section {
      margin-bottom: 60px;
    }

    .coupon-section h2 {
      font-size: 1.8em;
      color: #800020;
      margin-bottom: 20px;
      border-bottom: 2px solid #800020;
      padding-bottom: 10px;
    }

    .coupon-list {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
      justify-content: center;
    }

    .coupon-card {
      background-color: #fff0f6;
      border: 2px dashed #ff80c0;
      border-radius: 16px;
      width: 300px;
      padding: 30px 20px;
      box-shadow: 0 6px 14px rgba(0,0,0,0.06);
      transition: transform 0.3s;
      position: relative;
      text-align: center;
    }

    .coupon-card:hover {
      transform: translateY(-5px);
    }

    .coupon-title {
      font-size: 1.5em;
      font-weight: bold;
      color: #800020;
      margin-bottom: 10px;
    }

    .coupon-detail {
      font-size: 1.1em;
      margin: 8px 0;
    }

    .coupon-code {
      background-color: #fff;
      padding: 8px 12px;
      border-radius: 8px;
      display: inline-block;
      font-weight: bold;
      font-size: 1.1em;
      color: #333;
      border: 1px solid #ffc0cb;
      margin-top: 10px;
    }

    .coupon-footer {
      margin-top: 15px;
    }

    .use-btn {
      background-color: #FF80C0;
      border: none;
      color: white;
      padding: 10px 18px;
      font-size: 1em;
      border-radius: 10px;
      cursor: pointer;
      transition: background 0.3s;
    }

    .use-btn:hover {
      background-color: #e667af;
    }

    .use-btn.disabled {
      background-color: #ccc;
      cursor: not-allowed;
    }

    .coupon-icon {
      font-size: 2.5em;
      color: #ff80c0;
      margin-bottom: 10px;
    }

    .ribbon {
      width: 80px;
      height: 80px;
      overflow: hidden;
      position: absolute;
      top: -5px;
      left: -5px;
    }

    .ribbon span {
      position: absolute;
      display: block;
      width: 120px;
      padding: 5px 0;
      background: #ff80c0;
      color: #fff;
      font-size: 0.8em;
      font-weight: bold;
      text-align: center;
      transform: rotate(-45deg);
      transform-origin: 0 0;
    }

    .ribbon.danger span {
      background: #ff5e5e;
      animation: blink 1s infinite;
    }

    @keyframes blink {
      0%, 100% { opacity: 1; }
      50% { opacity: 0.4; }
    }

    /* 사용된 쿠폰 카드 회색 스타일 */
    .used {
      background-color: #f0f0f0;
      border: 2px dashed #bbb;
    }

    .used .coupon-title,
    .used .coupon-code,
    .used .coupon-detail,
    .used .coupon-icon {
      color: #800020 !important;
    }

    @media (max-width: 768px) {
      .coupon-list {
        flex-direction: column;
        align-items: center;
      }
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
  <div class="coupon-container">
    <div class="coupon-header">
      <h1>🎁 내 쿠폰함</h1>
      <p>사용 가능한 쿠폰과 사용 완료된 쿠폰을 확인하세요</p>
    </div>

    <!-- ✅ 미사용 쿠폰 -->
    <div class="coupon-section">
      <h2>🟢 사용 가능한 쿠폰</h2>
      <div class="coupon-list">
        <c:forEach var="c" items="${couponList}">
          <div class="coupon-card">
            <div class="ribbon"><span>NEW</span></div>
            <div class="coupon-icon"><i class="fas fa-ticket-alt"></i></div>
            <div class="coupon-title">${c.coupon_name}</div>
            <div class="coupon-detail">유효기간: <strong>${c.expiration_date}</strong></div>
            <div class="coupon-code">${c.coupon_id}</div>
            <div class="coupon-footer">
              <button class="use-btn" onclick="location.href='${contextPath}/accommodation/main.do'">🎉 사용하기</button>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>

    <!-- ✅ 사용된 쿠폰 -->
    <div class="coupon-section">
      <h2>🔒 사용 완료된 쿠폰</h2>
      <div class="coupon-list">
        <c:forEach var="c" items="${coupon}">
          <div class="coupon-card used">
            <div class="coupon-icon"><i class="fas fa-check-circle"></i></div>
            <div class="coupon-title">${c.coupon_name}</div>
            <div class="coupon-detail">사용일자: <strong>${c.used_date}</strong></div>
            <div class="coupon-code">${c.coupon_id}</div>
            <div class="coupon-footer">
              <button class="use-btn disabled" disabled>✔️ 사용 완료</button>
            </div>
          </div>
        </c:forEach>
      </div>

    </div>

  </div>
</div>

<script>

</script>
</body>
</html>
