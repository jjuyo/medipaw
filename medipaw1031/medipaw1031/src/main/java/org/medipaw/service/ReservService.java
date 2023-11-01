package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReservVO;

public interface ReservService {
	public ReservVO view(int rvno);
	public boolean register(ReservVO rvvo);	
	public boolean remove(int rvno);
	public boolean modify(ReservVO rvvo);
	public List<ReservVO> listPagingAdm(Criteria cri);
	public List<ReservVO> listPagingUser(String id, Criteria cri);
	public List<ReservVO> listPagingStaff(String sid, Criteria cri);
	public int totalCountAdm(Criteria cri);
	public int totalCountUser(String id, Criteria cri);
	public int totalCountStaff(String sid, Criteria cri);
	public List<String> duplRvTime(String rvDate, int hno);
}
