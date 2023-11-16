package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.AnimalHospVO;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.NoteVO;
import org.medipaw.mapper.AnimalHospMapper;

public interface AnimalHospService {
	public List<AnimalHospVO> selectAllPaging(Criteria cri);//페이징
	public int totalCount(Criteria cri);//페이징
	public boolean modify(AnimalHospVO avo);//동물병원 수정
	public boolean remove(String sid);//동물병원 삭제
	public boolean register(AnimalHospVO avo);//동물병원 등록
	public List<AnimalHospVO> selectAll();//전체목록 - ? 없어도 되지 않을까 싶어서 고민중
	public AnimalHospVO select(int ano);//상세조회
	public List<AnimalHospVO> selectByAddr(Criteria cri,String addr);//주소창 검색 조회
	public List<AnimalHospVO> selectByMap(Criteria cri,double aLatitude, double aHardness);//지도상 검색 조회
	public List<AnimalHospVO> insertData(AnimalHospVO avo);
}