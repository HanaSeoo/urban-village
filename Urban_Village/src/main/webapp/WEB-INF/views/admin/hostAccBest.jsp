<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>호스트 추천 지정</title>
   <link rel="stylesheet"
   href="${contextPath}/resources/css/style.css">
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
        
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px;
        }
        
        .container {
            width: 100%;
            max-width: 1000px;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin: 15px 0;
        }
        
        h1, h2, h3 {
            font-size: 2rem;
            font-weight: 500;
            margin-bottom: 30px;
            text-align: center;
            color: #333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f4f4f4;
        }
        
        button {
            padding: 10px 20px;
            background-color:  #ff385c;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        button:hover {
            background-color: #555;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background-color: transparent;
            color: #333;
            border: 1px solid #ccc;
            border-radius: 30px;
            text-align: center;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn:hover {
            background-color: #333;
            color: #fff;
            border-color: #333;
        }
    </style>
</head>
<body>

    <div class="main-content">
        <div class="container">
            <h2>호스트 추천 지정</h2>
            <div>
                <h3>숙소 목록</h3>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>이름</th>
                            <th>수용 인원</th>
                            <th>가격</th>
                            <th>호스트 추천 등록</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="acc" items="${accExceptBest}">
                            <tr>
                                <td>${acc.accommodation_id}</td>
                                <td>${acc.accommodation_name}</td>
                                <td>${acc.capacity}</td>
                                <td>${acc.price}</td>
                                <td>
                                    <button
                                        onclick="location.href='${contextPath}/admin/hostAccBestButton.do?accommodation_id=${acc.accommodation_id}'">
                                        호스트 추천 등록
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div>
                <h3>호스트 등록 숙소 목록</h3>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>이름</th>
                            <th>수용 인원</th>
                            <th>가격</th>
                            <th>호스트 추천 삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="accBest" items="${hostBestAccIdList}">
                            <tr>
                                <td>${accBest.accommodation_id}</td>
                                <td>${accBest.accommodation_name}</td>
                                <td>${accBest.capacity}</td>
                                <td>${accBest.price}</td>
                                <td>
                                    <button
                                        onclick="location.href='${contextPath}/admin/delHostAccBest.do?accommodation_id=${accBest.accommodation_id}'">
                                        호스트 추천 등록 삭제
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

</body>
</html>
  