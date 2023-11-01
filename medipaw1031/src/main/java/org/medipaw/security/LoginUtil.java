package org.medipaw.security;

import org.medipaw.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

public class LoginUtil {

    private MemberVO member; // MemberVO 객체를 멤버 변수로 추가

    // 생성자에서 MemberVO 객체 초기화
    public LoginUtil(MemberVO member) {
        this.member = member;
    }

    // isManager() 메소드: 관리자 여부
    public boolean isManager() {
        return false;
    }

    // isUser() 메소드: 일반 사용자 여부
    public boolean isUser() {
        return false;
    }

   // getUser() 메소드: 현재 로그인한 사용자의 정보(MemberVO 객체)를 반환
   public MemberVO getUser() {
       return this.member;  // 멤버 변수인 member 반환
   }

   public UserDetails loadUserByUsername(String id) {
       // TODO: 실제 로직을 구현해야 합니다.
       return null; 
   }
   
   public boolean join(String id, String pw) {
       // TODO: 실제 로직을 구현해야 합니다.
       return false; 
   }
   
   public Collection<? extends GrantedAuthority> getAuthorities() { 
       // TODO: 실제 로직을 구현해야 합니다.
       return null; 
   }
}