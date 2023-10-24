package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.MemberVO;
import org.medipaw.member.PasswordChangeRequest;
import org.springframework.security.core.userdetails.UserDetails;

public interface MemberService {
    
    UserDetails loadUserByUsername(String username);
    
    public List<MemberVO> list(Criteria cri);
	public int totalCount(Criteria cri);

	void join(MemberVO mvo);

	boolean findById(String id);
	
	String findIdByFullNameAndPhone(String name, String phone);
   
	boolean checkUserExists(String id, String email);

	boolean resetPassword(String id, String newPassword);

	MemberVO getMemberByUsername(String userId);
	
    boolean updateUser(MemberVO mvo);

    boolean updatePassword(PasswordChangeRequest passwordChangeRequest);

    boolean deleteMember(String id);
    
    public String generateTempPassword();
    


	
}