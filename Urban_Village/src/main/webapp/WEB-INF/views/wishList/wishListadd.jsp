<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("utf-8");
   long currentTimestamp = System.currentTimeMillis();
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 위시리스트</title>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style>
    :root {
        /* 한옥 느낌의 색상 팔레트 */
        --hanok-brown: #8C634A;
        --hanok-light-brown: #D4BEA2;
        --hanok-beige: #F0E4D4;
        --hanok-dark: #433730;
        --hanok-accent: #BF4342;
    }
    
    body {
    /*   background-size: cover; /* 화면 전체를 덮도록 이미지 크기 조정 */
      background-position: center center; /* 이미지를 화면 중앙에 배치 */
      background-repeat: no-repeat; /* 이미지 반복 금지 */
      background-attachment: fixed; /* 스크롤 시 배경 이미지 고정 */
     */
        font-family: 'Noto Sans KR', sans-serif;
        color: var(--hanok-dark);
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
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    h1 {
        color: var(--hanok-brown);
        text-align: center;
        font-size: 2.5rem;
        margin-bottom: 30px;
        border-bottom: 2px solid var(--hanok-light-brown);
        padding-bottom: 15px;
    }
    
    .wishlist-container {
        width: 90%;
        margin: 20px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    }
    
    .wishlist-item {
        display: flex;
        align-items: center;
        margin-bottom: 25px;
        padding: 20px;
        border: none;
        border-radius: 8px;
        background-color: white;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        text-decoration: none;
    }
    
    .wishlist-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    
    .wishlist-item-wrapper {
        display: flex;
        width: 100%;
        align-items: center;
        text-decoration: none;
        color: inherit;
    }
    
    .wishlist-item img {
        width: 200px;
        height: 150px;
        margin-right: 25px;
        object-fit: cover;
        border-radius: 8px;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
        flex-shrink: 0;
    }
    
    .wishlist-details {
        flex-grow: 1;
        padding: 0 10px;
    }
    
    .wishlist-details h3 {
        margin-top: 0;
        margin-bottom: 10px;
        color: var(--hanok-brown);
        font-size: 1.4rem;
    }
    
    .wishlist-details p {
        color: #666;
        margin-bottom: 8px;
        font-size: 1rem;
    }
    
    .wishlist-actions {
        flex-shrink: 0;
        margin-left: auto;
        padding-left: 15px;
    }
    
    .wishlist-actions button.wishlist-cancel-button {
    padding: 10px 16px;
    border: none;
    background-color: transparent;
    color: #BF4342; /* 분홍색 계열 색상 직접 지정 */
    font-size: 1.5rem;
    cursor: pointer;
    transition: transform 0.2s ease, color 0.2s ease;
    display: flex;
    align-items: center;
}

.wishlist-cancel-button i {
    margin-right: 8px;
    transition: all 0.3s ease;
}

.wishlist-cancel-button:hover {
    transform: scale(1.1);
}

.wishlist-cancel-button:hover i.fa-heart {
    transform: scale(1.2);
}

.wishlist-cancel-button:hover i.fa-heart:before {
    content: "\f7a9"; /* 깨진 하트 아이콘 (fa-heart-broken) */
}

/* 기존 wishlist-actions button 스타일은 일반적인 버튼 스타일로 유지 (선택 사항) */
.wishlist-actions button {
    padding: 10px 16px;
    border: none;
    background-color: transparent;
    color: var(--hanok-accent); /* 필요하다면 다른 기본 색상 지정 */
    font-size: 1.5rem;
    cursor: pointer;
    transition: transform 0.2s ease, color 0.2s ease;
    display: flex;
    align-items: center;
}

.wishlist-actions button i {
    margin-right: 8px;
    transition: all 0.3s ease;
}

.wishlist-actions button:hover {
    transform: scale(1.1);
}

.wishlist-actions button:hover i.fa-heart {
    transform: scale(1.2);
}

.wishlist-actions button:hover i.fa-heart:before {
    content: "\f7a9"; /* 깨진 하트 아이콘 (fa-heart-broken) */
}
    
    .empty-wishlist {
        text-align: center;
        padding: 40px 20px;
        font-style: italic;
        color: #999;
        font-size: 1.2rem;
        background-color: white;
        border-radius: 8px;
    }
    
    .empty-wishlist i {
        font-size: 3rem;
        color: var(--hanok-light-brown);
        margin-bottom: 15px;
        display: block;
    }
    
    .main-button {
        display: block;
        width: 220px;
        margin: 30px auto;
        padding: 12px 25px;
        background-color: var(--hanok-brown);
        color: white;
        text-align: center;
        border-radius: 30px;
        text-decoration: none;
        font-weight: bold;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    
    .main-button:hover {
        background-color: var(--hanok-dark);
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
    
    .accommodation-address i {
        color: var(--hanok-accent);
        margin-right: 5px;
    }
    
    .accommodation-info {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    
    .accommodation-address {
        font-size: 0.9rem;
        color: #777;
        margin-bottom: 6px;
    }
    
    .accommodation-price {
        font-weight: bold;
        color: var(--hanok-dark);
        font-size: 1.1rem;
    }
    
    /* 한옥 문양 장식 */
    .hanok-decoration {
        width: 100%;
        height: 30px;
        background-image: url("${pageContext.request.contextPath}/resources/image/pattern.png");
        background-repeat: repeat-x;
        margin: 20px 0;
        opacity: 0.6;
    }
</style>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    function removeFromWishlist(memberId, accommodationId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/wishList/remove.do",
            type: "POST",
            data: {
                memberId: memberId,
                accommodationId: accommodationId
            },
            success: function(response) {
                if (response === "1") {
                    alert("위시리스트에서 제거되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert("위시리스트 제거에 실패했습니다.");
                }
            },
            error: function(error) {
                console.error("Error removing from wishlist:", error);
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    }
</script>
</head>
<body>
<video autoplay muted loop id="bg-video">
   <source
      src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
      type="video/mp4">
</video>
   <div class="container">
      <h1>나의 가고 싶은 곳</h1>
      <div class="hanok-decoration"></div>
      <div class="wishlist-container">
    <c:choose>
        <c:when test="${not empty wishlistItems}">
            <c:forEach var="wishlistItem" items="${wishlistItems}" varStatus="status">
                <div class="wishlist-item">
                    <c:set var="acc" value="${accommodations[status.index]}" />
                    <a href="${contextPath}/accommodation/accommodationPage.do?accommodation_id=${wishlistItem.accommodationId}&accommodation_name=${acc.accommodation_name}" class="wishlist-item-wrapper">
                        <c:set var="imageStr" value="${acc.accommodation_photo}" />
                        <c:set var="images" value="${fn:split(imageStr, ',')}" />
                        <img src="${contextPath}/download.do?imageFileName=${images[0]}&accommodation_id=${wishlistItem.accommodationId}&timestamp=<%= System.currentTimeMillis() %>"
                            alt="${acc.accommodation_name}">
                        <div class="wishlist-details">
                            <h3>${acc.accommodation_name}</h3>
                            <div class="accommodation-info">
                                <p class="accommodation-address"><i class="fas fa-map-marker-alt"></i> 위치: ${acc.accommodation_address}</p>
                                <p>숙소 ID: ${wishlistItem.accommodationId}</p>
                            
                            </div>
                        </div>
                    </a>
                    <div class="wishlist-actions">
    <button class="wishlist-cancel-button" onclick="removeFromWishlist('${wishlistItem.memberId}', '${wishlistItem.accommodationId}')">
        <i class="fas fa-heart"></i> 취소
    </button>
</div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-wishlist">
                <i class="far fa-heart"></i>
                <p>아직 위시리스트에 저장된 숙소가 없습니다.</p>
                <p>마음에 드는 한옥 숙소를 찾아 하트를 눌러보세요!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
   
      <div class="hanok-decoration"></div>
      
   </div>

</body>
</html>