package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.FaqVO;

public interface FaqService {

    public boolean updateFaq(FaqVO fvo);
    public boolean deleteFaq(int faqNO);
    public boolean addFaq(FaqVO fvo);
    public List<FaqVO> getFaqs();

}