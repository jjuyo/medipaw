package org.medipaw.service;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.SiljongReplyPageDTO;
import org.medipaw.domain.SiljongReplyVO;
import org.medipaw.domain.SiljongVO;
import org.medipaw.mapper.SiljongMapper;
import org.medipaw.mapper.SiljongReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SiljongReplyServiceImpl implements SiljongReplyService {
	@Setter(onMethod_ = @Autowired)		
	private SiljongMapper sjMapper;
	@Setter(onMethod_ = @Autowired)		
	private SiljongReplyMapper sjrMapper;
	
	@Override
	@Transactional
	public boolean add(SiljongReplyVO sjrvo) {
		log.info("실종 댓글 작성...");
		sjMapper.updateReplyCnt(sjrvo.getSjno(), 1);
		return sjrMapper.insert(sjrvo) == 1;
	}
	
	@Override
	public SiljongReplyVO view(int sjrno) {
		log.info("실종 댓글 상세...");
		return sjrMapper.select(sjrno);
	}
	
	@Override
	public SiljongReplyPageDTO listPaging(int sjno, Criteria cri) {
		log.info("실종 댓글 목록");
		return new SiljongReplyPageDTO(sjrMapper.countReply(sjno), sjrMapper.selectAllPaging(sjno, cri));
	}
	
	@Override
	public boolean modify(SiljongReplyVO sjrvo) {
		log.info("실종 댓글 수정...");
		return sjrMapper.update(sjrvo) == 1;
	}
	
	@Override
	@Transactional
	public boolean remove(int sjrno) {
		log.info("실종 댓글 삭제");
		SiljongReplyVO sjrvo = sjrMapper.select(sjrno);
		sjMapper.updateReplyCnt(sjrvo.getSjno(), -1);
		return sjrMapper.delete(sjrno) == 1;
	}

}
