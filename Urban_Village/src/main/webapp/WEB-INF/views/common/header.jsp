<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Urban&Village</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/Urban_Village/resources/css/style.css">
<script>
    // 드롭다운 메뉴 토글
    function toggleDropdown() {
        let dropdown = document.getElementById("dropdownMenu");
        dropdown.style.display = (dropdown.style.display === "block") ? "none" : "block";
    }

    // 드롭다운 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (!event.target.matches('.menu-btn') && !event.target.matches('.profile-img')) {
            let dropdown = document.getElementById("dropdownMenu");
            if (dropdown.style.display === "block") {
                dropdown.style.display = "none";
            }
        }
    };
</script>

<style>
/* 헤더 스타일 */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    border-bottom: 1px solid #ddd;
}

/* 로고 */
.header .logo {
    font-size: 24px;
    font-weight: bold;
    text-decoration: none;
    color: #333;
    margin-right: 30px; /* 검색창과의 간격 */
}

/* 검색창 */
.search-bar {
	font-family: 'Noto Sans KR', sans-serif;
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 30px;
    padding: 5px 15px;
    background-color: white;
    width: 300px; /* 너비 조정 */
    height: 40px;
    z-index: 5;
}

.search-bar input[type="text"] {
	font-family: 'Noto Sans KR', sans-serif;
    border: none;
    padding: 8px;
    font-size: 16px;
    flex-grow: 1;
    outline: none;
}

.search-bar button.mainSearchBar {
    background-color: #ffffff;
    color: #333;
    border: none;
    padding: 8px 15px;
    border-radius: 30px;
    cursor: pointer;
    font-size: 16px;
}

/* 사용자 메뉴 */
.user-menu {
    position: relative;
    display: flex;
    align-items: center;
}

/* 로그인/회원가입 링크 스타일 */
.user-menu a {
    text-decoration: none;
    color: #333;
    margin-left: 15px;
    font-size: 16px;
}

.user-menu a:first-child {
    margin-left: 0;
}

/* 프로필 메뉴 */
.profile-menu {
    display: flex;
    align-items: center;
    cursor: pointer;
}

/* 프로필 이미지 */
.profile-img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin-right: 8px;
}

/* 사용자 이름 스타일 */
.profile-menu h3 {
    font-size: 16px;
    font-weight: normal;
    margin: 0;
    margin-right: 8px;
}

/* 햄버거 메뉴 버튼 */
.menu-btn {
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
}

/* 드롭다운 메뉴 */
.dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    top: calc(100% + 5px);
    background-color: white;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    min-width: 150px;
    border-radius: 10px;
    overflow: hidden;
    z-index: 1000;
    padding-top: 0;
}

.dropdown-content a {
    display: block;
    padding: 8px 15px;
    text-decoration: none;
    color: black;
    font-size: 14px;
}

.dropdown-content a:hover {
    background-color: #f1f1f1;
}

.dropdown-content hr {
    margin: 5px 0;
    border: 0.5px solid #ddd;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
    .header {
        flex-direction: column;
        align-items: center;
        padding: 10px;
    }
    .header .logo {
        margin-right: 0;
        margin-bottom: 10px;
    }
    .search-bar {
        width: 95%;
        margin-bottom: 10px;
    }
    .user-menu {
        margin-top: 10px;
    }
    .user-menu a {
        margin-left: 10px;
    }
    .profile-menu h3 {
        display: none;
    }
}
</style>
</head>
<body>

    <div class="header">

        <a href="/Urban_Village/" class="logo"> Urban&Village </a>

        <form method="get"
              action="${contextPath}/accommodation/searchAccommodation">
            <div class="search-bar">
                <input type="text" name="keyword" placeholder="어디로 떠날까요?">
                <button class="mainSearchBar">검색</button>
            </div>
        </form>

        <div class="user-menu">
            <c:choose>
                <c:when test="${isLogin == true }">

                    <div class="profile-menu">
                        <img src="${contextPath }/resources/image/profile.png"
                             class="profile-img" alt="프로필 이미지">
                             <h3>${loginId }님</h3>
                        <button class="menu-btn" onclick="toggleDropdown()">☰</button>
                    </div>

                    <div id="dropdownMenu" class="dropdown-content">
                        <a href="${contextPath}/reservation/reservationHistory.do">여행(예약확인)</a>
                        <a href="${contextPath }/wishList/wishList.do?memberId=${loginId}">위시리스트</a>
                        <hr>
                         <a href="${contextPath }/member/myInfo.do?id=${loginId}">내정보확인</a>
                         <a href="${contextPath }/member/myCoupon.do?id=${loginId}">내쿠폰함</a>
                         <a href="${contextPath }/cleaner/cleanerForm.do">구직지원</a>
                        <hr>
                        <a href="${contextPath }/admin/helpCenter.do">도움말 센터</a>
                        <a href="${contextPath }/member/logout.do">로그아웃</a>
                    </div>
                </c:when>
                <c:when test="${isAdmin == true}">
                    <div class="profile-menu">
                        <img src="${contextPath }/resources/image/adminprofile.png"
                             class="profile-img" alt="프로필 이미지">
                             <h3>${adminId }님</h3>
                        <button class="menu-btn" onclick="toggleDropdown()">☰</button>
                    </div>

                    <div id="dropdownMenu" class="dropdown-content">
                        <a href="${contextPath }/accommodation/accommodationForm.do">숙소 추가</a>
                        <a href="${contextPath }/accommodation/accommodationList.do">숙소 수정/삭제</a>
                        <a href="${contextPath }/admin/hostAccBest.do">호스트 추천등록</a>
                        <hr>
                        <a href="${contextPath }/admin/cleanerList.do">지원자 현황</a>
                        <a href="${contextPath}/member/salesForm.do">매출</a>
                        <hr>
                        <a href="${contextPath }/member/urbanMemberList.do">회원 관리</a>
                        <a href="${contextPath}/review/reviewList">회원 후기리스트</a>
                        
                        <a href="${contextPath }/member/logout.do">로그아웃</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${contextPath }/member/loginForm.do">로그인</a>
                    <a href="${contextPath }/member/joinMember.do">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>


    </body>
</html>