<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클리너 지원자 목록</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap');
        
        /* 기본 스타일 */
        body {
            font-family: 'Noto Serif KR', 'Malgun Gothic', 'Apple SD Gothic Neo', Dotum, Gulim, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #faf7f2; /* 한옥 느낌의 따뜻한 배경색 */
            color: #4e3629; /* 나무색과 유사한 텍스트 색상 */
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        h2 {
            color: #8b5a2b;
            font-size: 28px;
            margin-top: 40px;
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: #d4a76a;
        }
        
        .section {
            margin-bottom: 40px;
            padding: 30px;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }
        
        .section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background-color: #8b5a2b; /* 한옥 무늬 색상 */
        }
        
        /* 지원자 카드 스타일 */
        .applicant-card {
            background-color: #fff;
            border: 1px solid #e0d6c6;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .applicant-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background-color: #d4a76a;
        }
        
        .applicant-card:hover {
            box-shadow: 0 8px 20px rgba(139, 90, 43, 0.2);
            transform: translateY(-3px);
        }
        
        .applicant-info p {
            margin: 10px 0;
            font-size: 16px;
            color: #4e3629;
        }
        
        .applicant-info strong {
            color: #8b5a2b;
            font-weight: 600;
        }
        
        .detail-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 24px;
            font-size: 14px;
            font-weight: 600;
            color: white;
            background-color: #8b5a2b;
            border: 2px solid #8b5a2b;
            border-radius: 30px;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .detail-btn:hover {
            background-color: #d4a76a;
            border-color: #d4a76a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(139, 90, 43, 0.3);
        }
        
        .no-data {
            text-align: center;
            padding: 30px;
            font-style: italic;
            color: #8b5a2b;
            font-size: 17px;
        }
        
        /* 한옥 장식 요소 */
        .hanok-divider {
            height: 30px;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
            background-repeat: repeat-x;
            background-size: 100px 20px;
            margin: 20px 0;
        }
    </style>
</head>
<body>

    <h2>클리너 지원자 목록</h2>
    
    <div class="hanok-divider"></div>

    <div class="container section">
        <c:forEach var="c" items="${cleanerList}">
            <c:set var="isAssigned" value="false" />
            <c:forEach var="assignedId" items="${accCleanerId}">
                <c:if test="${c.member_id == assignedId}">
                    <c:set var="isAssigned" value="true" />
                </c:if>
            </c:forEach>

            <c:if test="${!isAssigned}">
                <div class="applicant-card">
                    <div class="applicant-info">
                        <p><strong>아이디:</strong> ${c.member_id}</p>
                        <p><strong>이름:</strong> ${c.memberName}</p>
                        <p><strong>전화번호:</strong> ${c.memberPhone}</p>
                        <p><strong>등록일:</strong> ${c.regdate}</p>
                    </div>
                    <a class="detail-btn" href="${contextPath}/admin/cleanerDetail.do?member_id=${c.member_id}">상세보기</a>
                </div>
            </c:if>
        </c:forEach>

        <c:if test="${empty cleanerList}">
            <p class="no-data">지원자가 없습니다.</p>
        </c:if>
    </div>
    
    <div class="hanok-divider"></div>

</body>
</html>