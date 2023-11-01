package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.medipaw.domain.AuthVO;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.MemberVO;

public interface MemberMapper {
	public List<MemberVO> selectAllPaging(Criteria cri);
	public int totalCount(Criteria cri);

	
	public MemberVO select(String id);
	
	public int saveUser(MemberVO memberVO);
	
	public int saveRole(AuthVO authVO);

	@Select("SELECT COUNT(*) FROM (SELECT id FROM member WHERE id = #{id} UNION SELECT sid FROM staff WHERE sid = #{id})")
	public int findById(String id);
	
    String findIdByFullNameAndPhone(@Param("name") String name, @Param("phone") String phone);
    
	public int findByUsernameAndEmail(@Param("id") String id, @Param("email") String email);

	public int updatePassword(@Param("id") String id, @Param("newPassword") String newPassword);

	MemberVO findByUsername(@Param("userId") String userId);

	public int updateUser(MemberVO mvo);
	
	public int deleteMember(String id);


}
