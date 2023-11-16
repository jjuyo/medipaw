package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.FaqVO;
import org.medipaw.domain.PetMapVO;
import org.medipaw.mapper.PetMapMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class PetMapServiceImpl implements PetMapService {

    private final PetMapMapper petMapmapper;

    @Override
    public List<PetMapVO> getPetMap() {
    	
        return petMapmapper.getPetMap();
    }

	@Override
	public PetMapVO getPetMapInfo(Double lcLa, Double lcLo) {
        return petMapmapper.getPetMapInfo(lcLa, lcLo);
	}

	/*
	 * @Override public boolean updateFaq(FaqVO fvo) { int result =
	 * faqmapper.updateFaq(fvo);
	 * 
	 * return result > 0; }
	 * 
	 * @Override public boolean deleteFaq(int faqNO) { int result =
	 * faqmapper.deleteFaq(faqNO); return result > 0; }
	 * 
	 * @Override public boolean addFaq(FaqVO fvo) { int result =
	 * faqmapper.addFaq(fvo); return result > 0; }
	 * 
	 * @Override public List<FaqVO> getFaqs() { // TODO Auto-generated method stub
	 * return null; }
	 */

}