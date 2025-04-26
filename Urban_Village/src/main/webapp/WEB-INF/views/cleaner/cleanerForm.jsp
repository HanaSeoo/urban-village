<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클리너 등록</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f7f2;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px;
        }
        
        .container {
            width: 100%;
            max-width: 800px;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin: 50px auto;
        }
        
        h2 {
            font-size: 2rem;
            font-weight: 500;
            margin-bottom: 30px;
            text-align: center;
            color: #333;
        }
        
        .form-label {
            font-weight: 500;
            color: #333;
        }
        
        .form-control {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 10px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #333;
            box-shadow: 0 0 5px rgba(51, 51, 51, 0.2);
        }
        
        .form-control[readonly] {
            background-color: #f9f9f9;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 30px;
            text-align: center;
            text-decoration: none;
            font-size: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background-color: #333;
            color: #fff;
            border: 1px solid #333;
        }
        
        .btn-primary:hover {
            background-color: #222;
            border-color: #222;
        }
        
        .btn-outline-secondary {
            background-color: transparent;
            color: #333;
            border: 1px solid #ccc;
        }
        
        .btn-outline-secondary:hover {
            background-color: #333;
            color: #fff;
            border-color: #333;
        }
        
        
        
        .mb-3 {
            margin-bottom: 1.5rem !important;
        }
    </style>
</head>
<body>
<video autoplay muted loop id="bg-video">
   <source
      src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
      type="video/mp4">
</video>
    
    <div class="main-content">
    <div class="container">
        <c:choose>
            <c:when test="${alreadyApplied}">
                <div class="alert alert-warning text-center mt-5">
                    <h3>이미 클리너로 지원하셨습니다.</h3>
                </div>
            </c:when>
            <c:otherwise>
                <h2>지역 연계 일자리 지원 양식</h2>
            <form action="${contextPath}/cleaner/joinCleaner.do" method="post" enctype="multipart/form-data">
                <!-- member 정보는 출력만 하고 수정 불가 -->
                <div class="mb-3">
                    <label class="form-label">아이디</label>
                    <input type="text" class="form-control" name="member_id" value="${sessionScope.loginId}" readonly />
                </div>
                <div class="mb-3">
                    <label class="form-label">이메일</label>
                    <input type="email" class="form-control" value="${sessionScope.memberPhone}" readonly />
                </div>
                <div class="mb-3">
                    <label class="form-label">생년월일</label>
                    <input type="date" class="form-control" value="${sessionScope.memberBirth}" readonly />
                </div>
                <div class="mb-3">
                    <label class="form-label">성별</label>
                    <input type="text" class="form-control" value="${sessionScope.memberGender}" readonly />
                </div>
                <div class="mb-3">
                    <label class="form-label">전화번호</label>
                    <input type="text" class="form-control" value="${sessionScope.memberPhone}" readonly />
                </div>
                <div class="mb-3">
                    <label class="form-label">이름</label>
                    <input type="text" class="form-control" value="${sessionScope.memberName}" readonly />
                </div>
                <!-- address 입력 -->
                <div class="mb-3">
                    <label class="form-label">주소 검색</label>
                    <div class="input-group mb-2">
                        <input type="text" class="form-control" name="zipNo" id="zipNo" placeholder="우편번호" readonly />
                        <button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">주소 검색</button>
                    </div>
                    <input type="text" class="form-control mb-2" name="address" id="roadAddrPart1" placeholder="도로명 주소" readonly />
                    <input type="text" class="form-control mb-2" name="addrDetail" id="addrDetail" placeholder="상세 주소" />
                </div>
                <div class="mb-3">
                    <label class="form-label">소득 증빙서류 (PDF, 이미지 등)</label>
                    <input type="file" class="form-control" name="income_proof" accept=".pdf,.jpg,.png,.jpeg" required />
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">등록</button>
                </div>
             </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>

    
    <script type="text/javascript">
        function execDaumPostcode() {
            const width = 570;
            const height = 420;
            const left = (window.screen.width / 2) - (width / 2);
            const top = (window.screen.height / 2) - (height / 2);
            window.open(
                "${pageContext.request.contextPath}/cleaner/jusoPopup",
                "jusoPopup",
                `width=${width},height=${height},left=${left},top=${top},scrollbars=yes`
            );
        }
        function jusoCallBack(roadAddrPart1, zipNo) {
            document.getElementById("roadAddrPart1").value = roadAddrPart1;
            document.getElementById("zipNo").value = zipNo;
        }
    </script>
</body>
</html>