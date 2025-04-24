<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>숙소 등록</title>
<style>
body {
    font-family: 'Malgun Gothic', sans-serif; /* Softened font */
    margin: 0;
    padding: 0;
    /* Hanok-like warm background color as a fallback */
    background-color: #f8f4e3;
    /* Background Image Styles */
    background-image: url('${contextPath}/resources/WebSiteImages/bcd.png'); /* Correct web path */
    background-size: cover; /* Scale image to cover the entire viewport */
    background-position: center center; /* Center the image */
    background-repeat: no-repeat; /* Do not repeat the image */
    background-attachment: fixed; /* Fix image relative to viewport */
    position: relative; /* Needed for the ::before pseudo-element */
}

/* Semi-transparent overlay - Kept from previous version */
body::before {
    content: "";
    position: fixed; /* Cover the entire viewport */
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    /* Alpha value controls transparency - adjust if needed */
    background-color: rgba(253, 252, 249, 0.4);
    z-index: -1; /* Place it between the body background and the form */
}


.container {
    width: 80%; /* Make container wider to accommodate two columns */
    max-width: 960px; /* Optional: Limit max width */
    margin: 15px auto; /* Add top/bottom margin for spacing */
    padding: 0; /* Remove padding-top */
    position: relative; /* Ensure form is above the overlay */
    z-index: 0; /* Ensure form is above the overlay */
}

.form-box {
    /* Changed background-color to white */
    background-color: #ffffff; /* White background */
    padding: 40px; /* Increased padding */
    border-radius: 15px; /* More rounded corners */
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1); /* Soft shadow */
    border: 1px solid #e0e0e0; /* Subtle light grey border */
}

h2 {
    text-align: center;
    color: #5a4a3a; /* Earthy heading color (can be adjusted if needed) */
    margin-bottom: 30px; /* Space below title */
}

/* Two-column layout */
.form-columns {
    display: flex;
    gap: 40px; /* Space between columns */
    margin-bottom: 20px; /* Space below columns */
}

.form-column {
    flex: 1; /* Columns take equal width */
}


/* 공통 입력 필드 */
.input-field {
    width: 100%; /* Full width within its column */
    padding: 12px 15px; /* Added horizontal padding */
    margin: 10px 0;
    border-radius: 8px;
    border: 1px solid #d3cbbd; /* Muted border color, consistent with Hanok feel */
    font-size: 15px; /* Slightly smaller font */
    background-color: #fff; /* Keep input background white */
    transition: all 0.3s ease;
    box-sizing: border-box; /* Include padding and border in element's total width and height */
    color: #333; /* Default text color */
}

.input-field:focus {
    border-color: #a52a2a; /* Earthy red on focus, or change to brown if preferred */
    box-shadow: 0 0 5px rgba(165, 42, 42, 0.3); /* Subtle shadow on focus */
    outline: none;
}

/* Placeholder text style */
::placeholder {
  color: #a1988d; /* Muted placeholder color */
  opacity: 1; /* Ensure color is not transparent */
}

/* 기본 버튼 스타일 (Main Submit Button color handled by .full-width) */
.submit-button {
    /* Default styles inherited by other buttons, overridden for main submit */
    border: none;
    padding: 12px 24px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}


/* row-flex 컨테이너 */
.row-flex {
    display: flex;
    gap: 10px;
    align-items: center;
    margin: 10px 0; /* Add vertical margin to the row */
}

.row-flex label {
    flex-shrink: 0; /* Prevent label from shrinking */
    color: #5a4a3a; /* Match heading color */
    font-weight: bold;
    font-size: 15px;
}


/* select 필드 */
.select-field {
    flex: 1;
    padding: 12px 15px;
    border-radius: 8px;
    border: 1px solid #d3cbbd; /* Consistent with input fields */
    background-color: #ffffff; /* Keep select background white */
    font-size: 15px;
    cursor: pointer;
    box-sizing: border-box;
    color: #333;
}

/* 숙소 이름 입력창은 flex로 확장 */
.flex-grow {
    flex: 1;
}

/* 중복체크 및 주소 검색 버튼 (Light Brown) */
.check-button {
    width: auto; /* Auto width based on content */
    padding: 8px 16px; /* Smaller padding */
    background-color: #d2b48c; /* Tan (Light Brown) */
    color: #3e2723; /* Dark brown text color for contrast */
    font-weight: normal;
    border: 1px solid #b09070; /* Slightly darker light brown border */
}

.check-button:hover {
     background-color: #c3a37b; /* Slightly darker light brown on hover */
}

/* Address specific input group styling */
.input-group {
    display: flex; /* Use flex for the input and button */
    gap: 5px; /* Small gap between input and button */
    flex-grow: 1; /* Allow the input group to grow */
    align-items: center;
}

.input-group .address-input {
     flex-grow: 1; /* Allow input to take available space */
     margin: 0; /* Remove margin from within flex row */
     width: auto; /* Override input-field 100% width */
}

.input-group .address-button {
    flex-shrink: 0; /* Prevent button from shrinking */
    padding: 8px 12px; /* Adjust button padding */
    margin: 0; /* Remove margin from within flex row */
    font-size: 14px; /* Slightly smaller font for button */
     /* Inherits check-button style */
}

/* Full width submit button (Dark Brown) */
.submit-button.full-width {
    display: block; /* Make it a block element */
    width: 100%; /* Full width of the form box */
    margin-top: 30px; /* Space above the button */
    padding: 15px 24px; /* Slightly larger padding for main button */
    font-size: 18px; /* Larger font for main button */
    background-color: #5a4a3a; /* Dark brown */
    color: white; /* White text for contrast */
}
.submit-button.full-width:hover {
    background-color: #3e2723; /* Even darker brown on hover */
}

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
    <div class="container">
        <form method="post"
            action="${contextPath}/accommodation/addNewAccommodation"
            class="form-box" enctype="multipart/form-data">
            <h2>숙소 등록</h2>

            <div class="form-columns">
                <div class="form-column">
                    <input type="text" name="accommodation_id"
                        value="등록 후 숙소 아이디가 자동으로 생성됩니다." class="input-field" required
                        readonly>
                    <input type="text" name="admin_id"
                        class="input-field" placeholder="관리자 ID" required>

                    <div class="row-flex">
                         <label class="form-label">주소</label> <div class="input-group">
                            <input type="text" class="input-field address-input" name="zipNo" id="zipNo"
                                placeholder="우편번호" readonly />
                            <button type="button" class="submit-button check-button address-button"
                                onclick="execDaumPostcode()">주소 검색</button>
                        </div>
                    </div>
                     <input type="text" class="input-field" name="accommodation_address"
                        id="roadAddrPart1" placeholder="도로명 주소" readonly />


                    <div class="row-flex">
                        <input type="text" id="accommodationName" name="accommodation_name"
                            class="input-field flex-grow" placeholder="숙소 이름" required>
                        <button type="button" class="submit-button check-button"
                            onclick="checkAccommodationName()">중복체크</button>
                    </div>

                    <input type="file" name="accommodation_photo[]" class="input-field" placeholder="숙소 사진 경로" required multiple>
                    <input type="text" name="cleaner_admin_id" class="input-field" placeholder="청소 관리자 ID (선택)">
                </div>

                <div class="form-column">
                    <input type="number" name="capacity" class="input-field" placeholder="최대 인원 수" required>
                    <input type="number" name="room_count" class="input-field" placeholder="방 개수" required>
                    <input type="number" name="bathroom_count" class="input-field" placeholder="화장실 개수" required>
                    <input type="number" name="bed_count" class="input-field" placeholder="침대 수" required>
                    <input type="number" name="price" class="input-field" placeholder="가격" required>
                    <select name="wifi_avail" class="input-field" required>
                        <option value="">와이파이 여부 선택</option>
                        <option value="Y">Y</option>
                        <option value="N">N</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="submit-button full-width">등록</button>
        </form>
    </div>

    <script>
    function checkAccommodationName() {
        var accommodationName = $("#accommodationName").val();
        console.log("중복 체크를 위한 숙소 이름: " + accommodationName);
        if (accommodationName.trim() === "") {
            alert("숙소 이름을 입력해주세요.");
            return; // Prevent AJAX call if input is empty
        }
        $.ajax({
            url: "${contextPath}/accommodation/checkName.do",
            method: "POST",
            data: { accommodation_name: accommodationName },
            success: function(response) {
                if (response.exists) {
                    alert("숙소 이름이 이미 존재합니다.");
                } else {
                    alert("사용 가능한 숙소 이름입니다.");
                }
            },
            error: function(xhr, status, err) {
                 alert("❌ 오류 발생:\nstatus: " + xhr.status + "\nmessage: " + err);
                 console.error("AJAX Error:", status, err, xhr.responseText); // Log full error
            }
        });
    }

    // Daum Postcode script
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 방지하는 코드 추가
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipNo').value = data.zonecode; // 우편번호
                document.getElementById("roadAddrPart1").value = roadAddr; // 도로명 주소

            }
        }).open(); // Open the postcode popup
    }

    $("form").on("submit", function (e) {
        var roadAddr = $("#roadAddrPart1").val().trim();
        if (!roadAddr.startsWith("경북")) {
            alert("경상북도 외에 지역은 등록 불가합니다.");
            execDaumPostcode(); // 주소 검색 팝업 다시 띄우기
            e.preventDefault(); // 폼 제출 막기
            return false;
        }
    });
    </script>
</body>
</html>