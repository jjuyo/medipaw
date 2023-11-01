package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.MarkVO;

public interface MarkMapper {
	public List<MarkVO> selectMno(@Param("id") String id, @Param("cri") Criteria cri);
	public List<MarkVO> selectHos(@Param("id") String id, @Param("cri") Criteria cri);
	public int insert(MarkVO mvo);			
	public int delete(int mno);
	public int totalCount(@Param("id") String id, @Param("cri") Criteria cri);
	
	// 리스트 정렬 시 쿼리문을 하나로 쓸 시 동적쿼리 사용해서 BoardMapper에서 했던 것처럼
	// 쿼리문을 2개로 나누면 최신순은 괜찮은데 병원 가나다순으로 정렬 시 병원 이름은 pk가 아니기 때문에 index를 사용
	// order by 사용할 수 있지만 느려서 성능이 떨어짐!
	// 근데 파라미터에 mno 들어가야되는지는 모르게써ㅠ
	
	// SELECT * FROM table WHERE id = #{id} AND ORDER BY mno DESC;
}
