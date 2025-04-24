package com.test.Urban_Village.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.Urban_Village.accommodation.dao.AccommodationDAO;
import com.test.Urban_Village.accommodation.dao.AccommodationDAOImpl;
import com.test.Urban_Village.accommodation.dto.AccommodationDTO;
import com.test.Urban_Village.accommodation.service.AccommodationService;
import com.test.Urban_Village.accommodation.service.AccommodationServiceImpl;
import com.test.Urban_Village.admin.dto.AdminDTO;
import com.test.Urban_Village.admin.service.AdminService;
import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.dto.PayDTO;
import com.test.Urban_Village.member.service.MemberService;
import com.test.Urban_Village.review.service.ReviewService;

@Controller
@RequestMapping("/member")
public class MemberControllerImpl implements MemberController {

	@Autowired
	MemberService service;
	@Autowired
	AccommodationService accService;
	@Autowired
	HttpSession session;
	@Autowired
	AdminService adminService;
	@Autowired
	ReviewService reService;


	@Override
	   @RequestMapping("urbanMemberList.do")
	   public ModelAndView urbanMemberList(HttpServletRequest request, HttpServletResponse response) {
	       ModelAndView mav = new ModelAndView();
	       String viewName = (String) request.getAttribute("viewName");

	       String searchId = request.getParameter("keyword"); // 검색어 가져오기

	       List<MemberDTO> membersList;

	       if (searchId != null && !searchId.trim().isEmpty()) {
	           // 아이디로 검색
	           membersList = service.searchMembersById(searchId);
	       } else {
	           // 전체 회원 목록
	           membersList = service.listMembers();
	       }

	       mav.addObject("membersList", membersList);
	       mav.addObject("searchId", searchId); // JSP에서 검색어 유지
	       mav.setViewName(viewName);
	       return mav;
	   }

	// 로그인 폼 보여주는 메서드
	@Override
	@RequestMapping("/loginForm.do")
	public ModelAndView loginForm(@RequestParam(value="action", required=false) String action, HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		session.setAttribute("action", action); // 로그인 후 이동할 액션을 세션에 저장
		mav.setViewName(viewName);
		mav.addObject("viewName",viewName);
		System.out.println("viewName"+viewName);
		return mav;
	}

	// 로그인 처리 메서드
	@Override
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(RedirectAttributes rAttr, @RequestParam("id") String id, @RequestParam("pwd") String pwd, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		session = request.getSession();

		// 관리자 로그인 시도
		AdminDTO admin = adminService.login(id, pwd);
		if (admin != null) {
			session.setAttribute("isAdmin", true);
			session.setAttribute("adminInfo", admin);
			session.setAttribute("adminId", admin.getAdmin_id());
			String action = (String) session.getAttribute("action");
			session.removeAttribute("action");
			if(action != null) {
				mav.setViewName("redirect:"+action);
			}
			mav.setViewName("redirect:/"); // 메인 화면으로 리다이렉트
			return mav;
		}

		// 일반 회원 로그인 시도
		MemberDTO member = service.login(id, pwd);
		if (member != null) {
			// 회원 로그인 성공
			mav.setViewName("redirect:/");
			session.setAttribute("member", member);
			session.setAttribute("loginId", member.getId());
			session.setAttribute("memberName", member.getName()); //나중에 결제할 때 결제자 이름
			session.setAttribute("memberEmail", member.getEmail());
			session.setAttribute("memberGender", member.getGender());
			session.setAttribute("memberBirth", member.getBirth());
			session.setAttribute("memberPhone", member.getPhonenumber());
			session.setAttribute("isLogin", true);
			String action = (String) session.getAttribute("action");
			session.removeAttribute("action");
			if(action != null) {
				mav.setViewName("redirect:"+action);
			}
		} else {
			// 로그인 실패
			mav.setViewName("redirect:/member/loginForm.do");
			mav.addObject("error", "잘못된 로그인 정보입니다.");
			rAttr.addAttribute("result", "loginFailed");
		}
		return mav;
	}

	// 로그아웃 처리 메서드
	@Override
	@RequestMapping("/logout.do")
	public ModelAndView logout(RedirectAttributes rAttr,HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		ModelAndView mav = new ModelAndView();
		Boolean isLogin = (Boolean) session.getAttribute("isLogin");
		Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
		if(session != null && (isLogin != null || isAdmin != null)) {
			// 로그인 되어 있으면 세션 초기화
			session.invalidate();
			rAttr.addAttribute("result", "logout");
		} else {
			rAttr.addAttribute("result", "notLogin");
		}
		mav.setViewName("redirect:/member/loginForm.do");
		return mav;
	}

	// 회원 가입 페이지로 이동
	@Override
	@RequestMapping("/joinMember.do")
	public ModelAndView joinMember(HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		System.out.println("viewName"+viewName);
		return mav;
	}

	// 회원 가입 처리
	@RequestMapping(value = "/addMember.do", method = RequestMethod.POST)
	   public ModelAndView addMember(@ModelAttribute MemberDTO member, HttpServletRequest request, HttpServletResponse response) throws Exception {
	      int result = service.addMember(member);
	      int result1 = service.addCoupon(member);
	      System.out.println("Insert Result: " + result);
	      response.setContentType("text/html;charset=utf-8");
	      PrintWriter out = response.getWriter();

	      if (result == 1 && result1 == 1) {
	         int discount = member.getDiscount();
	         // 성공 시 알림 후 로그인 페이지로 이동
	         out.write("<script>");
	         out.write("alert('가입을 축하힙니다." + discount + "% 할인 쿠폰이 지급되었습니다!');");
	         out.write("location.href='/Urban_Village/member/loginForm.do';");
	         out.write("</script>");
	      } else {
	         // 실패 시 알림 후 다시 회원가입 폼으로
	         out.write("<script>");
	         out.write("alert('회원 가입에 실패했습니다. 다시 시도해주세요.');");
	         out.write("location.href='/Urban_Village/member/joinMember.do';");
	         out.write("</script>");
	      }
	      return null;
	   }
	@Override
	@RequestMapping("/myInfo.do")
	public ModelAndView myInfo(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<MemberDTO> memberList = service.getUserInfoById(id);
		ModelAndView mav = new ModelAndView();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if(id.contains("@")){
			out.write("<script>");
			out.write("alert('구글 로그인은 정보를 수정 할 수 없습니다.');");
			out.write("location.href='/Urban_Village/';");
			out.write("</script>");
			return null;
		}
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);
		mav.addObject("memberList", memberList);
		System.out.println(viewName);
		return mav;
	}

	@Override
	@RequestMapping("/updateUserInfo.do")
	public ModelAndView updateUserInfo(@ModelAttribute() MemberDTO member,
			@RequestParam("id") String id,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int result = service.updateUserInfo(member);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result == 1) {
			out.write("<script>");
			out.write("alert('수정성공!');");
			out.write("location.href='" + request.getContextPath() + "/member/loginForm.do';");
			out.write("</script>");
		} else {
			out.write("<script>");
			out.write("alert('수정실패');");
			out.write("location.href='" + request.getContextPath() + "/member/getUserInfo.do';");
			out.write("</script>");
		}

		return null;
	}

	// 아이디 중복 체크 (AJAX 사용 가능)
	@Override
	@RequestMapping("/checkId.do")
	public void checkId(HttpServletRequest request, HttpServletResponse response) {
		String userId = request.getParameter("id");
		boolean exists = service.checkIfUserIdExists(userId);

		response.setContentType("application/json");
		try (PrintWriter out = response.getWriter()) {
			out.print("{\"exists\": " + exists + "}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/deleteMemberForm.do")
    public ModelAndView deleteMemberForm(HttpServletRequest request, HttpServletResponse response) {
       String viewName = (String) request.getAttribute("viewName");
       ModelAndView mav = new ModelAndView(viewName);
       return mav;
    }

    // 회원 탈퇴 처리
	@Override
    @RequestMapping(value = "/deleteMember.do", method = RequestMethod.POST)
    public void deleteMember(@RequestParam("id") String id, @RequestParam("pwd") String pwd, HttpServletRequest request, HttpServletResponse response) throws IOException {
       response.setContentType("text/html;charset=utf-8");
       PrintWriter out = response.getWriter();
       HttpSession session = request.getSession(false);

       if (session == null || session.getAttribute("loginId") == null) {
          out.println("<script>");
          out.println("alert('로그인 정보가 없습니다.');");
          out.println("location.href='" + request.getContextPath() + "/member/loginForm.do';");
          out.println("</script>");
          return;
       }

       String loggedInId = (String) session.getAttribute("loginId");
       
       

       if (!loggedInId.equals(id)) {
          out.println("<script>");
          out.println("alert('잘못된 접근입니다.');");
          out.println("location.href='" + request.getContextPath() + "/member/myInfo.do?id=" + loggedInId + "';");
          out.println("</script>");
          return;
       }

       MemberDTO member = service.login(id, pwd);

       if (member != null) {
          int result = service.deleteMember(id);
          service.delCoupon(id);
          reService.delReview(id);
          if (result > 0) {
             session.invalidate(); // 회원 탈퇴 성공 시 세션 무효화
             out.println("<script>");
             out.println("alert('회원 탈퇴가 완료되었습니다.');");
             out.println("location.href='" + request.getContextPath() + "/';"); // 메인 페이지로 이동
             out.println("</script>");
          } else {
             out.println("<script>");
             out.println("alert('회원 탈퇴 처리 중 오류가 발생했습니다.');");
             out.println("history.back();"); // 이전 페이지로 이동
             out.println("</script>");
          }
       } else {
          out.println("<script>");
          out.println("alert('아이디 또는 비밀번호가 일치하지 않습니다. 다시 확인해주세요.');");
          out.println("history.back();"); // 이전 페이지로 이동
          out.println("</script>");
       }
    }
	
	// 매출
    @Override
     @RequestMapping("/salesForm.do")
     public ModelAndView salesForm(HttpServletRequest request, HttpServletResponse response) {
         ModelAndView mav = new ModelAndView("/member/salesForm.do"); // Tiles 정의 이름 사용
         return mav;
     }

    @Override
    @RequestMapping("/getDailySales.do")
    public ModelAndView getDailySales(HttpServletRequest request, HttpServletResponse response) {
        List<PayDTO> dailySalesList = service.getDailySales();
        System.out.println("일별 매출 데이터 (컨트롤러): " + dailySalesList); // 추가
        ModelAndView mav = new ModelAndView("/member/salesForm.do");
        mav.addObject("dailySalesList", dailySalesList);
        mav.addObject("selectedTab", "daily");
        return mav;
    }
    
    

    @Override
    @RequestMapping("/getMonthlySales.do")
    public ModelAndView getMonthlySales(HttpServletRequest request, HttpServletResponse response) {
        List<PayDTO> monthlySalesList = service.getMonthlySales();
        ModelAndView mav = new ModelAndView("/member/salesForm.do");
        mav.addObject("monthlySalesList", monthlySalesList);
        mav.addObject("selectedTab", "monthly");
        return mav;
    }

    @Override
    @RequestMapping("/getYearlySales.do")
    public ModelAndView getYearlySales(HttpServletRequest request, HttpServletResponse response) {
        List<PayDTO> yearlySalesList = service.getYearlySales();
        ModelAndView mav = new ModelAndView("/member/salesForm.do");
        mav.addObject("yearlySalesList", yearlySalesList);
        mav.addObject("selectedTab", "yearly");
        return mav;
    }
    
    @RequestMapping("/findPwd.do")
	public ModelAndView findPwd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);
		return mav;
	}

	@RequestMapping("/findPwdForId.do")
	public int findPwdForId(@RequestParam("member_id") String member_id, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int result = service.findPwdForId(member_id);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result > 0) {
			out.println("<script>");
			out.println("alert('아이디가 확인되었습니다. 가입된 메일로 인증번호를 전송합니다');");
			out.println("location.href='" + request.getContextPath() + "/email/sendMemberPwd.do?member_id=" + member_id
					+ "';");// 이메일 찾기로 이동함
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('아이디가 존재하지 않습니다. 회원가입을 해주세요');");
			out.println("location.href='" + request.getContextPath() + "/member/joinMember.do';"); // 아이디 찾기로 이동함
			out.println("</script>");
		}

		return 0;
	}

	@RequestMapping("/checkCode.do")
	public String checkCode(Model model, @RequestParam("code") int code, @RequestParam("member_id") String member_id, 
	                         HttpServletRequest request, HttpServletResponse response) throws IOException {
	    // Get the session from the request
	    HttpSession session = request.getSession(false); // false means don't create a new session if one doesn't exist
	    
	    if (session == null) {
	        model.addAttribute("member_id", member_id);
	        model.addAttribute("codeError", "세션이 만료되었습니다. 다시 시도해주세요.");
	        return "/member/codeCheckPwd";
	    }
	    
	    Integer pwdCodeObj = (Integer) session.getAttribute("pwdCode");
	    if (pwdCodeObj == null) {
	        model.addAttribute("member_id", member_id);
	        model.addAttribute("codeError", "인증 코드가 만료되었습니다. 다시 시도해주세요.");
	        return "/member/codeCheckPwd";
	    }
	    
	    int pwdCode = pwdCodeObj.intValue();
	    System.out.println(pwdCode);
	    
	    if (code == pwdCode) {
	        model.addAttribute("codeSuccess", true);
	        model.addAttribute("member_id", member_id);
	        return "/member/codeCheckPwd"; // redirect 안 함
	    } else {
	        model.addAttribute("member_id", member_id);
	        model.addAttribute("codeError", "코드가 잘못되었습니다. 다시 입력해주세요.");
	        return "/member/codeCheckPwd";
	    }
	}

	@Override
	@RequestMapping("/resetPwd.do")
	public ModelAndView resetPwd(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) {
		List<MemberDTO> memberList = service.getUserInfoById(id);
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);
		mav.addObject("memberList", memberList);
		System.out.println(viewName);
		return mav;
	}

	@RequestMapping("/modPwdMember.do")
	public ModelAndView modPwdMember(@ModelAttribute() MemberDTO member, @RequestParam("id") String id,
			@RequestParam("newPwd") String newPwd, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		member.setPwd(newPwd);
		int result = service.modPwdMember(member);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result == 1) {
			out.write("<script>");
			out.write("alert('수정성공. 로그인페이지로 이동합니다.');");
			out.write("location.href='" + request.getContextPath() + "/member/loginForm.do';");
			out.write("</script>");
		} else {
			out.write("<script>");
			out.write("alert('수정실패. 다시 비밀번호를 설정해 주세요.');");
			out.write("location.href='" + request.getContextPath() + "/member/resetPwd.do';");
			out.write("</script>");
		}

		return null;
	}
	@Override
	   @RequestMapping("/myCoupon.do")
	   public ModelAndView myCoupon(HttpServletRequest request, HttpServletResponse response) {
	      ModelAndView mav = new ModelAndView();
	      String loginId = (String) session.getAttribute("loginId");
	      List<MemberDTO> couponList = service.getCouponsByMemberId(loginId);
	      List<MemberDTO> coupon = service.getMyCoupon(loginId);
	      mav.addObject("couponList", couponList); //사용가능한쿠폰
	      mav.addObject("coupon", coupon);      //사용한 쿠폰
	      mav.setViewName("/member/couponList");
	      return mav;
	   }
    
}
