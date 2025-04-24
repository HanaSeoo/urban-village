package com.test.Urban_Village.email.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;

@Service
@EnableAsync
public class MailService {
	@Autowired
	private JavaMailSender mailSender;

	@Async
	public void sendMail(String to, String title, String context) {
		// TODO Auto-generated method stub
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"utf-8");
			messageHelper.setCc("Urban_Village@gmail.com");
			messageHelper.setFrom("admiin@test.com", "관리자");
			messageHelper.setSubject(title);
			messageHelper.setTo(to);
			messageHelper.setText(context, true);
			mailSender.send(message);
	
					
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

}
