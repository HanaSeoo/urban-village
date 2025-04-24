<%@page import="com.test.Urban_Village.accommodation.dto.AccommodationDTO"%>
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
    long currentTimestamp = System.currentTimeMillis();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>후기 리스트</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4144168e9f9cd514608615aac5e437e5&libraries=services"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* 전체 컨테이너 가운데 정렬 */
#reviews {
    max-width: 800px;
    margin: 0 auto;
}

/* 후기 카드 스타일 */
.review-item {
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    background-color: #fff;
}

/* 이미지 영역 스타일 */
.review-images {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    margin-top: 10px;
}

.review-images img {
    width: 100px;
    height: 80px;
    object-fit: cover;
    margin: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    cursor: pointer;
}

/* 별점 스타일 */
.star {
    color: #ffc107;
    font-size: 20px;
}
.star-empty {
    color: #ddd;
    font-size: 20px;
}

/* 삭제 버튼 정렬 */
.delete-btn-container {
    text-align: right;
    margin-top: 10px;
}

/* 모달 스타일 */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 1);
    justify-content: center;
    align-items: center;
    z-index: 9999;
}
.modal-content {
    position: relative;
    max-width: 80%;
    max-height: 80%;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px;
}
.modal-content img {
    width: auto;
    height: auto;
    max-width: 100%;
    max-height: 100%;
    display: block;
}
.close-button {
    position: absolute;
    top: 20px;
    left: 20px;
    background: transparent;
    color: white;
    border: none;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
}
.modal-nav-button {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(255, 255, 255, 0.5);
    color: black;
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    font-size: 20px;
    cursor: pointer;
}
#modalPrevButton {
    left: 10px;
}
#modalNextButton {
    right: 10px;
}
</style>
</head>

<body>
<main class="container mt-4">
    <h3 class="text-center mb-4">📝 후기 리스트</h3>
    <div id="reviews">
        <c:forEach var="review" items="${reviewList}">
            <div class="review-item">
                <p>
                    <strong>${review.id}</strong>
                    (
                    <fmt:formatDate value="${review.created_at}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
                    )
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
                        <c:forEach var="photo" items="${fn:split(review.review_photo, ',')}">
                            <img
                                src="${contextPath}/download1.do?imageFileName=${photo}&review_id=${review.review_id}&timestamp=<%= currentTimestamp %>"
                                alt="리뷰 이미지"
                                onclick="showModal(this.src, [...document.querySelectorAll('.review-images img')].map(el => el.src))">
                        </c:forEach>
                    </div>
                </c:if>
                <div class="delete-btn-container">
                    <form action="${contextPath}/review/deleteReview.do" method="post" style="display:inline;">
                        <input type="hidden" name="review_id" value="${review.review_id}">
                        <button type="submit" class="btn btn-sm btn-outline-danger"
                            onclick="return confirm('정말로 이 후기를 삭제하시겠습니까?');">삭제</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 이미지 확대 모달 -->
    <div class="modal-overlay" id="imageModal">
        <div class="modal-content">
            <button class="close-button" onclick="closeModal()">✖ 닫기</button>
            <img id="modalImage" src="" alt="확대 이미지">
            <button class="modal-nav-button" id="modalPrevButton" onclick="showPrevImage()">◀</button>
            <button class="modal-nav-button" id="modalNextButton" onclick="showNextImage()">▶</button>
        </div>
    </div>
</main>

<script>
let imageArray = [];
let currentImageIndex = 0;

function showModal(imageSrc, images, type = 'review') {
    const modal = document.getElementById("imageModal");
    const modalImage = document.getElementById("modalImage");

    imageArray = images;
    currentImageIndex = images.indexOf(imageSrc);

    modalImage.src = imageSrc;
    modal.style.display = "flex";
    updateNavigationButtons();
}

function showPrevImage() {
    if (currentImageIndex > 0) {
        currentImageIndex--;
        document.getElementById("modalImage").src = imageArray[currentImageIndex];
        updateNavigationButtons();
    }
}

function showNextImage() {
    if (currentImageIndex < imageArray.length - 1) {
        currentImageIndex++;
        document.getElementById("modalImage").src = imageArray[currentImageIndex];
        updateNavigationButtons();
    }
}

function updateNavigationButtons() {
    const prevButton = document.getElementById("modalPrevButton");
    const nextButton = document.getElementById("modalNextButton");

    prevButton.style.opacity = currentImageIndex === 0 ? "0.5" : "1";
    prevButton.style.cursor = currentImageIndex === 0 ? "not-allowed" : "pointer";

    nextButton.style.opacity = currentImageIndex === imageArray.length - 1 ? "0.5" : "1";
    nextButton.style.cursor = currentImageIndex === imageArray.length - 1 ? "not-allowed" : "pointer";
}

function closeModal() {
    document.getElementById("imageModal").style.display = "none";
}
</script>
</body>
</html>
