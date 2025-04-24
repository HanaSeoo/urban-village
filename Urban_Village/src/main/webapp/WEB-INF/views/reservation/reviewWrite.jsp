<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>후기 작성</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
        }
        .container {
            width: 100%;
            max-width: 600px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            resize: none;
            margin-bottom: 20px;
        }
        .stars {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .star {
            font-size: 36px;
            color: #ddd;
            cursor: pointer;
            transition: color 0.3s;
        }
        .star:hover,
        .star.selected {
            color: #ffc107;
        }
        .file-upload {
            margin-bottom: 20px;
        }
        .preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
            justify-content: center;
        }
        .preview-container img {
            max-width: 150px;
            max-height: 150px;
            border: 1px solid #ddd;
            border-radius: 5px;
            object-fit: cover;
        }
        .submit-button {
            width: 100%;
            padding: 10px;
            background-color: #ff5a5f;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .submit-button:hover {
            background-color: #e04848;
        }
        /*배경등록 하기*/
        body {
   /* ... 다른 body 스타일 ... */
   /* --- Video Background Styles (기존 배경 이미지 스타일은 주석 처리) --- */
   /*
   background-image: url('/Urban_Village/resources/WebSiteImages/abc.png');
   background-size: cover;
   background-position: center center;
   background-repeat: no-repeat;
   background-attachment: fixed;
   */
   /* --- End Background Image Styles --- */
   /* ... 다른 body 스타일 ... */
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
    </style>
    <script>
        function selectStar(rating) {
            const stars = document.querySelectorAll('.star');
            document.getElementById('rating').value = rating; // 선택한 별 개수를 숨겨진 input에 설정
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('selected');
                } else {
                    star.classList.remove('selected');
                }
            });
        }

        function previewImages(input) {
            const previewContainer = document.getElementById('previewContainer');
            previewContainer.innerHTML = ''; // 기존 미리보기 초기화

            if (input.files) {
                Array.from(input.files).forEach(file => {
                    if (file.size > 2 * 1024 * 1024) { // 2MB 제한
                        alert(`${file.name} 파일 크기가 2MB를 초과합니다.`);
                        input.value = ''; // 파일 초기화
                        return;
                    }
                    const reader = new FileReader();
                    reader.onload = e => {
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        previewContainer.appendChild(img);
                    };
                    reader.readAsDataURL(file);
                });
            }
        }

        function validateForm() {
            const content = document.querySelector('textarea[name="review_data"]').value.trim();
            const rating = document.getElementById('rating').value;

            if (content === '') {
                alert('후기 내용을 입력하세요.');
                return false; // 폼 제출 중단
            }

            if (rating === '0') {
                alert('별점을 선택하세요.');
                return false; // 폼 제출 중단
            }

            return true; // 폼 제출 진행
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
        <h1>후기 작성</h1>
        <form method="post" action="${contextPath}/review/save" enctype="multipart/form-data" onsubmit="return validateForm()">
            <!-- CSRF Token -->
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <!-- 예약 ID -->
            <input type="hidden" name="reservation_id" value="${reservation_id}">
            <!-- 숙소 이름 -->
            <input type="hidden" name="accommodation_name" value="${accommodation_name}">
            <!-- 숙소 아이디 -->
            <input type="hidden" name="accommodation_id" value="${accommodation_id}">
 
            <!-- 별점 -->
            <input type="hidden" id="rating" name="rating" value="3"> <!-- 기본 별점은 3 -->

            <div class="stars">
                <span class="star" onclick="selectStar(1)">★</span>
                <span class="star" onclick="selectStar(2)">★</span>
                <span class="star" onclick="selectStar(3)">★</span>
                <span class="star" onclick="selectStar(4)">★</span>
                <span class="star" onclick="selectStar(5)">★</span>
            </div>
           
            <textarea name="review_data" placeholder="후기를 입력하세요" required></textarea>
            <!-- 파일 첨부 -->
            <div class="file-upload">
                <label for="reviewPhotos">사진 첨부:</label>
                <input type="file" id="reviewPhotos" name="review_photo[]" accept="image/*" multiple onchange="previewImages(this)">
            </div>
            <!-- 미리보기 -->
            <div id="previewContainer" class="preview-container"></div>
            <!-- 제출 버튼 -->
            <button type="submit" class="submit-button">저장</button>
        </form>
    </div>
</body>
</html>