package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.StaffVO;


public interface StaffService {
		// 관리자 - 병원관계자 목록
	   public List<StaffVO> pageList(Criteria cri);
	   public int totalCount(Criteria cri);
	   // 병원관계자 일반
	   public String findId(String sname, String sphone);
	   public int findPw(String sid, String sname, String sphone);
	   public boolean changePw(String spw); //비밀번호 찾기 -> 비밀번호 재설정
	   public boolean idCheck(String sid);
	   public boolean register(StaffVO svo);
	  
	   // 병원관계자 정보
	   public StaffVO view(String sid);
	   public boolean remove(String sid);
	   public boolean modify(StaffVO svo);
	   public boolean modifyPw(String sid, String spw); // 계정 정보 수정 -> 비밀번호 변경
   
   
}