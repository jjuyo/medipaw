package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.ConnectingBoardAttachVO;
import org.medipaw.domain.ConnectingBoardVO;
import org.medipaw.domain.BraggingCriteria;


public interface ConnectingBoardAttachMapper {
	public List<ConnectingBoardAttachVO> yesterdayFiles();
	public void deleteAll(int cno);
	public void delete(String uuid);
	public void insert(ConnectingBoardAttachVO cbavo);
	public List<ConnectingBoardAttachVO> select(int cno);
}
