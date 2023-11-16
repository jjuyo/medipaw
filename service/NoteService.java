package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.NoteVO;
import org.medipaw.mapper.NoteMapper;

public interface NoteService {
	public List<NoteVO> list(String id,Criteria cri);//��ü ����Ʈ
	public List<NoteVO> selectSend(String id,Criteria cri);//���� ����Ʈ
	public List<NoteVO> selectRecp(String id,Criteria cri);//���� ����Ʈ
	public List<NoteVO> selectSave(String id,Criteria cri);//���� ����Ʈ	
	
	public int totalCount1(String id);
	public int totalCount2(String id);
	public int totalCount3(String id);
	
	public boolean save(NoteVO nvo);
	public boolean delete(NoteVO nvo);
	
	public boolean register(NoteVO nvo);
	public List<NoteVO> list();
	public NoteVO view(int nno);
}
