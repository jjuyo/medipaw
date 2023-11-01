package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReservVO;
import org.medipaw.domain.SiljongVO;
import org.medipaw.domain.TreatVO;

public interface TreatMapper {
	public List<TreatVO> selectAllPagingUser(@Param("id") String id, @Param("cri") Criteria cri);
	public List<TreatVO> selectAllPagingStaff(@Param("sid") String sid, @Param("cri") Criteria cri);
	public List<TreatVO> selectAllPagingAdm(Criteria cri);
	public TreatVO select(int tno);
	public int insert(TreatVO tvo);			
	public int delete(int tno);
	public int update(TreatVO tvo);
	public int updateDelCheck(TreatVO tvo);	// 회원의 진료 내역 삭제 여부
	public int totalCountAdm(Criteria cri);
	public int totalCountUser(@Param("id") String id, @Param("cri") Criteria cri);
	public int totalCountStaff(@Param("sid") String sid, @Param("cri") Criteria cri);
	public int treatCnt(int rvno);			// 예약 정보 당 진료 내역 개수
}
