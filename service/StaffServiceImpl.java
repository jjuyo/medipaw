package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.StaffVO;
import org.medipaw.mapper.StaffMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class StaffServiceImpl implements StaffService {
	@Setter(onMethod_ = @Autowired)
	private StaffMapper staffMapper;
	
	@Override
	public List<StaffVO> pageList(Criteria cri) {
		log.info("pageList.....");
		return staffMapper.selectAllPaging(cri);
	}

	@Override
	public int totalCount(Criteria cri) {
		log.info("totalCnt....."+staffMapper.totalCount(cri));
		
		return staffMapper.totalCount(cri);
	}


	@Override
	public String findId(String sname, String sphone) {
		log.info("findId....");
		return staffMapper.findId(sname, sphone);
	}


	@Override
	public int findPw(String sid, String sname, String sphone) {
		log.info("finePw....");
		return staffMapper.findPw(sid, sname, sphone);
	}

	@Override
	public boolean idCheck(String sid) {
		return staffMapper.idCheck(sid)==1;
	}
	
	@Override
	public boolean changePw(String spw) {
		// TODO Auto-generated method stub
		return staffMapper.changePw(spw)==1;
	}
	
	@Override
	public boolean register(StaffVO svo) {
		// TODO Auto-generated method stub
		return staffMapper.insert(svo)==1;
	}

	@Override
	public StaffVO view(String sid) {
		
		return staffMapper.select(sid);
	}

	@Override
	public boolean remove(String sid) {
		log.info("modify..." + sid);
		return staffMapper.delete(sid)==1;
	}

	@Override
	public boolean modify(StaffVO svo) {
		log.info("modify..." + svo);
		return staffMapper.update(svo)==1;
	}

	
	@Override
	public boolean modifyPw(String sid, String spw) {
		log.info("modifyPw..." + spw);
		return staffMapper.updatePw(sid, spw)==1;
	}



}