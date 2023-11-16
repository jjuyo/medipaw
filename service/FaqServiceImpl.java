package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.FaqVO;
import org.medipaw.mapper.FaqMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class FaqServiceImpl implements FaqService {

    private final FaqMapper faqmapper;

    @Override
    public List<FaqVO> getFaqs() {
        return faqmapper.getFaqs();
    }

    @Override
    public boolean updateFaq(FaqVO fvo) {
        int result = faqmapper.updateFaq(fvo);
        
        return result > 0;
    }

	@Override
	public boolean deleteFaq(int faqNO) {
	     int result = faqmapper.deleteFaq(faqNO);
	     return result > 0;
	}

	@Override
	public boolean addFaq(FaqVO fvo) {
        int result = faqmapper.addFaq(fvo);
        return result > 0;
	}

}