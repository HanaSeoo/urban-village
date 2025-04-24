package com.test.Urban_Village.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public interface AdminController {
	public ModelAndView login(RedirectAttributes rAttr,
			@RequestParam("id") String id,
			@RequestParam("pwd") String pwd,
			HttpServletRequest request,
			HttpServletResponse response);

	public ModelAndView logout(RedirectAttributes rAttr,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	public ModelAndView loginForm(@RequestParam(value="action", required=false)
				String action,
				HttpServletRequest request,
				HttpServletResponse response);

	public ModelAndView cleanerDetail(String memberId, HttpServletRequest request, HttpServletResponse response);

	public ModelAndView cleanerList(HttpServletRequest request, HttpServletResponse response);
}