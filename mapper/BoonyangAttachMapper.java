package org.medipaw.mapper;

import java.util.List;

import org.medipaw.domain.BoonyangAttachVO;

public interface BoonyangAttachMapper {
	public List<BoonyangAttachVO> selectAttach(int byno);
	public void insertAttach(BoonyangAttachVO bavo);
	public void deleteAttach(String uuid);
	public void deleteAttachAll(int sjno);
	
	public List<BoonyangAttachVO> yesterdayFiles();
}
