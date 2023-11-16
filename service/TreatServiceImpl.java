package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.TreatVO;
import org.medipaw.mapper.TreatMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class TreatServiceImpl implements TreatService {
	@Setter(onMethod_ = @Autowired)		
	private TreatMapper tMapper;
	
	@Override
	public TreatVO view(int tno) {
		log.info("진료 상세 조회...");
		return tMapper.select(tno);
	}

	@Override
	public boolean register(TreatVO tvo) {
		log.info("진료 정보 등록...");
		return tMapper.insert(tvo) == 1;
	}

	@Override
	public boolean remove(int tno) {
		log.info("진료 정보 삭제...");
		return tMapper.delete(tno) == 1;
	}

	@Override
	public boolean modify(TreatVO tvo) {
		log.info("진료 정보 수정...");
		return tMapper.update(tvo) == 1;
	}

	@Override
	public List<TreatVO> listPagingAdm(Criteria cri) {
		log.info("진료 관리자 목록...");
		return tMapper.selectAllPagingAdm(cri);
	}

	@Override
	public List<TreatVO> listPagingUser(String id, Criteria cri) {
		log.info("진료 회원 목록...");
		return tMapper.selectAllPagingUser(id, cri);
	}

	@Override
	public List<TreatVO> listPagingStaff(String sid, Criteria cri) {
		log.info("진료 병원 목록...");
		return tMapper.selectAllPagingStaff(sid, cri);
	}

	@Override
	public int totalCountAdm(Criteria cri) {
		log.info("진료 관리자 count...");
		return tMapper.totalCountAdm(cri);
	}

	@Override
	public int totalCountUser(String id, Criteria cri) {
		log.info("진료 회원 count...");
		return tMapper.totalCountUser(id, cri);
	}

	@Override
	public int totalCountStaff(String sid, Criteria cri) {
		log.info("진료 병원 count...");
		return tMapper.totalCountStaff(sid, cri);
	}

	@Override
	public int treatCnt(int rvno) {
		log.info("진료 기록 count...");
		return tMapper.treatCnt(rvno);
	}

	@Override
	public boolean updateDelCheck(TreatVO tvo) {
		log.info("회원 delCheck...");
		return tMapper.updateDelCheck(tvo) == 1;
	}

}
