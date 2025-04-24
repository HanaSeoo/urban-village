package com.test.Urban_Village.email.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.Urban_Village.email.service.MailService;
import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.service.MemberService;

@Controller
@RequestMapping("/email")
public class MailController {
	@Autowired
	MailService service;
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/sendMemberPwd.do")
	public String sendSimpleMail(Model model, @RequestParam("member_id")String member_id,@ModelAttribute("MemberDTO")MemberDTO memberDTO,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String email = memberService.findEmailById(member_id);
		System.out.println(email);
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Random random = new Random();
        int number = 1000 + random.nextInt(9000);
        HttpSession session = request.getSession(true);
        session.setAttribute("pwdCode", number);
        String msg = "<html><body style=\"font-family: sans-serif;\">";
        msg += "<div style=\"background-color: #f7f7f7; padding: 20px; display: flex; justify-content: center;\">";
        msg += "<div style=\"background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); padding: 30px; text-align: center; width: 90%; max-width: 400px;\">";
        msg += "<h1 style=\"color: #1a73e8; margin-bottom: 20px;\">Urban_Village 비밀번호 찾기</h1>";
        msg += "<div style=\"background-color: #f2f2f2; border-radius: 6px; padding: 20px; margin-bottom: 20px;\">";
        msg += "<span style=\"font-size: 2em; font-weight: bold; color: #333; letter-spacing: 8px;\">" + number + "</span>";
        msg += "</div>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">귀하의 이메일 주소로 비밀번호 변경 요청이 있었습니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">Urban_Village 인증 코드는 위와 같습니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">만약 이 코드를 요청하지 않으셨다면 다른 사람이 귀하의 계정에 접근하려 시도하는 것일 수 있습니다. 누구에게도 이 코드를 전달하거나 제공하면 안 됩니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 20px;\">감사합니다.<br>Urban_Village 팀</p>";
        msg += "</div>";
        msg += "</div>";
        msg += "</body></html>";

        service.sendMail(email, "Urban_Village 비밀번호 찾기 인증 코드", msg);
        model.addAttribute("member_id", member_id);
		return "/member/codeCheckPwd";
        
    }
	@RequestMapping("/sendJoinCode.do")
	public void sendJoinCode(Model model, @RequestParam("email")String email,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println(email);
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Random random = new Random();
        int number = 1000 + random.nextInt(9000);
        HttpSession session = request.getSession();
        session.setAttribute("joinCode", number);
        String msg = "<html><body style=\"font-family: sans-serif;\">";
        msg += "<div style=\"background-color: #f7f7f7; padding: 20px; display: flex; justify-content: center;\">";
        msg += "<div style=\"background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); padding: 30px; text-align: center; width: 90%; max-width: 400px;\">";
        msg += "<h1 style=\"color: #1a73e8; margin-bottom: 20px;\">Urban_Village 회원가입 인증</h1>";
        msg += "<div style=\"background-color: #f2f2f2; border-radius: 6px; padding: 20px; margin-bottom: 20px;\">";
        msg += "<span style=\"font-size: 2em; font-weight: bold; color: #333; letter-spacing: 8px;\">" + number + "</span>";
        msg += "</div>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">귀하의 이메일 주소로 회원가입 요청이 있었습니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">Urban_Village 인증 코드는 위와 같습니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 15px;\">만약 이 코드를 요청하지 않으셨다면 다른 사람이 귀하의 계정에 접근하려 시도하는 것일 수 있습니다. 누구에게도 이 코드를 전달하거나 제공하면 안 됩니다.</p>";
        msg += "<p style=\"color: #555; line-height: 1.6; margin-bottom: 20px;\">감사합니다.<br>Urban_Village 팀</p>";
        msg += "</div>";
        msg += "</div>";
        msg += "</body></html>";


        try {
            service.sendMail(email, "Urban_Village 가입인증번호", msg);
            out.print("success"); // 성공 시 "success" 전송
        } catch (Exception e) {
            e.printStackTrace();
            out.print("fail");    // 실패 시 "fail" 전송
        } finally {
            out.close();
        }
    }
	
	@RequestMapping("/checkJoinCode.do")
	@ResponseBody
	public boolean checkJoinCode(@RequestParam("inputCode") String inputCode, HttpSession session) {
	    Object savedCode = session.getAttribute("joinCode");
	    return savedCode != null && savedCode.toString().equals(inputCode);
	}
}




