package org.medipaw.security;

import org.medipaw.domain.MemberVO;
import org.medipaw.domain.StaffVO;
import org.medipaw.mapper.MemberMapper;
import org.medipaw.mapper.StaffMapper;
import org.medipaw.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
public class CustomUserDetailsService implements UserDetailsService {
@Setter(onMethod_=@Autowired)
private StaffMapper staffMapper;
@Setter(onMethod_= @Autowired)
private MemberMapper mMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("loadUserByUsername(): "+username);
		
		MemberVO mvo = mMapper.select(username);	
		StaffVO svo = staffMapper.login(username);
		 if (mvo != null) {
		        return new CustomUser(mvo);
		    } else if (svo != null) {
		        return new CustomUser(svo);
		    } else {
		       return null;
		    }
	}
}
