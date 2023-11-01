package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.FaqVO;
import org.medipaw.domain.PetMapVO;

public interface PetMapService {

    public List<PetMapVO> getPetMap();
    public PetMapVO getPetMapInfo(Double lcLa, Double lcLo);

	
	/*
	 * public boolean updateFaq(FaqVO fvo); public boolean deleteFaq(int faqNO);
	 * public boolean addFaq(FaqVO fvo); public List<FaqVO> getFaqs();
	 */

}