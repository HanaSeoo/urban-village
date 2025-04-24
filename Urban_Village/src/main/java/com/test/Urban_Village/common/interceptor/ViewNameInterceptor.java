package com.test.Urban_Village.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ViewNameInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		try {
			String viewName = getViewName(request);
			request.setAttribute("viewName", viewName);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return true;
	}
	private String getViewName(HttpServletRequest request) {
	    int start = request.getContextPath().length();
	    String uri = request.getRequestURI();
	    int end = uri.lastIndexOf(".");
	    
	    return uri.substring(start, end);  // "/urban/joinMember" -> "urban/joinMember"
	}


	
	

}
