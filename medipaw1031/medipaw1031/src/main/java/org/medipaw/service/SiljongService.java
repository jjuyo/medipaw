package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.SiljongAttachVO;
import org.medipaw.domain.SiljongVO;

public interface SiljongService {
	public SiljongVO view(int sjno);
	public boolean register(SiljongVO sjvo);	
	public boolean remove(int sjno);
	public boolean modify(SiljongVO sjvo);
	public List<SiljongVO> listPaging(Criteria cri);
	public List<SiljongVO> listMine(String id, Criteria cri);
	public int totalCount(Criteria cri);
	public int totalCountMine(String id, Criteria cri);
	public void updateHit(int sjno);		// 조회 수
    public int getReplyCount(int sjno);		// 댓글 수
	
	public List<SiljongAttachVO> attachList(int sjno);
}
