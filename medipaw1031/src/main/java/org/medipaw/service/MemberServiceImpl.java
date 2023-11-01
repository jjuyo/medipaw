package org.medipaw.service;

import java.util.List;
import java.util.Random;

import org.medipaw.domain.AuthVO;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.MemberVO;
import org.medipaw.mapper.MemberMapper;
import org.medipaw.member.PasswordChangeRequest;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mMapper;
    private final BCryptPasswordEncoder encoder;
    
    // 회원 가입
	public UserDetails loadUserByUsername(String username) {
		return null;
	}
 
    //전체회원
    public List<MemberVO> list(Criteria cri) {
		return mMapper.selectAllPaging(cri);
	}
    
	public int totalCount(Criteria cri) {
		return mMapper.totalCount(cri);
	}
	
	 @Override
	   public boolean resetPassword(String id, String newPassword){
	      // 비밀번호 암호화 로직이 필요한 경우 여기에 추가합니다.
	      newPassword = encoder.encode(newPassword);
	      
	      return mMapper.updatePassword(id,newPassword)==1;
	   }
	
	
	public void join(MemberVO memberVO) throws DuplicateKeyException{
		memberVO.setPasswd(encoder.encode(memberVO.getPasswd()));
		
		if(mMapper.select(memberVO.getId()) != null) {
			throw new DuplicateKeyException("DuplicateKey Exception!!");
		}
		int cnt = mMapper.saveUser(memberVO);
		if(cnt > 0) {
			AuthVO authVO = new AuthVO();
			authVO.setId(memberVO.getId());
			authVO.setAuth(memberVO.getRole().toString());
			
			mMapper.saveRole(authVO);
		}
	}

	@Override
	public boolean findById(String id) {
		return  mMapper.findById(id)==1;
	}

	@Override
	public String findIdByFullNameAndPhone(String name, String phone) {
        // 이름과 전화번호로 아이디 조회 후 반환
        return mMapper.findIdByFullNameAndPhone(name, phone);
    }
	
	@Override
	public boolean checkUserExists(String id, String email) {
		return mMapper.findByUsernameAndEmail(id, email) == 1;
	}

	   @Override
	    public MemberVO getMemberByUsername(String userId) {
	        return mMapper.findByUsername(userId);
	    }
	   
	   @Override
		public boolean updateUser(MemberVO mvo) {
		   log.info("update");
			return mMapper.updateUser(mvo) == 1;
		}
	
	   @Override 
	   public boolean updatePassword(PasswordChangeRequest passwordChangeRequest) { 
	       String id = SecurityContextHolder.getContext().getAuthentication().getName();
	       MemberVO mvo = mMapper.findByUsername(id); 

	       if (encoder.matches(passwordChangeRequest.getCurrentPassword(), mvo.getPasswd())) { // 현재 비밀번호 일치 확인 
	           String encodedNewPassword = encoder.encode(passwordChangeRequest.getNewPassword()); // 새 비밀번호 암호화 
	           int updateCount = mMapper.updatePassword(id, encodedNewPassword); // DB 업데이트 

	           if(updateCount > 0) {
	               return true;
	           } else {
	               return false;
	           }
	       } else {  
	          return false;   
	      }   
}
	   
	   @Override
	    public boolean deleteMember(String id) {
	        int result = mMapper.deleteMember(id);

	        // Return true if one row was deleted, false otherwise.
	        return result == 1;
	   }
	   
	   public String generateTempPassword() {
		    int length = 10;
		    String charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*";
		    Random rand = new Random();
		    StringBuilder retVal = new StringBuilder();

		    for (int i = 0; i < length; i++) {
		        retVal.append(charset.charAt(rand.nextInt(charset.length())));
		    }

		    return retVal.toString();
		}
}

