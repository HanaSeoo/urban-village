<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클리너 상세 정보</title>
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

        .container {
            width: 90%;
            max-width: 900px;
            margin: 15px auto;
            padding: 40px 20px;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 32px;
            font-weight: 700;
            margin: 0 0 30px 0;
            text-align: center;
            letter-spacing: 1px;
            color: #8b5a2b;
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

        .card {
            background-color: #fff;
            border: 1px solid #e0d6c6;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.3s;
        }

        .card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #e0d6c6;
            padding: 14px 16px;
            text-align: left;
            font-size: 16px;
            color: #4e3629;
        }
        
        th {
            background-color: #f2e7d5;
            color: #8b5a2b;
            font-weight: 600;
            width: 30%;
        }

        tr:nth-child(odd) {
            background-color: #fdfbf7;
        }
        
        tr:nth-child(even) {
            background-color: #fff;
        }
        
        tr:hover {
            background-color: #f5efe5;
        }

        a {
            color: #8b5a2b;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        a:hover {
            color: #d4a76a;
            text-decoration: underline;
        }

        .button-row {
            text-align: center;
            margin-top: 30px;
        }

        input[type="button"], input[type="submit"] {
            background-color: #8b5a2b;
            color: white;
            border: none;
            padding: 12px 28px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s;
            margin: 0 10px;
            border: 2px solid #8b5a2b;
        }

        input[type="button"]:hover, input[type="submit"]:hover {
            background-color: #d4a76a;
            border-color: #d4a76a;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(139, 90, 43, 0.3);
        }
        
        .hanok-divider {
            height: 30px;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
            background-repeat: repeat-x;
            background-size: 100px 20px;
            margin: 20px 0;
        }
        
        @media (max-width: 900px) {
            table, th, td {
                font-size: 14px;
            }
            
            .container {
                padding: 20px 10px;
            }
            
            input[type="button"], input[type="submit"] {
                padding: 10px 18px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <form action="${contextPath}/cleaner/cleanerIdDelete.do" method="post">
        <div class="container">
            <h2>클리너 지원자 상세 정보</h2>
            <div class="hanok-divider"></div>

            <div class="card">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td id="c_member_id">${cleaner.member_id}</td>
                        <input type="hidden" name="member_id" value="${cleaner.member_id}">
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${cleaner.memberName}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>${cleaner.memberPhone}</td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td>${cleaner.memberBirth}</td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>${cleaner.memberGender}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>${cleaner.address}</td>
                    </tr>
                    <tr>
                        <th>등록일</th>
                        <td>${cleaner.regdate}</td>
                    </tr>
                    <tr>
                        <th>소득증빙자료</th>
                        <td><a href="${contextPath}${cleaner.incomeProof}" target="_blank">파일보기</a></td>
                    </tr>
                </table>

                <div class="hanok-divider"></div>
                <div class="button-row">
                    <input type="button" name="assignment" onclick="goToReservation()" value="숙소 배정하기">
                    <input type="submit" name="delete" value="불합격">
                </div>
            </div>
        </div>
    </form>
</body>

<script>
function goToReservation() {
    let member_id = document.getElementById("c_member_id").innerText;
    localStorage.setItem('addAccMemberId', member_id);
    window.location.href = "/Urban_Village/cleaner/cleanerAddAcc.do";
}
function goToDelete() {
    let member_id = document.getElementById("c_member_id").innerText;
    localStorage.setItem('addAccMemberId', member_id);
    window.location.href = "/Urban_Village/cleaner/cleanerIdDelete.do";
}
</script>
</html>