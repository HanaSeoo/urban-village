
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    
    <!-- 구글폰트 + Bootstrap -->
    <link rel="stylesheet"
   href="${contextPath}/resources/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f7f2;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .findPwd-container {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            max-width: 500px;
            width: 100%;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .form-label {
            font-weight: 500;
        }

        .btn-submit {
            background-color: #333;
            color: #fff;
            border-radius: 30px;
            padding: 10px 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #555;
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<video autoplay muted loop id="bg-video">
   <source
      src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
      type="video/mp4">
</video>
    <div class="findPwd-container">
        <h2>비밀번호 찾기</h2>
        <form method="post" action="${contextPath}/member/findPwdForId.do">
            <div class="mb-3">
                <label for="member_id" class="form-label">아이디</label>
                <input type="text" class="form-control" id="member_id" name="member_id" placeholder="아이디를 입력해주세요" required>
            </div>
            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-submit">암호 찾기</button>
            </div>
        </form>
    </div>

</body>
</html>
