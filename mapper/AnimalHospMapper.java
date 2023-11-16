package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.AnimalHospVO;
import org.medipaw.domain.Criteria;

public interface AnimalHospMapper {
	public List<AnimalHospVO> selectAllPaging(Criteria cri);//페이징	
	public int totalCount(Criteria cri);//페이징
	public boolean update(AnimalHospVO avo);//동물병원 정보 수정
	public boolean delete(String sid);//동물병원 정보 삭제
	public boolean insert(AnimalHospVO avo);//동물병원 정보 등록
	public List<AnimalHospVO> list();//전체 리스트 보기
	public AnimalHospVO view(int ano);//상세보기
	public AnimalHospVO Myview(String sid);//나의 병원 상세보기
	
	//검색기능 지도 api 결과값 받아와서 그걸로 search
	public List<AnimalHospVO> searchByAddr(String addr);
	
	//위도 경도 반경 범위 한정으로 지도를 옮길때마다 ajax로 search해오는 것도 필요함 
	public List<AnimalHospVO> searchByMap(@Param("cri") Criteria cri, @Param("aLatitude") double aLatitude, @Param("aHardness") double aHardness);    
}