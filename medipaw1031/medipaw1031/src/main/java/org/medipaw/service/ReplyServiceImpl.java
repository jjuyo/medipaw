package org.medipaw.service;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReplyPageDTO;
import org.medipaw.domain.ReplyVO;
import org.medipaw.mapper.BoonyangMapper;
import org.medipaw.mapper.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private ReplyMapper replyMapper;
	private BoonyangMapper byMapper;

	@Transactional
	@Override
	public boolean add(ReplyVO rvo) {
		log.info("register....." + rvo);
		byMapper.updateReplyCnt(rvo.getByno(), 1);
		return replyMapper.insert(rvo)==1;
	}

	@Override
	public ReplyVO view(int byRno) {
		log.info("view....." + byRno);
		return replyMapper.select(byRno);
	}

	@Override
	public boolean modify(ReplyVO rvo) {
		log.info("modify....." + rvo);
		return replyMapper.update(rvo) == 1;
	}

	@Transactional
	@Override
	public boolean remove(int byRno) {
		log.info("remove....." + byRno);
		ReplyVO rvo = replyMapper.select(byRno);
		byMapper.updateReplyCnt(rvo.getByno(), -1);
		return replyMapper.delete(byRno)==1;
	}

	@Override
	public ReplyPageDTO list(int byno, Criteria cri) {
		log.info("list.....");
		return new ReplyPageDTO(replyMapper.selectReply(byno), replyMapper.selectAllPaging(byno, cri));
	}

}
