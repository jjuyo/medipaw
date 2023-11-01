package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReservVO;

public interface ReservMapper {
	public List<ReservVO> selectAllPagingUser(@Param("id") String id, @Param("cri") Criteria cri);
	public List<ReservVO> selectAllPagingStaff(@Param("sid") String sid, @Param("cri") Criteria cri);
	public List<ReservVO> selectAllPagingAdm(Criteria cri);
	public ReservVO select(int rvno);
	public int insert(ReservVO rvvo);			
	public int delete(int rvno);
	public int update(ReservVO rvvo);
	public int totalCountAdm(Criteria cri);
	public int totalCountUser(@Param("id") String id, @Param("cri") Criteria cri);
	public int totalCountStaff(@Param("sid") String sid, @Param("cri") Criteria cri);
	public List<String> duplRvTime(@Param("rvDate") String rvDate, @Param("hno") int hno);
}
