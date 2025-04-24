<%@page
	import="com.test.Urban_Village.accommodation.dto.AccommodationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
long currentTimestamp = System.currentTimeMillis();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<style>
.image-preview {
	margin-top: 10px;
	width: 100%;
	height: auto;
	display: block;
	margin-bottom: 10px;
}
</style>
<script>
	function previewImages(event) {
		var output = document.getElementById('imagePreviewContainer');
		output.innerHTML = ''; // 초기화
		var files = event.target.files;
		if (files) {
			for (var i = 0; i < files.length; i++) {
				var file = files[i];
				if (!file.type.startsWith('image/'))
					continue;
				var reader = new FileReader();
				reader.onload = function(e) {
					var img = document.createElement('img');
					img.src = e.target.result;
					img.alt = '이미지 미리보기';
					img.className = 'image-preview';
					output.appendChild(img);
				};
				reader.readAsDataURL(file);
			}
		}
	}

	function toggleEditForm() {
		const detailView = document.getElementById('detailView');
		const editForm = document.getElementById('editForm');
		detailView.classList.toggle('hidden');
		editForm.classList.toggle('hidden');
	}
</script>
</head>
<body>

	<main class="container mt-4">
		<div id="detailView">
			<h2>${accommodation.accommodation_name}정보</h2>
			<p>숙소 ID: ${accommodation.accommodation_id}</p>

			<h3>현재 숙소 이미지</h3>
			<div id="currentImageContainer" class="mt-2">
				<c:set var="imageStr"
					value="${accommodation.accommodation_photo}" />
				<c:set var="images" value="${fn:split(imageStr, ',')}" />
				<c:forEach var="img" items="${images}">
					<img
						src="${contextPath }/download.do?imageFileName=${img}&accommodation_id=${accommodation.accommodation_id}&timestamp=<%= currentTimestamp %>"
						class="img-thumbnail"
						style="max-width: 100px; max-height: 100px; margin-right: 5px;"
						alt="기존 숙소 이미지">
				</c:forEach>
			</div>

			
		</div>

		<div id="editForm" class="container mt-4 hidden">
			<h2 class="fw-bold">숙소 정보 수정</h2>
			<form id="updateAccommodationForm" action="${contextPath }/accommodation/accommodationUpdate.do"
				method="post" enctype="multipart/form-data">
				<input type="hidden" name="accommodation_id"
					value="${accommodation.accommodation_id}">

				<div class="mb-3">
					<label for="admin_id" class="form-label">관리자 ID</label> <input
						type="text" class="form-control" id="admin_id" name="admin_id"
						value="${accommodation.admin_id}" required>
				</div>

				<div class="mb-3">
					<label for="accommodation_address" class="form-label">숙소 주소</label> <input
						type="text" class="form-control" id="accommodation_address"
						name="accommodation_address"
						value="${accommodation.accommodation_address}" readonly required>
				</div>
				
				<div class="mb-3">
					<label for="accommodation_name" class="form-label">숙소 이름</label> <input
						type="text" class="form-control" id="accommodation_name"
						name="accommodation_name"
						value="${accommodation.accommodation_name}" required>
				</div>

				<div class="mb-3">
					<label for="accommodation_photo" class="form-label">숙소 사진
						(선택 사항, 변경 시에만)</label> <input type="file" class="form-control"
						id="accommodation_photo" name="accommodation_photo[]" multiple
						onchange="previewImages(event)">
					<div id="imagePreviewContainer" class="mt-2"></div>
				</div>

				<div class="mb-3">
					<label for="cleaner_admin_id" class="form-label">청소 관리자 ID
						(선택)</label> <input type="text" class="form-control" id="cleaner_admin_id"
						name="cleaner_admin_id"
						value="${accommodation.cleaner_admin_id}">
				</div>

				<div class="mb-3">
					<label for="capacity" class="form-label">최대 인원 수</label> <input
						type="number" class="form-control" id="capacity" name="capacity"
						value="${accommodation.capacity}" required>
				</div>

				<div class="mb-3">
					<label for="room_count" class="form-label">방 개수</label> <input
						type="number" class="form-control" id="room_count"
						name="room_count" value="${accommodation.room_count}"
						required>
				</div>

				<div class="mb-3">
					<label for="bathroom_count" class="form-label">화장실 개수</label> <input
						type="number" class="form-control" id="bathroom_count"
						name="bathroom_count"
						value="${accommodation.bathroom_count}" required>
				</div>

				<div class="mb-3">
					<label for="bed_count" class="form-label">침대 수</label> <input
						type="number" class="form-control" id="bed_count" name="bed_count"
						value="${accommodation.bed_count}" required>
				</div>

				<div class="mb-3">
					<label for="price" class="form-label">가격 (박당)</label> <input
						type="number" class="form-control" id="price" name="price"
						value="${accommodation.price}" required>
				</div>

				<div class="mb-3">
					<label for="wifi_avail" class="form-label">와이파이 여부</label> <select
						class="form-control" id="wifi_avail" name="wifi_avail" required>
						<option value="">와이파이 여부 선택</option>
						<option value="Y"
							${accommodation.wifi_avail == 'Y' ? 'selected' : ''}>Y</option>
						<option value="N"
							${accommodation.wifi_avail == 'N' ? 'selected' : ''}>N</option>
					</select>
				</div>

				<button type="submit" class="btn btn-primary">수정 완료</button>
				<button type="button" class="btn btn-secondary"
					onclick="toggleEditForm()">취소</button>
			</form>
		</div>
	</main>

</body>
</html>