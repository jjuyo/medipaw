package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.StaffVO;

public interface StaffMapper {
	//관리자- 병원관계자 목록
	public List<StaffVO> selectAllPaging(Criteria cri);
	public int totalCount(Criteria cri);
	
	public StaffVO login(String sid); //로그인 시 CustomUserDetailsService에서 사용 
	public StaffVO select(String sid); 			  // view는 StaffService에서 사용	
	public String findId(@Param("sname") String sname, @Param("sphone") String sphone);
	public int findPw(@Param("sid") String sid, @Param("sname") String sname, @Param("sphone") String sphone);
	public int changePw(String spw); //비밀번호 찾기 -> 비밀번호 재설정
	public int idCheck(String sid);//아이디 중복확인
	public int insert(StaffVO svo); // 가입
	public int delete(String sid);
	public int update(StaffVO svo);
	public int updatePw(@Param("sid") String sid, @Param("spw") String spw); // 계정 정보 수정 -> 비밀번호 변경
}
