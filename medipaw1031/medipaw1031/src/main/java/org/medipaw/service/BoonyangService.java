package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.BoonyangAttachVO;
import org.medipaw.domain.BoonyangVO;
import org.medipaw.domain.Criteria;


public interface BoonyangService {
   public List<BoonyangVO> pageList(Criteria cri);
   public List<BoonyangVO> myList(String id, Criteria cri);
   public int totalCount(Criteria cri);
   public int mytotalCount(String id, Criteria cri);
   
   public BoonyangVO view(int byno);
   public boolean register(BoonyangVO bvo);
   public boolean remove(int byno);
   public boolean modify(BoonyangVO bvo);
   
   public List<BoonyangAttachVO> attachList(int byno);
   
}