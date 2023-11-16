package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.MarkVO;

public interface MarkService {
	public boolean register(MarkVO mvo);	
	public boolean remove(MarkVO mvo);
	public List<MarkVO> listHos(String id, Criteria cri);
	public List<MarkVO> listMno(String id, Criteria cri);
	public int totalCount(String id, Criteria cri);
	public int select(String id, int animalhosp_no);
}
