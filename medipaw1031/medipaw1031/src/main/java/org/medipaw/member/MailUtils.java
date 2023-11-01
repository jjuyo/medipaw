package org.medipaw.member;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailUtils {
	private JavaMailSender mailSender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;
	
	// 자동 생성자
    public MailUtils(JavaMailSender mailSender) throws MessagingException {	
        this.mailSender = mailSender;
        message = this.mailSender.createMimeMessage();
        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    }

    public void setSubject(String subject) throws MessagingException {
        messageHelper.setSubject(subject);	// 메일 제목
    }

    public void setText(String htmlContent) throws MessagingException {
        messageHelper.setText(htmlContent, true);	// 메일 내용
    }

    public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
        messageHelper.setFrom(email, name);		// 보내는 사람
    }

    public void setTo(String email) throws MessagingException {
        messageHelper.setTo(email);		// 받을 사람
    }

    public void addInline(String contentId, DataSource dataSource) throws MessagingException {	// addInline(삽입될 이미지의 id 애트리뷰트명, 파일의 경로)
        messageHelper.addInline(contentId, dataSource);		// 이미지 삽입
    }

    public void send() {
        mailSender.send(message);		// 메일 전송
    }
}
