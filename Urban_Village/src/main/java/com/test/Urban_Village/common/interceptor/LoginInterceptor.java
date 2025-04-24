package com.test.Urban_Village.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	        throws Exception {

	    HttpSession session = request.getSession();

	    // 고객과 관리자 로그인 정보
	    Boolean memberLogin = (Boolean) session.getAttribute("isLogin");
	    Boolean adminLogin = (Boolean) session.getAttribute("isAdmin");

	    if (memberLogin == null) memberLogin = Boolean.FALSE;
	    if (adminLogin == null) adminLogin = Boolean.FALSE;

	    String uri = request.getRequestURI(); 
	    System.out.println("요청: " + uri);
	    //고객 접근하기 그외 ㄴㄴ
	    if (uri.contains("/member/myInfo.do") || uri.contains("/member/myCoupon.do")
		        || uri.contains("/reservation/reservationHistory.do") || uri.contains("/reservation/reservationForm.do") 
		        || uri.contains("/reservation/reviewWrite.do") || uri.contains("/wishList/wishList.do") || uri.contains("/member/deleteMemberForm.do")) {

	        if (!memberLogin || adminLogin) {
	            response.sendRedirect(request.getContextPath() + "/member/loginForm.do");
	            return false;
	        }
	    }

	    //관리자만 접근 고객 ㄴㄴ
	    if (uri.contains("/admin/accommodationList.do") || uri.contains("/admin/cleanerList.do") || uri.contains("/admin/cleanerDetail.do") 
			        || uri.contains("/admin/hostAccBest.do") || uri.contains("/cleaner/cleanerAddAcc.do") 
			        || uri.contains("/accommodation/accommodationForm.do") || uri.contains("/accommodation/modAccommodationForm.do")
			        || uri.contains("/reservation/reviewList.do")) {

	        if (!adminLogin || memberLogin) {
	            response.sendRedirect(request.getContextPath() + "/member/loginForm.do");
	            return false;
	        }
	    }

	    // 모두 통과
	    return true;
	}




	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
