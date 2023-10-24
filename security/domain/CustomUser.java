package org.medipaw.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.medipaw.domain.MemberVO;

import lombok.Getter;
//superclass 넣음
//AuthVO를 갖고있는 MemberVO를 UserDetails로 형변환 시키려면 User 부모 클래스를 상속받는 CustomUser 클래스를 사용해야 함
@Getter //다 필요하면 data , getter만 필요해
public class CustomUser extends User {
		public CustomUser(
				org.medipaw.domain.MemberVO mvo) {
			super(mvo.getId(), mvo.getPasswd(), mvo.getAuthList().stream().map(avo -> new SimpleGrantedAuthority(avo.getAuth())).collect(Collectors.toList()));
			this.mvo = mvo;
		}
		private MemberVO mvo;
		public CustomUser(String username, String password, 
	            Collection<? extends GrantedAuthority> authorities) {
				super(username, password, authorities);
	}
}

//UserDetails를 구현하는 User 클래스를 상속받은 CustomUser 클래스를
