<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<title></title>
<link rel="stylesheet"
    href="${contextPath}/resources/css/styleJoinMember.css">
    <style>
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
    </style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
let isIdChecked = false;
let isEmailVerified = false;
let sentCode = "";

function fn_checkId() {
    var userId = $("#id").val();
    if (userId === "") {
        alert("아이디를 입력하세요.");
        return;
    }

    $.ajax({
        url: "${contextPath}/member/checkId.do",
        method: "POST",
        data: { id: userId },
        success: function(response) {
            if (response.exists) {
                alert("아이디가 이미 존재합니다.");
                isIdChecked = false;
            } else {
                alert("사용 가능한 아이디입니다.");
                isIdChecked = true;
            }
        },
        error: function() {
            alert("아이디 중복 체크 중 오류가 발생했습니다.");
            isIdChecked = false;
        }
    });
}

function sendVerificationCode() {
    const email = $("#email").val();

    // 이메일 형식 검사
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("올바른 이메일 형식을 입력해주세요.");
        return;
    }

    $.ajax({
        url: "${contextPath}/email/sendJoinCode.do",
        type: "POST",
        data: { email: email },
        success: function(code) {
            sentCode = code;
            alert("인증번호가 이메일로 발송되었습니다.");
            $("#verificationSection").show();
            $("#verifyBtn").show();
        },
        error: function() {
            alert("인증번호 발송 중 오류가 발생했습니다.");
        }
    });
}

function verifyCode() {
    const inputCode = $("#verificationCodeInput").val();

    $.ajax({
        url: "${contextPath}/email/checkJoinCode.do",
        type: "POST",
        data: { inputCode: inputCode },
        success: function(isValid) {
            if (isValid) {
                alert("이메일 인증이 완료되었습니다!");
                isEmailVerified = true;
                $("#submitBtn").prop("disabled", false); // 회원가입 버튼 활성화
            } else {
                alert("인증번호가 일치하지 않습니다.");
                isEmailVerified = false;
                $("#submitBtn").prop("disabled", true); // 회원가입 버튼 비활성화
            }
        },
        error: function() {
            alert("인증 확인 중 오류가 발생했습니다.");
            isEmailVerified = false;
            $("#submitBtn").prop("disabled", true); // 회원가입 버튼 비활성화
        }
    });
}

$(document).ready(function() {
    $("#joinForm").submit(function(event) {
        let isValid = true;

        // 필수 입력 필드 검사
        $(this).find("[required]").each(function() {
            if ($(this).val() === "") {
                alert($(this).siblings("span").text() + "을(를) 입력해주세요.");
                $(this).focus();
                isValid = false;
                return false; // each 반복 종료
            }
        });

        if (!isValid) {
            event.preventDefault(); // 폼 제출 방지
            return;
        }

        // 아이디 중복 체크 여부 확인
        if (!isIdChecked) {
            alert("아이디 중복 체크를 해주세요.");
            $("#checkIdBtn").focus();
            event.preventDefault(); // 폼 제출 방지
            return;
        }

        // 이메일 인증 여부 확인
        const email = $("#email").val();
        if (email !== "" && !isEmailVerified) {
            alert("이메일 인증을 완료해주세요.");
            $("#sendCodeBtn").focus();
            event.preventDefault(); // 폼 제출 방지
            return;
        } else if (email === "" && $("#verificationCodeInput").val() !== "") {
            alert("이메일을 먼저 입력하고 인증을 진행해주세요.");
            $("#email").focus();
            event.preventDefault();
            return;
        }

        // 전화번호 형식 검사
        const phoneNumber = $("[name='phonenumber']").val();
        const phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        if (!phoneRegex.test(phoneNumber)) {
            alert("전화번호 형식을 000-0000-0000 또는 000-000-0000으로 입력해주세요.");
            $("[name='phonenumber']").focus();
            event.preventDefault(); // 폼 제출 방지
            return;
        }

        // 모든 유효성 검사를 통과하면 폼은 정상적으로 제출됩니다.
    });

    // 전화번호 입력 시 자동 하이픈 추가 (선택 사항)
    $("[name='phonenumber']").on("input", function() {
        $(this).val($(this).val().replace(/[^0-9]/g, '').replace(/(\d{3})(\d{3,4})(\d{4})/, '$1-$2-$3'));
    });
});
</script>
</head>
<body>
<video autoplay muted loop id="bg-video">
   <source
      src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
      type="video/mp4">
</video>
    <form class="form" action="${contextPath }/member/addMember.do" method="post" id="joinForm">
        <p class="title">회원가입창</p>
        <p class="message">회원가입후 즐겨보세요!</p>

        <div class="form-column left-column">
        <div class="flex">
            <label style="flex: 1;">
                <input class="input" type="text" name="id" id="id" required>
                <span>아이디</span>
            </label>
            <button type="button" class="submit" id="checkIdBtn" style="flex: 0 1 100px;" onclick="fn_checkId()">중복체크</button>
        </div>

        <label>
            <input class="input" type="password" name="pwd" required>
            <span>비밀번호</span>
        </label>

        <div class="flex">
        <label style="flex: 1;">
            <input class="input" type="email" name="email" id="email" required>
            <span>이메일</span>
        </label>
        <button type="button" class="submit" id="sendCodeBtn" onclick="sendVerificationCode()">인증번호 보내기</button>
    </div>
        <label id="verificationSection" style="display: none; width: 100%;">
            <input class="input" type="text" id="verificationCodeInput" placeholder="인증번호 입력">
        </label>

        <button type="button" class="submit" id="verifyBtn" style="display: none;" onclick="verifyCode()">인증 확인</button>
    </div>

        <div class="form-column right-column">

        <div class="date-input-group">
        <label for="birth">
            <input class="input" type="date" name="birth" required>
            <span>생년월일</span>
        </label>
        </div>

        <label>
            <select class="input" name="gender" required>
                <option value="" disabled selected>성별</option>
                <option value="M">남성</option>
                <option value="F">여성</option>
            </select>
        </label>

        <label>
            <input class="input" type="tel" name="phonenumber" required>
            <span>전화번호</span>
        </label>

        <label>
            <input class="input" type="text" name="name" required>
            <span>이름</span>
        </label>
        </div>

        <button class="submit" id="submitBtn" type="submit" disabled>회원가입</button>
        <p class="signin">이미 계정이 있으신가요? <a href="${contextPath }/member/loginForm.do">로그인</a></p>
    </form>


</body>
</html>