package org.medipaw.service;
import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.MarkVO;
import org.medipaw.domain.SiljongVO;
import org.medipaw.mapper.MarkMapper;
import org.medipaw.mapper.SiljongMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MarkServiceImpl implements MarkService {
	@Setter(onMethod_ = @Autowired)		
	private MarkMapper mMapper;

	@Override
	public boolean register(MarkVO mvo) {
		log.info("...");
		return mMapper.insert(mvo) == 1;
	}

	@Override
	public boolean remove(MarkVO mvo) {
		log.info("");
		return mMapper.delete(mvo) == 1;
	}

	@Override
	public List<MarkVO> listHos(String id, Criteria cri) {
		log.info("");
		return mMapper.selectHos(id, cri);
	}

	@Override
	public List<MarkVO> listMno(String id, Criteria cri) {
		log.info("");
		return mMapper.selectMno(id, cri);
	}

	@Override
	public int totalCount(String id, Criteria cri) {
		log.info("");
		return mMapper.totalCount(id, cri);
	}

	@Override
	public int select(String id, int animalhosp_no) {
		log.info("");
		return mMapper.select(id, animalhosp_no);
	}
}
