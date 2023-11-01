package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReviewVO;
import org.medipaw.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewServiceImpl implements ReviewService {
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper reviewMapper;

	@Override
	public ReviewVO view(int rno) {
		log.info("view.....");
		return reviewMapper.select(rno);
	}

	@Override
	public boolean register(ReviewVO rvo) {
		log.info("register.....");
		return reviewMapper.insert(rvo)==1;
	}

	@Override
	public boolean modify(ReviewVO rvo) {
		log.info("modify.....");
		return reviewMapper.update(rvo)==1;
	}

	
	@Override
	public boolean remove(int rno) {
		log.info("remove.....");
		return reviewMapper.delete(rno)==1;
	}
	@Override
	public int totalCount(int animalhosp_no, Criteria cri) {
		log.info("totalCnt.....");
		return reviewMapper.totalCount(animalhosp_no, cri);
	}

	@Override
	public List<ReviewVO> list(int animalhosp_no, Criteria cri) {
		log.info("pageList.....");
		return reviewMapper.selectAll(animalhosp_no, cri);
	}

	@Override
	public List<ReviewVO> myList(String id, Criteria cri) {
		log.info("myList.....");
		return reviewMapper.selectMy(id, cri);
	}

	@Override
	public int mytotalCount(String id, Criteria cri) {
		log.info("mytotalCount.....");
		return reviewMapper.mytotalCount(id, cri);
	}

	@Override
	public boolean tnoCheck(int tno) {
		log.info("tno check");
		return reviewMapper.tnoCheck(tno)==1;
	}


}