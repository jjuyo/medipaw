package org.medipaw.service;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.SiljongReplyPageDTO;
import org.medipaw.domain.SiljongReplyVO;
import org.medipaw.domain.SiljongVO;

public interface SiljongReplyService {
	public boolean add(SiljongReplyVO sjrvo);
	public SiljongReplyVO view(int sjrno);
	public SiljongReplyPageDTO listPaging(int sjno, Criteria cri);
	public boolean modify(SiljongReplyVO sjrvo);
	public boolean remove(int sjrno);
}
