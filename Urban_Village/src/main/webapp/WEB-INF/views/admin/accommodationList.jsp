<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
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
   margin-top: 10px;
   margin-bottom: 25px;
   text-align: center;
   position: relative;
   padding-bottom: 15px;
    font-weight: 600;
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

/* 네비게이션 바 스타일 */
.navbar {
    background-color: #fff !important;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 15px 0;
}

/* 테이블 스타일 */
.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 30px;
    background-color: #fff;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.table th, .table td {
    border: 1px solid #e0d6c6;
    padding: 15px;
    text-align: center;
}

.table th {
    background-color: #f2e7d5;
    color: #8b5a2b;
    font-weight: 600;
    border-bottom: 2px solid #d4a76a;
}

.table tr:nth-child(even) {
    background-color: #fdfbf7;
}

.table tr:hover {
    background-color: #f5efe5;
}

/* 버튼 스타일 */
.btn {
    border-radius: 30px;
    font-weight: 600;
    padding: 8px 20px;
    transition: all 0.3s;
    border: none;
    cursor: pointer;
}

.btn-primary {
    background-color: #8b5a2b;
    color: white;
    border: 2px solid #8b5a2b;
}

.btn-primary:hover {
    background-color: #d4a76a;
    border-color: #d4a76a;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(139, 90, 43, 0.3);
}

.btn-danger {
    background-color: #c53030;
    color: white;
    border: 2px solid #c53030;
}

.btn-danger:hover {
    background-color: #e53e3e;
    border-color: #e53e3e;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(229, 62, 62, 0.3);
}

/* 한옥 장식 요소 */
.hanok-divider {
    height: 30px;
    background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
    background-repeat: repeat-x;
    background-size: 100px 20px;
    margin: 20px 0;
}

/* 섹션 스타일 */
.section {
    padding: 30px;
    background-color: #fff;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    position: relative;
    overflow: hidden;
    margin-bottom: 30px;
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

/* 반응형 조정 */
@media (max-width: 768px) {
    .container {
        padding: 20px 10px;
    }
    
    .btn {
        padding: 6px 12px;
        font-size: 0.9rem;
    }
    
    .table th, .table td {
        padding: 10px;
    }
    
    h2 {
        font-size: 22px;
    }
}

</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
      <div class="container-fluid">
         <!-- 네비게이션 콘텐츠는 여기에 -->
      </div>
   </nav>


	<div class="container">
	<div class="section">
		<h2>숙소 목록</h2>
		<div class="hanok-divider"></div>
		
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>ID</th>
					<th>이름</th>
					<th>수용 인원</th>
					<th>가격</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="acc" items="${accommodationList}">
					<tr>
						<td>${acc.accommodation_id}</td>
						<td>${acc.accommodation_name}</td>
						<td>${acc.capacity}</td>
						<td>${acc.price}</td>
						
						<td>
							<button class="btn btn-primary btn-sm"
                           onclick="location.href='${contextPath}/accommodation/modAccommodationForm.do?accommodation_id=${acc.accommodation_id}'">수정</button>

						</td>
						<td>
							<button class="btn btn-danger btn-sm"
								onclick="confirmDelete('${acc.accommodation_id}')">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
	

	<script>
		function confirmDelete(accommodationId) {
			if (confirm("정말로 숙소를 삭제하시겠습니까?")) {
				location.href = "${contextPath}/accommodation/delAccommodation.do?accommodation_id=" + accommodationId;
			}
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>