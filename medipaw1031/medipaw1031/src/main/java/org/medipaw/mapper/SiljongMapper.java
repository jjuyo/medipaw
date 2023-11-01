package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.SiljongVO;

public interface SiljongMapper {
	public List<SiljongVO> selectAllPaging(Criteria cri);
	public List<SiljongVO> selectMine(@Param("id") String id, @Param("cri") Criteria cri);
	public SiljongVO select(int sjno);
	public int insert(SiljongVO sjvo);			
	public int delete(int sjno);
	public int update(SiljongVO sjvo);
	public int totalCount(Criteria cri);
	public int totalCountMine(@Param("id") String id, @Param("cri") Criteria cri);
	public void updateReplyCnt(@Param("sjno") int sjno, @Param("incdec") int incdec);		// 댓글 수 업데이트
	public void updateHit(int sjno);
}
