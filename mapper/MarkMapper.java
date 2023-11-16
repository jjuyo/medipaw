package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.MarkVO;

public interface MarkMapper {
	public List<MarkVO> selectMno(@Param("id") String id, @Param("cri") Criteria cri);
	public List<MarkVO> selectHos(@Param("id") String id, @Param("cri") Criteria cri);
	public int insert(MarkVO mvo);			
	public int delete(MarkVO mvo);
	public int totalCount(@Param("id") String id, @Param("cri") Criteria cri);
	public int select(@Param("id") String id, @Param("animalhosp_no") int animalhosp_no);
	
	// SELECT * FROM table WHERE id = #{id} AND ORDER BY mno DESC;
}
