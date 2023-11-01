package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.BoonyangVO;
import org.medipaw.domain.BraggingBoardVO;
import org.medipaw.domain.BraggingCriteria;
import org.medipaw.domain.Criteria;


public interface BraggingBoardMapper {
	public void updateRecommendCnt(@Param("amount") int amount, @Param("bno") int bno);
	public List<BraggingBoardVO> selectAllPaging(BraggingCriteria bcri);
	public int myTotalCount(@Param("id")String id, @Param("bcri")BraggingCriteria bcri);
	public List<BraggingBoardVO> mySelectAllPaging(@Param("id")String id, @Param("bcri")BraggingCriteria bcri);
	public int totalCount(BraggingCriteria bcri);
	public void insertRecommend(@Param("bbvo") BraggingBoardVO bbvo);
	public void increaseRecommendCount(@Param("bno") int bno); // 게시판 추천 수 
	public int countRecommend(@Param("bno") int bno, @Param("id") String id); //중복체크
	public void increaseHit(int bno);
	public int update(BraggingBoardVO bbvo);
	public int delete(int bno);
	public int insertSelectKey(BraggingBoardVO bbvo);
	public void insert(BraggingBoardVO bbvo);
	public BraggingBoardVO select(int bno);
	public List<BraggingBoardVO> selectAll();
}
