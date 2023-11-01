package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.TreatVO;

public interface TreatService {
	public TreatVO view(int tno);
	public boolean register(TreatVO tvo);	
	public boolean remove(int tno);
	public boolean modify(TreatVO tvo);
	public List<TreatVO> listPagingAdm(Criteria cri);
	public List<TreatVO> listPagingUser(String id, Criteria cri);
	public List<TreatVO> listPagingStaff(String sid, Criteria cri);
	public int totalCountAdm(Criteria cri);
	public int totalCountUser(String id, Criteria cri);
	public int totalCountStaff(String sid, Criteria cri);
	public int treatCnt(int rvno);
	public boolean updateDelCheck(TreatVO tvo);	// 회원의 진료 내역 삭제 여부
}
