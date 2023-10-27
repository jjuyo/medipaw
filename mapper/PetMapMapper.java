package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.PetMapVO;

public interface  PetMapMapper {
	
	public List<PetMapVO> getPetMap(); 
    public PetMapVO getPetMapInfo(@Param("lcLa") Double lcLa, @Param("lcLo") Double lcLo); // 수정된 부분
	/*
	 * public int updateFaq(FaqVO fvo); public int addFaq(FaqVO fvo); public int
	 * deleteFaq(int faqNO);
	 */


}
