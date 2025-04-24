package com.test.Urban_Village.apiLogin;

import java.sql.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.service.MemberService;

@Controller
public class GoogleLoginController {
	@Autowired
	MemberService memberService;

	@RequestMapping(value = "/oauth2callback", method = RequestMethod.GET)
    public String googleCallback(@RequestParam("code") String code, Model model) throws Exception {
        // 토큰 요청
    	JacksonFactory jacksonFactory = new JacksonFactory();  // 직접 생성

        GoogleTokenResponse tokenResponse =
        		new GoogleAuthorizationCodeTokenRequest(
        			    new NetHttpTransport(),
        			    jacksonFactory,
                "https://oauth2.googleapis.com/token",
                "69381954362-11abld4f76jr615qrjqpqoa1ffjok517.apps.googleusercontent.com",
                "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",
                code,
                "http://localhost:8080/Urban_Village/oauth2callback"
            ).execute();

        // 사용자 정보 가져오기
        GoogleIdToken idToken = tokenResponse.parseIdToken();
        GoogleIdToken.Payload payload = idToken.getPayload();

        String email = payload.getEmail();
        String name = (String) payload.get("name");
        MemberDTO member = memberService.selectByEmail(email);
        
        if (member == null) {
            // 2. 없으면 회원가입 (기본값으로 가입)
            member = new MemberDTO();
            member.setId(email);
            member.setEmail(email);
            member.setName(name);
            member.setPwd("GOOGLE"); // 구글은 비밀번호 없이, 임시값
            member.setJoin_type("GOOGLE");

            // 필수 값은 기본값 사용: birth, gender, phonenumber
            member.setBirth(Date.valueOf("1900-01-01"));  // 기본값
            member.setGender("M");  // 기본값 (남성)
            member.setPhonenumber("000-0000-0000");  // 기본값

            memberService.insertGoogleUser(member); // DAO 통해 DB 저장
        }

        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        session.setAttribute("member", member); // DTO 전체
        session.setAttribute("loginId", member.getId());
        session.setAttribute("isLogin", true);
        session.setAttribute("memberName", member.getName());
        session.setAttribute("memberEmail", member.getEmail());
        session.setAttribute("memberGender", member.getGender());
        session.setAttribute("memberBirth", member.getBirth());
        session.setAttribute("memberPhone", member.getPhonenumber());



        return "redirect:/main";
    }
}
