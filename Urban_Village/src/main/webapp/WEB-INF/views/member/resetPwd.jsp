<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
   isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
/* 기존 스타일은 유지, 아래는 추가 스타일입니다 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f9f7f2;
    color: #333;
    margin: 0;
    padding: 0;
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

.content {
    margin: 0 auto;
    padding: 60px 20px;
    max-width: 600px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

h2 {
    font-size: 2rem;
    font-weight: 500;
    margin-bottom: 30px;
    color: #333;
    text-align: center;
}

.info-box {
    background: #fff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
    width: 100%;
}

.info-box label {
    font-weight: 500;
    color: #444;
}

.form-control {
    border-radius: 10px;
    border: 1px solid #ccc;
    padding: 10px 14px;
    font-size: 1rem;
}

.btn-primary {
    background-color: #333;
    border-color: #333;
    padding: 12px 25px;
    font-weight: 500;
    border-radius: 30px;
    transition: all 0.3s ease;
}

.btn-primary:hover {
    background-color: #555;
    border-color: #555;
}

.error-message {
    font-size: 0.9rem;
    color: #ff5a5f;
    margin-top: 5px;
    margin-bottom: 10px;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
        $(document).ready(function() {
            $("form").submit(function(event) {
               
                var newPwd = $("input[name='newPwd']").val();
                var confirmPwd = $("input[name='confirmPwd']").val();
                var hasError = false;
               

                $(".error-message").remove();

                if (newPwd === "") {
                    $("<p class='error-message'>암호을 입력하세요.</p>").insertAfter($("input[name='newPwd']"));
                    $("input[name='newPwd']").focus();
                    hasError = true;
                } else if (confirmPwd === "") {
                    $("<p class='error-message text-danger'>암호 확인을 입력하세요.</p>")
                    .insertAfter($("input[name='confirmPwd']"));
                 $("input[name='confirmPwd']").focus();
                 hasError = true;
              } else if (newPwd !== confirmPwd) {
                 $("<p class='error-message text-danger'>비밀번호가 일치하지 않습니다.</p>")
                    .insertAfter($("input[name='confirmPwd']"));
                 $("input[name='confirmPwd']").focus();
                 hasError = true;
              }

                if (hasError) {
                    event.preventDefault();
                }
            });
        });
    </script>
</head>
<body>
<video autoplay muted loop id="bg-video">
   <source
      src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
      type="video/mp4">
</video>
   <div class="content">
      <h2>암호수정 페이지</h2>
      <div class="info-box">
         <form action="${contextPath}/member/modPwdMember.do" method="post">
            <c:if test="${memberList != null}">
               <input type="hidden" id="id" name="id" value="${memberList[0].id}">
               <div class="mb-3">
                  <label for="password" class="form-label">비밀번호</label> <input
                     type="text" class="form-control" id="pwd" name="pwd"
                     value="${memberList[0].pwd}">
               </div>
               <div class="mb-3">
                  <label for="newPwd" class="form-label">새로운 비밀번호</label> <input
                     type="password" class="form-control" id="newPwd" name="newPwd">
               </div>
               <div class="mb-3">
                  <label for="newPwd" class="form-label">새로운 비밀번호 확인</label> <input
                     type="password" class="form-control" id="confirmPwd" name="confirmPwd">
               </div>
               
               <button type="submit" class="btn btn-primary">수정하기</button>
            </c:if>
         </form>
      </div>
   </div>
</body>
</html>