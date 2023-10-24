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
	public boolean modify(FaqVO fvo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(int faqNO) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean register(FaqVO fvo) {
		// TODO Auto-generated method stub
		return false;
	}

}