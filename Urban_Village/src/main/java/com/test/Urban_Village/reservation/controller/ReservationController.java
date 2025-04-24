package com.test.Urban_Village.reservation.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.reservation.dto.PayDTO;

public interface ReservationController {

	ModelAndView reservationForm(HttpServletRequest request, HttpServletResponse response);

	ModelAndView payList(HttpServletRequest request, HttpServletResponse response);

	ModelAndView reservationHistory(PayDTO payDTO, HttpServletRequest request, HttpServletResponse response);

	ModelAndView reservation(PayDTO payDTO, MemberDTO memberDTO, HttpServletRequest request,
			HttpServletResponse response);
	
}
