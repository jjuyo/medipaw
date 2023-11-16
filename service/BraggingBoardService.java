package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.BraggingAttachFileDTO;
import org.medipaw.domain.BraggingBoardAttachVO;
import org.medipaw.domain.BraggingBoardVO;
import org.medipaw.domain.BraggingCriteria;


public interface BraggingBoardService {
	public List<BraggingBoardAttachVO> brAttachList(int bno);
	public List<BraggingBoardVO> list(BraggingCriteria bcri);
	public List<BraggingBoardVO> myList(String id, BraggingCriteria bcri);
	public int totalCount(BraggingCriteria bcri);
	public int myTotalCount(String id,BraggingCriteria bcri);
	public void recommend(BraggingBoardVO bbvo) throws Exception;
	public boolean modify(BraggingBoardVO bbvo);
	public boolean remove(int bno);
	public void saveFile(BraggingAttachFileDTO badto);
	public boolean register(BraggingBoardVO bbvo);
	public List<BraggingBoardVO> list();
	public BraggingBoardVO view(int bno);
}
