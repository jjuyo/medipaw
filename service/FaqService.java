package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.FaqVO;

public interface FaqService {

	
    public boolean modify(FaqVO fvo);
    public boolean remove(int faqNO);
    public boolean register(FaqVO fvo);
    public List<FaqVO> getFaqs();

}