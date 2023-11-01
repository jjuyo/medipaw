package org.medipaw.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.medipaw.domain.MemberVO;
import org.medipaw.domain.StaffVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	private StaffVO svo;
	private MemberVO mvo;
	
	public CustomUser(StaffVO svo) {
		super(svo.getSid(), svo.getSpw(), 
				svo.getAuthList().stream()
				.map(avo -> new SimpleGrantedAuthority(avo.getAuth()))
				.collect(Collectors.toList())
				);
		this.svo = svo;
	}
	public CustomUser(MemberVO mvo) {
		super(mvo.getId(), mvo.getPasswd(), mvo.getAuthList().stream().map(avo -> new SimpleGrantedAuthority(avo.getAuth())).collect(Collectors.toList()));
		this.mvo = mvo;
	}
		
	public CustomUser(String username, String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);

	}



}
