package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReplyVO;

public interface ReplyMapper {
	public int selectReply(int byno);
	public List<ReplyVO> selectAllPaging(@Param("byno") int byno, @Param("cri") Criteria cri);
	public int insert(ReplyVO rvo);
	public ReplyVO select(int byRno);
	public int delete(int byRno);
	public int update(ReplyVO rvo);

}
