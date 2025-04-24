<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 현황</title>
<style>
@import
   url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap')
   ;

@import
   url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap')
   ;

/* 기본 스타일 */
body {
   font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', Dotum, Gulim,
      sans-serif;
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

h1 {
   font-size: 36px;
   font-weight: 700;
   margin: 0;
   text-align: center;
   letter-spacing: 1px;
}

.content-wrapper {
   display: flex;
   flex-wrap: wrap;
   gap: 30px;
}

.tables-container {
   width: 47%;
   box-sizing: border-box;
}

.charts-container {
   width: 47%;
   box-sizing: border-box;
   position: sticky;
   top: 20px;
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

h2 {
   color: #8b5a2b;
   font-size: 24px;
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

.button-container {
   display: flex;
   justify-content: center;
   gap: 15px;
   margin-bottom: 30px;
}

.button-container button {
   background-color: #8b5a2b;
   color: white;
   padding: 12px 25px;
   border-radius: 30px;
   font-weight: 600;
   border: 2px solid #8b5a2b;
   cursor: pointer;
   transition: all 0.3s;
}

.button-container button:hover {
   background-color: #d4a76a;
   border-color: #d4a76a;
   transform: translateY(-3px);
   box-shadow: 0 5px 15px rgba(139, 90, 43, 0.3);
}

table {
   width: 100%;
   border-collapse: collapse;
   margin-top: 20px;
}

th, td {
   border: 1px solid #e0d6c6;
   padding: 12px;
   text-align: center;
}

th {
   background-color: #f2e7d5;
   color: #8b5a2b;
   font-weight: 600;
}

tr:nth-child(even) {
   background-color: #fdfbf7;
}

tr:hover {
   background-color: #f5efe5;
}

.chart {
   width: 100%;
   height: 300px;
   margin-bottom: 40px;
   background-color: #fff;
   border-radius: 15px;
   box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
   padding: 20px;
   box-sizing: border-box;
}

.no-data {
   text-align: center;
   padding: 30px;
   font-style: italic;
   color: #8b5a2b;
}

/* 한옥 장식 요소 */
.hanok-divider {
   height: 30px;
   background-image:
      url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="20" viewBox="0 0 100 20"><path d="M0,10 Q25,-10 50,10 T100,10" fill="none" stroke="%238b5a2b" stroke-width="2"/></svg>');
   background-repeat: repeat-x;
   background-size: 100px 20px;
   margin: 40px 0;
}

/* 애니메이션 스타일 */
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

/* 푸터 스타일 */
.footer {
   background-color: #8b5a2b;
   padding: 20px;
   border-top: 5px solid #d4a76a;
   font-size: 14px;
   text-align: center;
   color: #ffffff;
   margin-top: 40px;
}

/* 반응형 조정 */
@media ( max-width : 900px) {
   .tables-container, .charts-container {
      width: 100%;
   }
   .charts-container {
      position: static;
   }
}
</style>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
</head>
<body>

   <h1>매출 현황</h1>

   <div class="container">
      <div class="button-container">
         <button
            onclick="location.href='${contextPath}/member/getDailySales.do'">일별
            매출</button>
         <button
            onclick="location.href='${contextPath}/member/getMonthlySales.do'">월별
            매출</button>
         <button
            onclick="location.href='${contextPath}/member/getYearlySales.do'">연도별
            매출</button>
      </div>

      <div class="content-wrapper">
         <!-- 왼쪽 - 매출 표 -->
         <div class="tables-container">
            <c:if test="${not empty dailySalesList}">
               <div class="section">
                  <h2>일별 매출</h2>
                  <table>
                     <thead>
                        <tr>
                           <th>매출일</th>
                           <th>총 매출</th>
                        </tr>
                     </thead>
                     <tbody>
                        <c:forEach var="sales" items="${dailySalesList}">
                           <tr>
                              <td>${sales.sale_date}</td>
                              <td><fmt:formatNumber value="${sales.total_sales}"
                                    pattern="#,###.##" /> 원</td>
                           </tr>
                        </c:forEach>
                     </tbody>
                  </table>
               </div>
            </c:if>

            <c:if test="${not empty monthlySalesList}">
               <div class="section">
                  <h2>월별 매출</h2>
                  <table>
                     <thead>
                        <tr>
                           <th>매출월</th>
                           <th>총 매출</th>
                        </tr>
                     </thead>
                     <tbody>
                        <c:forEach var="sales" items="${monthlySalesList}">
                           <tr>
                              <td>${sales.sales_month}</td>
                              <td><fmt:formatNumber value="${sales.total_sales}"
                                    pattern="#,###.##" /> 원</td>
                           </tr>
                        </c:forEach>
                     </tbody>
                  </table>
               </div>
            </c:if>

            <c:if test="${not empty yearlySalesList}">
               <div class="section">
                  <h2>연도별 매출</h2>
                  <table>
                     <thead>
                        <tr>
                           <th>매출년도</th>
                           <th>총 매출</th>
                        </tr>
                     </thead>
                     <tbody>
                        <c:forEach var="sales" items="${yearlySalesList}">
                           <tr>
                              <td>${sales.sales_year}</td>
                              <td><fmt:formatNumber value="${sales.total_sales}"
                                    pattern="#,###.##" /> 원</td>
                           </tr>
                        </c:forEach>
                     </tbody>
                  </table>
               </div>
            </c:if>

            <c:if
               test="${empty dailySalesList and empty monthlySalesList and empty yearlySalesList}">
               <div class="section">
                  <p class="no-data">매출 데이터가 없습니다.</p>
               </div>
            </c:if>
         </div>

         <!-- 오른쪽 - 매출 그래프 -->
         <div class="charts-container">
            <c:if test="${not empty dailySalesList}">
               <div class="section animate-on-scroll animate-bottom"
                  id="daily-chart-section">
                  <h2>일별 매출 그래프</h2>
                  <div class="chart">
                     <canvas id="dailyChart"></canvas>
                  </div>
               </div>
            </c:if>

            <c:if test="${not empty monthlySalesList}">
               <div class="section animate-on-scroll animate-bottom"
                  id="monthly-chart-section">
                  <h2>월별 매출 그래프</h2>
                  <div class="chart">
                     <canvas id="monthlyChart"></canvas>
                  </div>
               </div>
            </c:if>

            <c:if test="${not empty yearlySalesList}">
               <div class="section animate-on-scroll animate-bottom"
                  id="yearly-chart-section">
                  <h2>연도별 매출 그래프</h2>
                  <div class="chart">
                     <canvas id="yearlyChart"></canvas>
                  </div>
               </div>
            </c:if>
         </div>
      </div>

      <div class="hanok-divider"></div>
   </div>

   <script>
    // 스크롤 애니메이션 관련 코드
    document.addEventListener('DOMContentLoaded', function() {
        var animateElements = document.querySelectorAll('.animate-on-scroll');
        
        function checkIfInView() {
            var windowHeight = window.innerHeight;
            var windowTopPosition = window.scrollY;
            var windowBottomPosition = windowTopPosition + windowHeight;
            
            animateElements.forEach(function(element) {
                var elementHeight = element.offsetHeight;
                var elementTopPosition = element.offsetTop;
                var elementBottomPosition = elementTopPosition + elementHeight;
                
                // 요소가 화면에 보이는지 확인
                if ((elementBottomPosition >= windowTopPosition) && 
                    (elementTopPosition <= windowBottomPosition)) {
                    element.classList.add('is-visible');
                }
            });
        }
        
        // 초기 로드시 확인
        checkIfInView();
        
        // 스크롤할 때마다 확인
        window.addEventListener('scroll', checkIfInView);
        
        // Chart.js를 사용한 차트 생성
        <c:if test="${not empty dailySalesList}">
            var dailyCtx = document.getElementById('dailyChart').getContext('2d');
            var dailyLabels = [];
            var dailyData = [];
            
            <c:forEach var="sales" items="${dailySalesList}">
                dailyLabels.push('${sales.sale_date}');
                dailyData.push(${sales.total_sales});
            </c:forEach>
            
            var dailyChart = new Chart(dailyCtx, {
                type: 'bar',
                data: {
                    labels: dailyLabels,
                    datasets: [{
                        label: '일별 매출 (원)',
                        data: dailyData,
                        backgroundColor: '#d4a76a',
                        borderColor: '#8b5a2b',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString() + '원';
                                }
                            }
                        }
                    }
                }
            });
        </c:if>
        
        <c:if test="${not empty monthlySalesList}">
            var monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
            var monthlyLabels = [];
            var monthlyData = [];
            
            <c:forEach var="sales" items="${monthlySalesList}">
                monthlyLabels.push('${sales.sales_month}');
                monthlyData.push(${sales.total_sales});
            </c:forEach>
            
            var monthlyChart = new Chart(monthlyCtx, {
                type: 'line',
                data: {
                    labels: monthlyLabels,
                    datasets: [{
                        label: '월별 매출 (원)',
                        data: monthlyData,
                        backgroundColor: 'rgba(212, 167, 106, 0.2)',
                        borderColor: '#8b5a2b',
                        borderWidth: 2,
                        tension: 0.3,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString() + '원';
                                }
                            }
                        }
                    }
                }
            });
        </c:if>
        
        <c:if test="${not empty yearlySalesList}">
            var yearlyCtx = document.getElementById('yearlyChart').getContext('2d');
            var yearlyLabels = [];
            var yearlyData = [];
            
            <c:forEach var="sales" items="${yearlySalesList}">
                yearlyLabels.push('${sales.sales_year}');
                yearlyData.push(${sales.total_sales});
            </c:forEach>
            
            var yearlyChart = new Chart(yearlyCtx, {
                type: 'bar',
                data: {
                    labels: yearlyLabels,
                    datasets: [{
                        label: '연도별 매출 (원)',
                        data: yearlyData,
                        backgroundColor: [
                            '#d4a76a', '#8b5a2b', '#c19a6b', '#a67c52', '#e6bf8b',
                            '#b38b5d', '#caaa7d', '#9d7e5d', '#dcc096', '#967242'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString() + '원';
                                }
                            }
                        }
                    }
                }
            });
        </c:if>
    });
</script>
</body>
</html>