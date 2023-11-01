package org.medipaw.service;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReplyPageDTO;
import org.medipaw.domain.ReplyVO;

public interface ReplyService {
	public ReplyPageDTO list(int byno, Criteria cri);
	public boolean add(ReplyVO rvo);
	public ReplyVO view(int byRno);
	public boolean modify(ReplyVO rvo);
	public boolean remove(int byRno);
	
}
