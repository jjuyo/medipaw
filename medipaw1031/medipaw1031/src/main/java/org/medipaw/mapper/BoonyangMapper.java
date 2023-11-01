package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.BoonyangVO;
import org.medipaw.domain.Criteria;

public interface BoonyangMapper {
	public List<BoonyangVO> selectAllPaging(Criteria cri);
	public int totalCount(Criteria cri);
	public int mytotalCount(@Param("id")String id, @Param("cri")Criteria cri);
	
	public List<BoonyangVO> selectMyList(@Param("id")String id, @Param("cri")Criteria cri);
	public BoonyangVO select(int byno);
	public int insert(BoonyangVO bvo);
	public int delete(int byno);
	public int update(BoonyangVO bvo);
	public int updateReplyCnt(@Param("byno") int byno, @Param("increment") int increment );
	
}
