package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.ConnectingBoardVO;
import org.medipaw.domain.ConnectingAttachFileDTO;
import org.medipaw.domain.ConnectingBoardAttachVO;
import org.medipaw.domain.ConnectingCriteria;

public interface ConnectingBoardService {
	public List<ConnectingBoardAttachVO> cnAttachList(int cno);
	public List<ConnectingBoardVO> list(ConnectingCriteria ccri);
	public List<ConnectingBoardVO> myList(String id, ConnectingCriteria ccri);
	public int totalCount(ConnectingCriteria ccri);
	public int myTotalCount(String id,ConnectingCriteria ccri);
	public void recommend(ConnectingBoardVO cbvo) throws Exception;
	public boolean modify(ConnectingBoardVO cbvo);
	public boolean remove(int cno);
	public void saveFile(ConnectingAttachFileDTO cadto);
	public boolean register(ConnectingBoardVO cbvo);
	public List<ConnectingBoardVO> list();
	public ConnectingBoardVO view(int cno);
	
}
