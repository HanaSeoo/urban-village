<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클리너 등록</title>
    
    <link rel="stylesheet" href="${contextPath}/resources/css/style.css"> 
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap');
        
        body {
            font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', Dotum, Gulim, sans-serif;
            margin: 0;
            padding: 15px 0;
            background-color: #faf7f2;
            color: #4e3629;
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

        h1 {
            font-size: 32px;
            font-weight: 700;
            margin: 15px 0 30px 0;
            text-align: center;
            letter-spacing: 1px;
            color: #8b5a2b;
            position: relative;
            padding-bottom: 15px;
        }
        
        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: #d4a76a;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 15px auto;
            padding: 20px;
        }

        .accommodation-card {
            background-color: #fff;
            border: 1px solid #e0d6c6;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.3s;
        }

        .accommodation-card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .accommodation-card p {
            margin: 12px 0;
            font-size: 16px;
            color: #4e3629;
        }
        
        .accommodation-card strong {
            color: #8b5a2b;
            font-weight: 600;
        }

        .accommodation-card input[type="text"] {
            width: 100%;
            max-width: 300px;
            padding: 10px 12px;
            font-size: 15px;
            border: 1px solid #e0d6c6;
            border-radius: 10px;
            margin-top: 5px;
            background-color: #fdfbf7;
            color: #4e3629;
        }
        
        .accommodation-card input[type="text"]:focus {
            outline: none;
            border-color: #d4a76a;
            box-shadow: 0 0 5px rgba(212, 167, 106, 0.3);
        }

        .accommodation-card input[type="submit"] {
            margin-top: 20px;
            padding: 12px 28px;
            font-size: 15px;
            font-weight: bold;
            color: #fff;
            background-color: #8b5a2b;
            border: 2px solid #8b5a2b;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .accommodation-card input[type="submit"]:hover {
            background-color: #d4a76a;
            border-color: #d4a76a;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(139, 90, 43, 0.3);
        }

        .no-data {
            text-align: center;
            font-size: 17px;
            color: #8b5a2b;
            margin-top: 40px;
            padding: 30px;
            background-color: #fff;
            border-radius: 16px;
            border: 1px solid #e0d6c6;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .hanok-divider {
            height: 30px;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
            background-repeat: repeat-x;
            background-size: 100px 20px;
            margin: 20px 0;
        }
        
        @media (max-width: 900px) {
            .container {
                padding: 15px 10px;
            }
            
            .accommodation-card {
                padding: 20px;
            }
            
            .accommodation-card input[type="submit"] {
                padding: 10px 18px;
                font-size: 14px;
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
    <h1>비어있는 숙소 리스트</h1>
    <div class="hanok-divider"></div>
    
    <div class="container">
        <c:if test="${empty accListByCleanerNull}">
            <p class="no-data">비어있는 숙소가 없습니다.</p>
        </c:if>
        <c:forEach var="acc" items="${accListByCleanerNull}" varStatus="status">
            <form action="${contextPath}/cleaner/addCleanerId.do" method="post">
                <div class="accommodation-card">
                    <p><strong>숙소 ID:</strong> ${acc.accommodation_id}</p>
                    <input type="hidden" name="accommodation_id" value="${acc.accommodation_id}">
                    <p><strong>숙소 이름:</strong> ${acc.accommodation_name}</p>
                    <p><strong>청소 관리자 ID:</strong></p>
                    <input type="text" name="cleaner_admin_id" id="add_${status.index}" placeholder="청소 관리자 ID를 입력하세요">
                    <input type="submit" value="이곳에 배정">
                </div>
            </form>
        </c:forEach>
    </div>
    
    <div class="hanok-divider"></div>
    
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const member_id = localStorage.getItem('addAccMemberId');
        if (member_id) {
            document.querySelectorAll('input[id^="add_"]').forEach(input => {
                input.value = member_id;
            });
        }
    });
    </script>
</body>
</html>