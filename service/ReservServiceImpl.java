package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReservVO;
import org.medipaw.mapper.ReservMapper;
import org.medipaw.mapper.SiljongMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReservServiceImpl implements ReservService {
	@Setter(onMethod_ = @Autowired)		
	private ReservMapper rvMapper;
	
	@Override
	public ReservVO view(int rvno) {
		log.info("예약 상세조회...");
		return rvMapper.select(rvno);
	}

	@Override
	public boolean register(ReservVO rvvo) {
		log.info("예약 등록...");
		return rvMapper.insert(rvvo) == 1;
	}

	@Override
	public boolean remove(int rvno) {
		log.info("예약 삭제...");
		return rvMapper.delete(rvno) == 1;
	}

	@Override
	public boolean modify(ReservVO rvvo) {
		log.info("예약 수정...");
		return rvMapper.update(rvvo) == 1;
	}

	@Override
	public List<ReservVO> listPagingAdm(Criteria cri) {
		log.info("예약 관리자 목록...");
		return rvMapper.selectAllPagingAdm(cri);
	}

	@Override
	public List<ReservVO> listPagingUser(String id, Criteria cri) {
		log.info("예약 회원 목록...");
		//log.info(rvMapper.selectAllPagingUser(id, cri));
		return rvMapper.selectAllPagingUser(id, cri);
	}

	@Override
	public List<ReservVO> listPagingStaff(String sid, Criteria cri) {
		log.info("예약 병원 목록...");
		return rvMapper.selectAllPagingStaff(sid, cri);
	}

	@Override
	public int totalCountAdm(Criteria cri) {
		log.info("예약 관리자 count...");
		return rvMapper.totalCountAdm(cri);
	}

	@Override
	public int totalCountUser(String id, Criteria cri) {
		log.info("예약 회원 count..." + rvMapper.totalCountUser(id, cri));
		return rvMapper.totalCountUser(id, cri);
	}

	@Override
	public int totalCountStaff(String sid, Criteria cri) {
		log.info("예약 병원 count...");
		return rvMapper.totalCountStaff(sid, cri);
	}

	@Override
	public List<String> duplRvTime(String rvDate, int hno) {
		log.info("예약 시간 중복 체크");
		return rvMapper.duplRvTime(rvDate, hno);
	}


}
