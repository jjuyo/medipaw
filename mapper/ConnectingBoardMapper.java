package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.ConnectingBoardVO;
import org.medipaw.domain.ConnectingCriteria;

public interface ConnectingBoardMapper {
	public void updateRecommendCnt(@Param("amount") int amount, @Param("cno") int cno);
	public List<ConnectingBoardVO> selectAllPaging(ConnectingCriteria ccri);
	public int myTotalCount(@Param("id")String id, @Param("ccri")ConnectingCriteria ccri);
	public List<ConnectingBoardVO> mySelectAllPaging(@Param("id")String id, @Param("ccri")ConnectingCriteria ccri);
	public int totalCount(ConnectingCriteria ccri);
	public void insertRecommend(@Param("cbvo") ConnectingBoardVO cbvo);
	public void increaseRecommendCount(@Param("cno") int cno); // 게시판 추천 수 
	public int countRecommend(@Param("cno") int cno, @Param("id") String id); //중복체크
	public void increaseHit(int cno);
	public int update(ConnectingBoardVO cbvo);
	public int delete(int cno);
	public int insertSelectKey(ConnectingBoardVO cbvo);
	public void insert(ConnectingBoardVO cbvo);
	public ConnectingBoardVO select(int cno);
	public List<ConnectingBoardVO> selectAll();
}