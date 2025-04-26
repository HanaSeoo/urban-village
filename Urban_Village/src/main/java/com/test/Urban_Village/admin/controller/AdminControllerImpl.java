package com.test.Urban_Village.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.dto.AccommodationIdDTO;
import com.test.Urban_Village.admin.dto.AdminDTO;
import com.test.Urban_Village.admin.service.AdminService;
import com.test.Urban_Village.admin.service.AdminServiceImpl;
import com.test.Urban_Village.cleaner.dto.CleanerDTO;
import com.test.Urban_Village.cleaner.service.CleanerService;

@Controller
@RequestMapping("/admin")
public class AdminControllerImpl implements AdminController {
	@Autowired
	AdminService adminService; // AdminService로 인터페이스 타입 주입
	@Autowired
	HttpSession session;
	@Autowired
	CleanerService cleanerService;
	
	

	@Override
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(RedirectAttributes rAttr,
			@RequestParam("id") String id, @RequestParam("pwd") String pwd,
			HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		session = request.getSession();
		AdminDTO admin = adminService.login(id, pwd); // AdminService의 login 메서드 사용
		if (admin != null) {
			System.out.println("로그인 성공");

			session.setAttribute("isAdmin", true);
			session.setAttribute("adminInfo", admin);
			mav.setViewName("redirect:/");
			String action = (String) session.getAttribute("action");
			session.removeAttribute("action");
			if(action != null) {
				mav.setViewName("redirect:"+action);
			}
		} else {
			mav.setViewName("admin/loginForm"); // 관리자 로그인 실패 시 관리자 로그인 폼으로
			mav.addObject("error", "잘못된 로그인 정보입니다.");
			rAttr.addAttribute("result", "loginFailed");
		}
		return mav;
	}

	@Override
	@RequestMapping("/logout.do")
	public ModelAndView logout(RedirectAttributes rAttr,
			HttpServletRequest request,
			HttpServletResponse response)
					throws Exception {
		session = request.getSession(false);
		ModelAndView mav = new ModelAndView();
		Boolean isLogin = (Boolean) session.getAttribute("isLogin");
		if(session != null && session.getAttribute("isAdmin") != null) {
			session.invalidate();
			rAttr.addAttribute("result", "logout");
		} else {
			rAttr.addAttribute("result", "notLogin");
		}
		mav.setViewName("redirect:/admin/loginForm.do"); // 로그아웃 후 관리자 로그인 폼으로 이동
		return mav;
	}

	@Override
	@RequestMapping("/loginForm.do")
	public ModelAndView loginForm(@RequestParam(value="action", required=false)
	String action,
	HttpServletRequest request,
	HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		session.setAttribute("action", action);
		mav.setViewName("admin/loginForm"); // 관리자 로그인 폼 뷰 이름
		mav.addObject("viewName",viewName);
		System.out.println("viewName"+viewName);
		return	mav;
	}

	@Override
	@RequestMapping("/cleanerList.do")
	public ModelAndView cleanerList(HttpServletRequest request,
			HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		System.out.println(viewName);
		List<CleanerDTO> cleanerList = adminService.getCleanerList();
		List<String> accCleanerId = adminService.getAccCleanerId();
		mav.setViewName(viewName);
		mav.addObject("cleanerList", cleanerList);
		mav.addObject("accCleanerId", accCleanerId);
		return mav;

	}
	@Override
	@RequestMapping("/cleanerDetail.do")
	public ModelAndView cleanerDetail(@RequestParam("member_id") String memberId, HttpServletRequest request,
			HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		CleanerDTO cleaner = adminService.getCleanerDetail(memberId);
		mav.setViewName(viewName);
		mav.addObject("cleaner", cleaner);
		return mav;
	}

	@RequestMapping("/hostAccBest.do")
	public ModelAndView hostAccBest(@ModelAttribute("AccommodationDTO")AccommodationDTO accDTO,@ModelAttribute("AccommodationIdDTO")AccommodationIdDTO accIdDTO, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("ViewName");
		String adminId = (String) session.getAttribute("adminId");

		System.out.println("관리자 로그인 아이디 :" + adminId );
		accIdDTO.setAdmin_id(adminId);
		System.out.println("합쳐진 아이디 " + accIdDTO.getAdmin_id());

		List<AccommodationIdDTO> hostBestAccIdList = adminService.accIdList(accIdDTO);
		mav.addObject("hostBestAccIdList",hostBestAccIdList);
		accDTO.setAdmin_id(adminId);
		List<AccommodationDTO> accExceptBestList = adminService.accExceptBest(accDTO);
		mav.addObject("accExceptBest",accExceptBestList);
		mav.setViewName("/admin/hostAccBest");

		return mav;
	}

	@RequestMapping("/hostAccBestButton.do")
	public ModelAndView hostAccBestButton(@ModelAttribute("AccommodationIdDTO")AccommodationIdDTO accIdDTO,@RequestParam("accommodation_id")String accommodation_id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("ViewName");

		String adminId = (String) session.getAttribute("adminId");
		System.out.println("관리자 로그인 아이디 :" + adminId );
		accIdDTO.setAdmin_id(adminId);

		accIdDTO.setAccommodation_id(accommodation_id);
		int result = adminService.hostAccBest(accIdDTO);

		return new ModelAndView("redirect:/admin/hostAccBest.do");
	}

	@RequestMapping("/delHostAccBest.do")
	public ModelAndView delHostAccBest(@RequestParam("accommodation_id") String accommodation_id,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) {
		String adminId = (String) session.getAttribute("adminId");
		System.out.println("관리자 로그인 아이디 :" + adminId);
		AccommodationIdDTO accIdDTO = new AccommodationIdDTO();
		accIdDTO.setAdmin_id(adminId);
		accIdDTO.setAccommodation_id(accommodation_id);
		int result = adminService.deleteHostAccBest(accIdDTO);
		return new ModelAndView("redirect:/admin/hostAccBest.do");
	}
	
	@RequestMapping("/helpCenter.do")
	public ModelAndView startMain (HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/helpCenter/helpCenter");
		return mav;
	}


}