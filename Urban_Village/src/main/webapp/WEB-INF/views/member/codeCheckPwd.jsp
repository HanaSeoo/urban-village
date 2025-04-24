<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이메일 인증</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f7f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
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
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h3 {
            font-size: 1.5rem;
            margin-bottom: 25px;
            color: #333;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 30px;
            background-color: #333;
            color: #fff;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #555;
        }

        .text-danger {
            color: #ff5a5f;
            font-size: 0.95rem;
            margin-bottom: 15px;
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
        <h3>이메일로 전송된 코드를 입력하세요</h3>

        <c:if test="${not empty codeError}">
            <p class="text-danger">${codeError}</p>
        </c:if>

        <form action="${contextPath}/member/checkCode.do" method="post">
            <input type="hidden" name="member_id" value="${member_id}" />
            <input type="text" name="code" placeholder="인증 코드 입력" required />
            <button type="submit">확인</button>
        </form>
    </div>

    <c:if test="${codeSuccess}">
        <script>
            alert("암호수정 페이지로 이동합니다.");
            location.href = "${contextPath}/member/resetPwd.do?id=${member_id}";
        </script>
    </c:if>
</body>
</html>
