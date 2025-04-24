<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 검색</title>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    window.onload = function () {
        new daum.Postcode({
            oncomplete: function (data) {
                // 도로명 주소와 우편번호 추출
                const roadAddr = data.roadAddress;
                const zipNo = data.zonecode;

                // 부모창 함수 호출
                if (window.opener && typeof window.opener.jusoCallBack === 'function') {
                    window.opener.jusoCallBack(roadAddr, zipNo);
                }
                window.close();
            }
        }).open();
    };
</script>
</head>
<body>
</body>
</html>
