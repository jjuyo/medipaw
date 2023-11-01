package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.BraggingBoardAttachVO;
import org.medipaw.domain.BraggingBoardVO;
import org.medipaw.domain.BraggingCriteria;

public interface BraggingBoardAttachMapper {
	public List<BraggingBoardAttachVO> yesterdayFiles();
	public void deleteAll(int bno);
	public void delete(String uuid);
	public void insert(BraggingBoardAttachVO bbavo);
	public List<BraggingBoardAttachVO> select(int bno);
}
