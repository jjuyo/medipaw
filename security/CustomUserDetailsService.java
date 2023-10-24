package org.medipaw.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.medipaw.domain.MemberVO;
import org.medipaw.mapper.MemberMapper;
import org.medipaw.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_= @Autowired)
	private MemberMapper mMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//username => 사용자가 입력한 아이디
		log.warn("loadUserByUsername() : " + username);
		MemberVO mvo = mMapper.select(username);
		return mvo == null? null : new CustomUser(mvo);
	}

	
}
