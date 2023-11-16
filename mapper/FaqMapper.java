package org.medipaw.mapper;

import java.util.List;

import org.medipaw.domain.FaqVO;

public interface  FaqMapper {
	
	public List<FaqVO> getFaqs(); 
	public int updateFaq(FaqVO fvo);
	public int addFaq(FaqVO fvo);
	public int deleteFaq(int faqNO);


}
