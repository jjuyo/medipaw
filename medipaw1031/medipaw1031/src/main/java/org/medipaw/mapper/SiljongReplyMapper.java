package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.SiljongReplyVO;

public interface SiljongReplyMapper {
	public int insert(SiljongReplyVO sjrvo);
	public SiljongReplyVO select(int sjrno);
	public int update(SiljongReplyVO sjrvo);
	public int delete(int sjrno);
	public List<SiljongReplyVO> selectAllPaging(@Param("sjno") int sjno, @Param("cri") Criteria cri);
	public int countReply(int sjno);
}
