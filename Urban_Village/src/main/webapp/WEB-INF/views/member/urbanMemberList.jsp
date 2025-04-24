<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap');

body {
    font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', Dotum, Gulim, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #faf7f2;
    color: #4e3629;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    background-color: #fff;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

h1 {
    font-size: 36px;
    font-weight: 700;
    margin: 0 0 30px 0;
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

.search-container {
    margin-bottom: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
}

.search-input {
    padding: 12px 20px;
    border-radius: 30px;
    border: 1px solid #e0d6c6;
    font-size: 14px;
    width: 300px;
    box-sizing: border-box;
}

.search-button {
    background-color: #8b5a2b;
    color: white;
    padding: 12px 25px;
    border-radius: 30px;
    font-weight: 600;
    border: 2px solid #8b5a2b;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 14px;
}

.search-button:hover {
    background-color: #d4a76a;
    border-color: #d4a76a;
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(139, 90, 43, 0.3);
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #e0d6c6;
    padding: 12px;
    text-align: center;
}

th {
    background-color: #f2e7d5;
    color: #8b5a2b;
    font-weight: 600;
}

tr:nth-child(even) {
    background-color: #fdfbf7;
}

tr:hover {
    background-color: #f5efe5;
}

.hanok-divider {
    height: 30px;
    background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
    background-repeat: repeat-x;
    background-size: 100px 20px;
    margin: 40px 0;
}

@media (max-width: 900px) {
    table, th, td {
        font-size: 13px;
    }
    .container {
        padding: 20px 10px;
    }
}
</style>

<div class="container">
    <c:if test="${not onlyReservation}">
        <h1>회원 목록</h1>
        <div class="hanok-divider"></div>

        <table>
            <thead>
                <tr>
                    <th>아이디</th>
                    <th>비번</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>생년월일</th>
                    <th>전화번호</th>
                    <th>가입일</th>
                    <th>성별</th>
                    <th>예약 내역</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="m" items="${membersList}">
                    <tr>
                        <td>${m.id}</td>
                        <td>${m.pwd}</td>
                        <td>${m.name}</td>
                        <td>${m.email}</td>
                        <td>${m.birth}</td>
                        <td>${m.phonenumber}</td>
                        <td>${m.regdate}</td>
                        <td>${m.gender}</td>
                        <td>
                            <button type="button"
                                onclick="location.href='${contextPath}/reservation/getReservationHistory.do?userId=${m.id}&onlyReservation=true'"
                                style="padding: 6px 12px; background-color: #8b5a2b; color: white; border: none; border-radius: 5px; cursor: pointer;">
                                예약 내역 조회
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="hanok-divider"></div>
    </c:if>

    <!-- 예약 내역 출력 -->
    <c:if test="${not empty selectedUserId}">
    <h2 style="text-align:center; margin-top:40px;">${selectedUserId}님의 예약 내역</h2>
    
    <c:choose>
        <c:when test="${not empty reservationList}">
            <table>
                <thead>
                    <tr>
                        <th>예약 번호</th>
                        <th>체크인</th>
                        <th>체크아웃</th>
                        <th>결제금액</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${reservationList}">
                        <tr>
                            <td>${r.reservation_id}</td>
                            <td>${r.checkin_date}</td>
                            <td>${r.checkout_date}</td>
                            <td>${r.total_price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p style="text-align:center; font-size: 18px; margin-top: 20px; color: #999;">
                예약 내역이 없습니다.
            </p>
        </c:otherwise>
    </c:choose>
</c:if>
</div>
