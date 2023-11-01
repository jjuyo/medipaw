package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReviewVO;

public interface ReviewMapper {
	public List<ReviewVO> selectAll(@Param("animalhosp_no") int animalhosp_no, @Param("cri") Criteria cri);
	public int totalCount(@Param("animalhosp_no") int animalhosp_no, @Param("cri") Criteria cri);
	public int mytotalCount(@Param("id")String id, @Param("cri")Criteria cri);
	public int tnoCheck(int tno);//진료내역에서 리뷰 중복확인
	
	public List<ReviewVO> selectMy(@Param("id") String id, @Param("cri") Criteria cri);
	public ReviewVO select(int rno);
	public int insert(ReviewVO rvo);
	public int delete(int rno);
	public int update(ReviewVO rvo);

}
