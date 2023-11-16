package org.medipaw.mapper;

import java.util.List;

import org.medipaw.domain.NoteVO;
import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.Criteria;

public interface NoteMapper {
	public List<NoteVO> selectAllPaging(@Param("id") String id,@Param("cri") Criteria cri);//전체 쪽지함
	
	public List<NoteVO> selectRecp(@Param("id") String id,@Param("cri") Criteria cri);//받은 쪽지함
	public List<NoteVO> selectSend(@Param("id") String id,@Param("cri") Criteria cri);//보낸 쪽지함
	public List<NoteVO> selectSave(@Param("id") String id,@Param("cri") Criteria cri);//쪽지 보관함
	
	public int totalCount1(String id);//페이징
	public int totalCount2(String id);//페이징
	public int totalCount3(String id);//페이징

	public int insertSelectKey(NoteVO nvo);//쪽지 번호 자동으로 가져오기
	public boolean insert(NoteVO nvo);//쪽지 전송 및 답장
	public List<NoteVO> selectAll();//쪽지 전체 목록 가져오기
	public NoteVO select(int nno);//단건 조회
	
	public boolean updateSave(NoteVO nvo);//받은 쪽지 보관
	public boolean noteDelete(NoteVO nvo);//받은 쪽지 삭제
	public boolean unSave(NoteVO nvo);//받은 쪽지 보관
	public boolean noteCheck(NoteVO nvo);//첫 조회 할때 0에서 1로 변경 알람 대비용
	public List<NoteVO> getNewNotes(@Param("id") String id);

}
