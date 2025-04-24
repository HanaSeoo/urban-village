<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>도움말 센터 | Urban&Village</title>
<script>
    // 기존 애니메이션 스크립트 그대로
    document.addEventListener('DOMContentLoaded', function() {
        const animatedElements = document.querySelectorAll('.animate-on-scroll');
        const observerOptions = {
            root: null,
            rootMargin: '0px',
            threshold: 0.2
        };
        const observerCallback = (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('is-visible');
                    observer.unobserve(entry.target);
                }
            });
        };
        const observer = new IntersectionObserver(observerCallback, observerOptions);
        animatedElements.forEach(element => {
            observer.observe(element);
        });
    });
    
    //스크롤 될때 헤더 배경색상 바꾸는거
  window.addEventListener("scroll", function () {
    const header = document.querySelector(".header");
    if (window.scrollY > 50) {
      header.classList.add("scrolled");
    } else {
      header.classList.remove("scrolled");
    }
  });

</script>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/seoul-font@1.0.0/seoul-hangang.css" />

<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap');

body {
	font-family: 'SeoulHangang', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #faf7f2;
	color: #4e3629;
}

.help-content {
	padding-top: 200px;
}
.container {
	position: relative;
	z-index: 1;
	padding: 20px;
	border-radius: 12px;
	margin: 0 auto;
	max-width: 800px;
}
.header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
	color: white;
	padding: 20px 60px;
	font-size: 18px;
	font-weight: bold;
	backdrop-filter: blur(8px);
	transition: background-color 0.3s ease;
	text-align: center;
}

.header.scrolled {
	background-color: black;
}

.header a {
	color: white;
	text-decoration: none;
}
.header a:hover {
	color: #dddddd;
}

.header h1 {
	font-size: 50px;
	font-weight: 700;
	letter-spacing: 1px;
	text-align: center;
	margin: 0;
	margin-right: 120px;
}

.subtitle {
	color: #d4a76a;
	font-size: 18px;
}

.section {
	margin-bottom: 60px;
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
	background-color: #8b5a2b;
}

h2 {
	color: #8b5a2b;
	font-size: 28px;
	margin-top: 10px;
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

p {
	font-size: 16px;
	line-height: 1.7;
	color: #4e3629;
}

/* 카드 스타일 */
.link-card {
	flex: 1 1 45%;
	border: 1px solid #e0d6c6;
	border-radius: 12px;
	padding: 25px;
	box-shadow: 0 5px 15px rgba(139, 90, 43, 0.1);
	background-color: #fdfbf7;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	margin-top: 20px;
}

.link-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 20px rgba(139, 90, 43, 0.2);
}

.link-card h3 {
	font-size: 22px;
	margin-bottom: 15px;
	color: #8b5a2b;
	border-bottom: 2px solid #d4a76a;
	padding-bottom: 10px;
}

.link-card p {
	font-size: 16px;
	color: #5d4b3c;
}

/* 애니메이션 */
.animate-on-scroll {
	opacity: 0;
	transition: opacity 1s ease-out, transform 1s ease-out;
	will-change: opacity, transform;
}
.animate-bottom {
	transform: translateY(50px);
}
.animate-bottom.is-visible {
	opacity: 1;
	transform: translateY(0);
}

/* 주의사항 */
.caution {
	background-color: #fff0f0;
	border-left: 5px solid #ff5252;
	padding: 15px;
	margin: 20px 0;
	animation: cautionBlink 2s infinite;
}
@keyframes cautionBlink {
	0% { background-color: #fff0f0; }
	50% { background-color: #ffdbdb; }
	100% { background-color: #fff0f0; }
}

.important {
	color: #ff3333;
	text-decoration: underline;
	font-weight: bold;
}

/* 한옥 장식 */
.hanok-divider {
	height: 30px;
	background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
	background-repeat: repeat-x;
	background-size: 100px 20px;
	margin: 40px 0;
}

/* 목록 */
ul {
	padding-left: 25px;
	line-height: 1.9;
	color: #5d4b3c;
}
ul li::before {
	content: '•';
	color: #d4a76a;
	font-weight: bold;
	display: inline-block;
	width: 1em;
	margin-left: -1em;
}

/* 배경 영상 */
#bg-video {
	position: fixed;
	right: 0;
	bottom: 0;
	min-width: 100%;
	min-height: 100%;
	z-index: -2;
	object-fit: cover;
}
.video-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: -1;
}

/* 반응형 */
@media (max-width: 768px) {
	.link-card {
		flex: 1 1 100%;
	}
	h2 {
		font-size: 24px;
	}
	.section {
		padding: 20px;
	}
}
.footer {
	margin-top: 50px;
	text-align: center;
	background: rgba(255, 255, 255, 0.7);
}

.footer a {
	color: #000000;
	margin: 0 10px;
	text-decoration: none;
	transition: color 0.3s;
}

.footer a:hover {
	color: #000000;
	text-decoration: underline;
}
</style>
</head>
<body>

	<video autoplay muted loop id="bg-video">
		<source
			src="/Urban_Village/resources/helpCenterImage/countryside1.mp4"
			type="video/mp4">
		브라우저가 비디오를 지원하지 않습니다.
	</video>

	<!-- 전체 페이지에 어두운 오버레이 추가 (가독성) -->
	<div class="video-overlay"></div>

	<div class="header">
		<div class="logo">
    	<a href="/Urban_Village/"><h1>Urban&Village 도움말 센터</h1></a>
	    </div>
	</div>
	<div class="help-content">
		<div class="container">
			<div class="section animate-on-scroll animate-bottom">
				<h2>이용 약관 및 정책</h2>
				<div class="link-card">
					<h3>Urban&Village 커뮤니티 가이드라인</h3>
					<p>본 사이트를 이용함으로써 회원은 다음의 가이드라인을 준수해야 합니다. 고객 간 신뢰와 안전을 바탕으로 한
						커뮤니티를 운영하기 위해 아래 정책을 꼭 확인해 주세요.</p>
					<ul>
						<li>모든 이용자는 <span class="important">실제 정보를 기반으로 계정을 생성</span>해야
							합니다.
						</li>
						<li>숙소 등록자는 정확한 사진과 설명을 제공해야 합니다.</li>
						<li>고객 간 예의 바른 커뮤니케이션을 유지해야 하며, 차별 또는 혐오 표현은 금지됩니다.</li>
						<li>불법 활동, 무단 침입, 기물 파손 등은 즉각적인 제재의 대상이 됩니다.</li>
					</ul>
				</div>

				<div class="caution">
					<p>
						<strong>주의사항:</strong> Urban&Village 계정 정보를 타인과 공유하거나 양도하는 행위는 <span
							class="important">서비스 이용 제한</span>의 사유가 될 수 있습니다. 계정 보안에 각별히
						유의해주세요.
					</p>
				</div>

				<div class="link-card" style="margin-top: 25px;">
					<h3>개인정보 처리방침</h3>
					<p>Urban&Village는 회원님의 개인정보 보호를 최우선으로 생각합니다. 고객 정보는 안전하게 보호되며,
						동의 없이 제3자에게 제공되지 않습니다.</p>
					<ul>
						<li>수집하는 개인정보: 이름, 이메일, 전화번호, 생년월일, 결제 정보</li>
						<li>개인정보 보관 기간: 회원 탈퇴 후 최대 <span class="important">5년간
								보관</span> (관련 법령에 따름)
						</li>
						<li>개인정보 열람 및 정정: 언제든지 마이페이지에서 가능</li>
						<li>마케팅 정보 수신 동의는 마이페이지에서 언제든지 변경 가능합니다</li>
					</ul>
				</div>
			</div>

			<div class="hanok-divider"></div>

			<div class="section animate-on-scroll animate-bottom">
				<h2>호스트 정책</h2>
				<div class="link-card">
					<h3>호스트의 책임과 권한</h3>
					<p>Urban&Village 플랫폼을 통해 숙소를 운영하는 호스트는 다음의 정책을 따릅니다.</p>
					<ul>
						<li>숙소의 상태와 서비스는 <span class="important">숙소 설명과 동일</span>해야
							합니다.
						</li>
						<li>게스트의 문의에 24시간 이내에 응답해야 합니다.</li>
						<li>정확한 체크인·체크아웃 정보를 사전에 안내해야 합니다.</li>
						<li>게스트 리뷰는 객관적이고 공정하게 대응해야 합니다.</li>
					</ul>
				</div>

				<div class="link-card" style="margin-top: 25px;">
					<h3>숙소 등록 및 관리</h3>
					<p>숙소를 등록하고 관리하는 과정에서 다음 사항을 준수해야 합니다.</p>
					<ul>
						<li>모든 사진은 <span class="important">최근 3개월 이내</span>에 촬영된 실제
							숙소 사진이어야 합니다.
						</li>
						<li>편의시설, 주변 환경, 접근성에 대한 정보를 정확하게 기재해야 합니다.</li>
						<li>숙소 가격은 추가 비용 없이 투명하게 공개되어야 합니다.</li>
						<li>호스트 직접 응대가 어려운 경우, 대체 연락처를 반드시 제공해야 합니다.</li>
						<li>숙소 내 안전 장비(소화기, 구급상자 등)의 위치를 게스트에게 안내해야 합니다.</li>
					</ul>
				</div>

				<div class="caution">
					<p>
						<strong>주의사항:</strong> 허위 정보 등록이나 과장된 설명으로 인해 게스트에게 피해가 발생할 경우, <span
							class="important">계정 영구 정지 및 법적 책임</span>이 발생할 수 있습니다.
					</p>
				</div>
			</div>

			<div class="hanok-divider"></div>

			<div class="section animate-on-scroll animate-bottom">
				<h2>게스트 행동 수칙</h2>
				<div class="link-card">
					<h3>모두를 위한 안전하고 즐거운 여행</h3>
					<p>Urban&Village의 게스트는 다음과 같은 행동 수칙을 준수해야 합니다.</p>
					<ul>
						<li>숙소 내 물품을 파손하거나 무단으로 반출해서는 안 됩니다.</li>
						<li>숙소에서의 <span class="important">과도한 소음, 파티 등은 제한</span>됩니다.
						</li>
						<li>호스트 및 이웃과의 모든 커뮤니케이션은 존중을 기반으로 해야 합니다.</li>
						<li>숙소 이용 시 제공된 체크인/아웃 시간을 준수해야 합니다.</li>
						<li>숙소 내 안전 장비(소화기, 구급상자 등)의 위치를 게스트에게 안내해야 합니다.</li>
					</ul>
				</div>

				<div class="link-card" style="margin-top: 25px;">
					<h3>예약 및 결제 정책</h3>
					<p>게스트는 예약 및 결제와 관련하여 다음 사항을 숙지해야 합니다.</p>
					<ul>
						<li>예약 확정 후 발생하는 <span class="important">취소 수수료</span>는 예약
							시점과 체크인 날짜에 따라 달라집니다.
						</li>
						<li>체크인 7일 전 취소: 전액 환불</li>
						<li>체크인 3-6일 전 취소: 50% 환불</li>
						<li>체크인 2일 전 이후 취소: 환불 불가</li>
						<li>천재지변, 호스트 취소 등 불가항력적 상황에서는 전액 환불 가능합니다.</li>
					</ul>
				</div>

				<div class="caution">
					<p>
						<strong>주의사항:</strong> 숙소 내 <span class="important">흡연 및
							지정된 인원 초과</span> 이용은 즉각적인 퇴실 조치와 추가 청소 비용이 발생할 수 있습니다.
					</p>
				</div>
			</div>

			<div class="hanok-divider"></div>

			<div class="section animate-on-scroll animate-bottom">
				<h2>애완동물 출입 시 이용약관</h2>
				<div class="link-card">
					<h3>반려동물과 함께하는 여행</h3>
					<p>Urban&Village는 반려동물과 함께하는 여행을 지원합니다. 다만, 모든 게스트와 호스트의 편안한
						이용을 위해 다음 규정을 준수해주세요.</p>
					<ul>
						<li><span class="important">반려동물 동반 가능 숙소</span>에만 예약이 가능합니다.</li>
						<li>예약 시 반려동물의 종류, 크기, 수를 정확히 기재해야 합니다.</li>
						<li>모든 반려동물은 예방접종을 완료한 상태여야 합니다.</li>
						<li>반려동물로 인한 숙소 내 파손이 발생할 경우, 게스트가 수리 비용을 부담해야 합니다.</li>
						<li>공용 공간에서는 반드시 목줄을 착용해야 합니다.</li>
					</ul>
				</div>

				<div class="link-card" style="margin-top: 25px;">
					<h3>반려동물 동반 시 추가 비용</h3>
					<p>반려동물과 함께 숙소를 이용할 경우 다음과 같은 추가 비용이 발생할 수 있습니다.</p>
					<ul>
						<li>소형 동물(10kg 미만): 1박당 <span class="important">20,000원</span>
							추가
						</li>
						<li>중형 동물(10-25kg): 1박당 30,000원 추가</li>
						<li>대형 동물(25kg 이상): 1박당 40,000원 추가</li>
						<li>안내견 및 도우미견은 추가 비용 없이 이용 가능합니다.</li>
						<li>특수 동물(파충류, 조류 등)은 호스트와 사전 협의가 필요합니다.</li>
						</li>
					</ul>
				</div>

				<div class="caution">
					<p>
						<strong>주의사항:</strong> 숙소 예약 시 <span class="important">반려동물
							동반 여부를 숨기고 입실</span>하는 경우, 즉시 퇴실 조치되며 환불이 불가합니다.
					</p>
				</div>
			</div>

			<div class="hanok-divider"></div>

			<div class="section image-section animate-on-scroll animate-bottom">
				<h2>Urban&Village 한옥 체험</h2>
				<img
					src="https://imagescdn.gettyimagesbank.com/500/201907/jv11861189.jpg"
					alt="Urban&Village 한옥 전경">
				<p style="text-align: center; margin-top: 15px; font-style: italic;">전통과
					현대가 공존하는 Urban&Village의 특별한 한옥 체험</p>
			</div>

			<div class="hanok-divider"></div>

			

		<div class="footer">
			<p>© 2025 Urban&Village. 모든 권리 보유.</p>
			<div style="margin-top: 15px;">
				<a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
				| <a href="#">소셜미디어</a>
			</div>
		</div>
	</div>

		<script>
document.addEventListener('DOMContentLoaded', function() {
    // 애니메이션 요소 선택
    const animatedElements = document.querySelectorAll('.animate-on-scroll');

    // Intersection Observer 설정
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.2 // 20%가 보일 때 애니메이션 시작
    };

    // Observer 콜백 함수
    const observerCallback = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                // 요소가 화면에 보이면 is-visible 클래스 추가
                entry.target.classList.add('is-visible');
                // 애니메이션이 한 번만 실행되도록 관찰 중단
                observer.unobserve(entry.target);
            }
        });
    };

    // Observer 인스턴스 생성
    const observer = new IntersectionObserver(observerCallback, observerOptions);

    // 각 요소 관찰 시작
    animatedElements.forEach(element => {
        observer.observe(element);
    });
});
</script>
</body>
</html>