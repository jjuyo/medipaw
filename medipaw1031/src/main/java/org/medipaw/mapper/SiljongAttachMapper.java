package org.medipaw.mapper;

import java.util.List;

import org.medipaw.domain.SiljongAttachVO;

public interface SiljongAttachMapper {
	public List<SiljongAttachVO> selectAttach(int sjno);
	public void insertAttach(SiljongAttachVO satvo);
	public void deleteAttach(String uuid);
	public void deleteAttachAll(int sjno);
	
	public List<SiljongAttachVO> yesterdayFiles();
}
