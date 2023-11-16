package org.medipaw.mapper;

import java.util.List;

import org.medipaw.domain.NoteVO;
import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;

public interface NoteMapper {
	public List<NoteVO> selectAllPaging(@Param("id") String id,@Param("cri") Criteria cri);//��ü ������
	
	public List<NoteVO> selectRecp(@Param("id") String id,@Param("cri") Criteria cri);//���� ������
	public List<NoteVO> selectSend(@Param("id") String id,@Param("cri") Criteria cri);//���� ������
	public List<NoteVO> selectSave(@Param("id") String id,@Param("cri") Criteria cri);//���� ������
	
	public int totalCount1(String id);//����¡
	public int totalCount2(String id);//����¡
	public int totalCount3(String id);//����¡

	public int insertSelectKey(NoteVO nvo);//���� ��ȣ �ڵ����� ��������
	public boolean insert(NoteVO nvo);//���� ���� �� ����
	public List<NoteVO> selectAll();//���� ��ü ��� ��������
	public NoteVO select(int nno);//�ܰ� ��ȸ
	
	public boolean updateSave(NoteVO nvo);//���� ���� ����
	public boolean noteDelete(NoteVO nvo);//���� ���� ����
	public boolean unSave(NoteVO nvo);//���� ���� ����
	public boolean noteCheck(NoteVO nvo);//ù ��ȸ �Ҷ� 0���� 1�� ���� �˶� ����
	public List<NoteVO> getNewNotes(@Param("id") String id);

}
