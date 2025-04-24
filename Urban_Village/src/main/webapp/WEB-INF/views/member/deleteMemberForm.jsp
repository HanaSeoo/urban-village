<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Noto Sans KR', sans-serif;
        color: #222;
        background-color: #fff;
        line-height: 1.4;
    }
    
    .globe-btn {
        background: none;
        border: none;
        font-size: 16px;
        cursor: pointer;
    }
    
    .profile-menu {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 5px 8px 5px 15px;
        border: 1px solid #ddd;
        border-radius: 30px;
        cursor: pointer;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.08);
    }
    
    .menu-icon {
        font-size: 16px;
    }
    
    .user-avatar {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        background-color: #717171;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
    }
    
    .profile-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        width: 16px;
        height: 16px;
        border-radius: 50%;
        background-color: #FF385C;
        color: white;
        font-size: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    /* Navigation path */
    .nav-path {
        display: flex;
        padding: 20px 80px;
        gap: 10px;
        font-size: 14px;
        color: #717171;
    }
    
    .nav-path a {
        text-decoration: none;
        color: #717171;
    }
    
    /* Main content */
    .main-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 80px 80px;
        display: flex;
        gap: 40px;
    }
    
    h1 {
        font-size: 32px;
        font-weight: 600;
        margin-bottom: 40px;
        padding-left: 80px;
        padding-top: 20px;
    }
    
    /* Left container with form */
    .container {
        flex: 2;
        padding: 24px;
        border: 1px solid #DDDDDD;
        border-radius: 12px;
    }
    
    .form-group {
        margin-bottom: 24px;
    }
    
    label {
        display: block;
        font-weight: 500;
        margin-bottom: 8px;
        color: #222;
    }
    
    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 12px;
        border: 1px solid #DDDDDD;
        border-radius: 8px;
        font-size: 16px;
        background-color: #fff;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    input[type="text"]:focus, input[type="password"]:focus {
        outline: none;
        border-color: #000;
    }
    
    .btn-container {
        display: flex;
        gap: 16px;
        margin-top: 32px;
    }
    
    .btn {
        padding: 14px 24px;
        font-size: 16px;
        font-weight: 500;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.2s ease;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    .btn-danger {
        background-color: #FF385C;
        color: white;
        border: none;
    }
    
    .btn-danger:hover {
        background-color: #E31C5F;
    }
    
    .btn-secondary {
        background-color: white;
        color: #222;
        border: 1px solid #DDDDDD;
    }
    
    .btn-secondary:hover {
        border-color: #000;
    }
    
    /* FAQ container */
    .faq-container {
        flex: 1;
        padding: 24px;
        border: 1px solid #DDDDDD;
        border-radius: 12px;
    }
    
    .faq-section {
        padding: 0;
    }
    
    .faq-card {
        margin-bottom: 24px;
    }
    
    .faq-icon {
        margin-bottom: 16px;
    }
    
    .faq-card h3 {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 8px;
        color: #222;
    }
    
    .faq-card p {
        font-size: 14px;
        line-height: 1.5;
        color: #717171;
    }
    
    .faq-divider {
        border: none;
        height: 1px;
        background-color: #DDDDDD;
        margin: 24px 0;
    }
    
    /* Title with icon */
    .title-container {
        display: flex;
        align-items: center;
        margin-bottom: 24px;
    }
    
    .title-container h2 {
        font-size: 22px;
        font-weight: 600;
    }
    
    .face-image {
        width: 32px;
        height: 32px;
        margin-right: 12px;
    }
    
    .normal-face {
        display: block;
    }
    
    .sad-face {
        display: none;
    }
</style>
<script>
    function validateForm() {
        var id = document.getElementById("id").value;
        var pwd = document.getElementById("pwd").value;
        if (id === "" || pwd === "") {
            alert("아이디와 비밀번호를 모두 입력해주세요.");
            return false;
        }
        return true;
    }
    
    function deleteConfirm() {
        if (confirm("정말로 탈퇴하시겠습니까? 모든 정보가 삭제됩니다.")) {
            document.deleteForm.submit();
        }
    }
    
    $(document).ready(function() {
        // 버튼 호버 시 이미지 변경 효과
        $('.btn-danger').mouseenter(function() {
            $('.normal-face').hide();
            $('.sad-face').show();
        });
        
        $('.btn-danger').mouseleave(function() {
            $('.normal-face').show();
            $('.sad-face').hide();
        });
    });
</script>
</head>
<body>
    <!-- Navigation path -->
    <div class="nav-path">
        <a href="#">계정</a>
        <i class="fas fa-chevron-right" style="font-size: 12px;"></i>
        <span>회원 탈퇴</span>
    </div>
    
    <h1>회원 탈퇴</h1>
    
    <div class="main-container">
        <!-- Left: Form Container -->
        <div class="container">
            <div class="title-container">
                <div class="face-images">
                    <img src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><circle cx='50' cy='50' r='45' fill='%23FF385C' stroke='%23E31C5F' stroke-width='2'/><circle cx='35' cy='40' r='5' fill='%23FFF'/><circle cx='65' cy='40' r='5' fill='%23FFF'/><path d='M30 65 Q50 80 70 65' stroke='%23FFF' stroke-width='3' fill='none'/></svg>" class="face-image normal-face" alt="일반 표정">
                    <img src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><circle cx='50' cy='50' r='45' fill='%23FF385C' stroke='%23E31C5F' stroke-width='2'/><circle cx='35' cy='40' r='5' fill='%23FFF'/><circle cx='65' cy='40' r='5' fill='%23FFF'/><path d='M30 75 Q50 60 70 75' stroke='%23FFF' stroke-width='3' fill='none'/></svg>" class="face-image sad-face" alt="슬픈 표정">
                </div>
                <h2>회원 정보 확인</h2>
            </div>
            
            <form name="deleteForm" action="${contextPath}/member/deleteMember.do" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="id">아이디:</label>
                    <input type="text" id="id" name="id" value="${sessionScope.loginId}" readonly>
                </div>
                <div class="form-group">
                    <label for="pwd">비밀번호:</label>
                    <input type="password" id="pwd" name="pwd">
                </div>
                <div class="btn-container">
                    <button type="button" class="btn btn-danger" onclick="deleteConfirm()">회원 탈퇴</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                </div>
            </form>
        </div>
        
        <!-- Right: FAQ Section -->
        <div class="faq-container">
            <div class="faq-section">
                <div class="faq-card">
                    <div class="faq-icon">
                        <svg viewBox="0 0 48 48" width="48" height="48" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect width="48" height="48" rx="24" fill="#FFE8EC"/>
                            <path d="M24 16V32" stroke="#FF385C" stroke-width="2" stroke-linecap="round"/>
                            <path d="M16 24H32" stroke="#FF385C" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <h3>회원 탈퇴 전 알아두세요</h3>
                    <p>탈퇴 시 모든 개인정보와 서비스 이용 기록이 영구적으로 삭제되어 복구가 불가능합니다.</p>
                </div>
                
                <hr class="faq-divider">
                
                <div class="faq-card">
                    <div class="faq-icon">
                        <svg viewBox="0 0 48 48" width="48" height="48" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect width="48" height="48" rx="24" fill="#FFE8EC"/>
                            <path d="M30 22H18C16.8954 22 16 22.8954 16 24V30C16 31.1046 16.8954 32 18 32H30C31.1046 32 32 31.1046 32 30V24C32 22.8954 31.1046 22 30 22Z" stroke="#FF385C" stroke-width="2"/>
                            <path d="M20 22V18C20 15.7909 21.7909 14 24 14C26.2091 14 28 15.7909 28 18V22" stroke="#FF385C" stroke-width="2"/>
                        </svg>
                    </div>
                    <h3>탈퇴 후 제한되는 서비스</h3>
                    <p>탈퇴 후에는 모든 서비스 이용이 중단되며, 작성하신 게시글과 댓글은 삭제되지 않고 남아있게 됩니다. 필요한 경우 탈퇴 전에 삭제해주세요.</p>
                </div>
                
                <hr class="faq-divider">
                
                <div class="faq-card">
                    <div class="faq-icon">
                        <svg viewBox="0 0 48 48" width="48" height="48" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect width="48" height="48" rx="24" fill="#FFE8EC"/>
                            <circle cx="24" cy="24" r="10" stroke="#FF385C" stroke-width="2"/>
                            <path d="M24 20V25H28" stroke="#FF385C" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <h3>포인트 및 혜택 소멸</h3>
                    <p>회원 탈퇴 시 적립된 모든 포인트와 쿠폰이 즉시 소멸되며, 재가입 시에도 복구되지 않습니다. 보유하신 혜택을 모두 사용하신 후 탈퇴하시는 것을 권장합니다.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>