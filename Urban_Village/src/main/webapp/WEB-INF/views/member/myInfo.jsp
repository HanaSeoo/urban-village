<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인정보</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f7f2;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 15px 0;
        }
       
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

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }

        .content {
            padding: 15px;
            display: flex;
            flex-direction: column;
            min-height: calc(100vh - 30px);
        }

        .page-content {
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
        }

        .info-form-container {
            flex: 1;
            min-width: 300px;
        }

        .faq-container {
            width: 400px;
        }

        .info-box {
            background: #ffffff;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
            width: 100%;
            position: relative;
        }

        h2 {
            color: #222222;
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 24px;
            text-align: left;
        }

        .form-container {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
        }

        .left-column, .right-column {
            flex: 1;
            min-width: 300px;
        }

        .form-control {
            border: 1px solid #dddddd;
            border-radius: 8px;
            background-color: #ffffff;
            font-size: 16px;
            padding: 12px;
            height: auto;
        }

        .form-control:focus {
            border-color: #ff385c;
            box-shadow: 0 0 0 1px rgba(255, 56, 92, 0.2);
        }

        .form-label {
            font-weight: 500;
            color: #222222;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .btn-primary {
            background-color: #ff385c;
            border-color: #ff385c;
            border-radius: 8px;
            font-weight: 500;
            padding: 12px 24px;
            transition: all 0.2s;
        }

        .btn-primary:hover {
            background-color: #e31c5f;
            border-color: #e31c5f;
        }

        .delete-btn {
            background-color: #ffffff;
            border-color: #222222;
            color: #222222;
            border-radius: 8px;
            font-weight: 500;
            padding: 12px 24px;
            transition: all 0.2s;
        }

        .delete-btn:hover {
            background-color: #f7f7f7;
            border-color: #000000;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 24px;
        }

        .error-message {
            color: #ff385c;
            font-size: 14px;
            margin-top: 4px;
        }

        .mb-3 {
            margin-bottom: 20px;
        }

        .navigation {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .navigation a {
            color: #222222;
            text-decoration: none;
        }

        .navigation span {
            margin: 0 8px;
            color: #717171;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            color: #222222;
            margin-bottom: 32px;
        }

        /* FAQ 스타일 */
        .faq-section {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
            padding: 24px;
            width: 100%;
        }
        
        .faq-card {
            padding: 16px 0;
        }
        
        .faq-icon {
            margin-bottom: 16px;
            color: #ff385c;
        }
        
        .faq-section h3 {
            font-size: 16px;
            font-weight: 600;
            color: #222222;
            margin-bottom: 8px;
        }
        
        .faq-section p {
            font-size: 14px;
            color: #717171;
            line-height: 1.5;
            margin: 0;
        }
        
        .faq-divider {
            border: 0;
            height: 1px;
            background-color: #DDDDDD;
            margin: 16px 0;
        }

        @media (max-width: 992px) {
            .page-content {
                flex-direction: column;
            }
            
            .faq-container {
                width: 100%;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("form").submit(function(event) {
                var phoneNumber = $("input[name='phonenumber']").val();
                var email = $("input[name='email']").val();
                var name = $("input[name='name']").val();
                var pwd = $("input[name='pwd']").val();
                var birth = $("input[name='birth']").val();
                var gender = $("select[name='gender']").val();
                var hasError = false;
                var phoneRegex = /^\d{3}-\d{4}-\d{4}$/;
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                $(".error-message").remove();

                if (name === "") {
                    $("<p class='error-message'>이름을 입력하세요.</p>").insertAfter($("input[name='name']"));
                    $("input[name='name']").focus();
                    hasError = true;
                }

                if (email === "") {
                    $("<p class='error-message'>이메일을 입력하세요.</p>").insertAfter($("input[name='email']"));
                    $("input[name='email']").focus();
                    hasError = true;
                } else if (!emailRegex.test(email)) {
                    $("<p class='error-message'>이메일 형식이 올바르지 않습니다.</p>").insertAfter($("input[name='email']"));
                    $("input[name='email']").focus();
                    hasError = true;
                }

                if (birth === "") {
                    $("<p class='error-message'>생년월일을 입력하세요.</p>").insertAfter($("input[name='birth']"));
                    $("input[name='birth']").focus();
                    hasError = true;
                }

                if (gender === "") {
                    $("<p class='error-message'>성별을 선택하세요.</p>").insertAfter($("select[name='gender']").parent());
                    $("select[name='gender']").focus();
                    hasError = true;
                }

                if (phoneNumber === "") {
                    $("<p class='error-message'>전화번호를 입력하세요.</p>").insertAfter($("input[name='phonenumber']"));
                    $("input[name='phonenumber']").focus();
                    hasError = true;
                } else if (!phoneRegex.test(phoneNumber)) {
                    $("<p class='error-message'>전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)</p>").insertAfter($("input[name='phonenumber']"));
                    $("input[name='phonenumber']").focus();
                    hasError = true;
                }

                if (hasError) {
                    event.preventDefault();
                }
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
    <div class="main-container">
        <div class="content">
            <div class="navigation">
                <a href="${contextPath}">계정</a>
                <span>›</span>
                <a href="#">개인정보</a>
            </div>
            <h2 class="page-title">개인정보</h2>
            
            <div class="page-content">
                <!-- 왼쪽: 사용자 정보 폼 -->
                <div class="info-form-container">
                    <div class="info-box">
                        <form action="${contextPath}/member/updateUserInfo.do" method="post">
                            <c:if test="${memberList != null}">
                                <div class="form-container">
                                    <div class="left-column">
                                        <div class="mb-3">
                                            <label for="id" class="form-label">아이디</label>
                                            <input type="text" class="form-control" id="id" name="id" value="${memberList[0].id}" readonly>
                                        </div>
                                        <div class="mb-3">
                                            <label for="password" class="form-label">비밀번호</label>
                                            <input type="password" class="form-control" id="pwd" name="pwd" value="${memberList[0].pwd}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="email" class="form-label">이메일</label>
                                            <input type="email" class="form-control" id="email" name="email" value="${memberList[0].email}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="birthdate" class="form-label">생년월일</label>
                                            <input type="date" class="form-control" id="birthdate" name="birth" value="${memberList[0].birth}" readonly>
                                        </div>
                                    </div>
                                    <div class="right-column">
                                        <div class="mb-3">
                                            <label for="gender" class="form-label">성별</label>
                                            <select class="form-control" id="gender" name="gender" readonly>
                                                <option value="남성" ${memberList[0].gender == '남성' ? 'selected' : ''}>남성</option>
                                                <option value="여성" ${memberList[0].gender == '여성' ? 'selected' : ''}>여성</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="phone" class="form-label">전화번호</label>
                                            <input type="tel" class="form-control" id="phone" name="phonenumber" value="${memberList[0].phonenumber}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="name" class="form-label">이름</label>
                                            <input type="text" class="form-control" id="name" name="name" value="${memberList[0].name}">
                                        </div>
                                        <div class="button-group">
                                            <button type="submit" class="btn btn-primary">저장하기</button>
                                            <button type="button" class="btn delete-btn" onclick="location.href='${contextPath}/member/deleteMemberForm.do'" data-url="${contextPath}/member/deleteMemberForm.do">계정 삭제</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </form>
                    </div>
                </div>
                
                <!-- 오른쪽: FAQ 섹션 -->
                <div class="faq-container">
                    <div class="faq-section">
                        <div class="faq-card">
                            <div class="faq-icon">
                                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="width: 32px; height: 32px;">
                                    <rect x="4" y="4" width="16" height="18" rx="2" stroke="#ff385c" stroke-width="1.5"/>
                                    <path d="M8 10H16" stroke="#ff385c" stroke-width="1.5" stroke-linecap="round"/>
                                    <path d="M8 14H13" stroke="#ff385c" stroke-width="1.5" stroke-linecap="round"/>
                                    <rect x="14" y="2" width="8" height="4" rx="1" fill="white" stroke="#ff385c" stroke-width="1.5"/>
                                </svg>
                            </div>
                            <h3>여기에 내 개인정보가 표시되지 않는 이유가 무엇인가요?</h3>
                            <p>신분이 노출되지 않도록 일부 개정 정보가 숨김 처리되었습니다.</p>
                        </div>
                        
                        <hr class="faq-divider">
                        
                        <div class="faq-card">
                            <div class="faq-icon">
                                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="width: 32px; height: 32px;">
                                    <path d="M19 11H5C3.89543 11 3 11.8954 3 13V19C3 20.1046 3.89543 21 5 21H19C20.1046 21 21 20.1046 21 19V13C21 11.8954 20.1046 11 19 11Z" stroke="#ff385c" stroke-width="1.5"/>
                                    <path d="M7 11V7C7 4.23858 9.23858 2 12 2C14.7614 2 17 4.23858 17 7V11" stroke="#ff385c" stroke-width="1.5"/>
                                    <circle cx="12" cy="16" r="1" fill="#ff385c"/>
                                </svg>
                            </div>
                            <h3>수정할 수 있는 세부 정보는 무엇인가요?</h3>
                            <p>연락처 정보와 계정정보를 수정하실 수 있습니다. 본인 인증 시 이 정보를 사용했다면 호스팅을 계속하기 위해 도는 다음번 예약 전화 시 다시 인증을 받으셔야 합니다.</p>
                        </div>
                        
                        <hr class="faq-divider">
                        
                        <div class="faq-card">
                            <div class="faq-icon">
                                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="width: 32px; height: 32px;">
                                    <circle cx="12" cy="12" r="9" stroke="#ff385c" stroke-width="1.5"/>
                                    <circle cx="12" cy="10" r="3" stroke="#ff385c" stroke-width="1.5"/>
                                    <path d="M17.5 19.5C16.3972 17.5568 14.2955 16 11.5 16C8.95837 16 7.00242 17.3947 6 19.5" stroke="#ff385c" stroke-width="1.5"/>
                                </svg>
                            </div>
                            <h3>다른 사람에게 어떤 정보가 공개되나요?</h3>
                            <p>Urban & Village는 예약이 확정된 후에만 호스트 및 게스트의 연락처 정보를 공개합니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>