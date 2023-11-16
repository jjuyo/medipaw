package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReviewVO;


public interface ReviewService {
   public List<ReviewVO> list(int animalhosp_no, Criteria cri);
   public int totalCount(int animalhosp_no, Criteria cri);
   public int mytotalCount(String id, Criteria cri);
   public List<ReviewVO> myList(String id, Criteria cri);
   public ReviewVO view(int rno);
   public boolean register(ReviewVO rvo);
   public boolean remove(int rno);
   public boolean modify(ReviewVO rvo);
   public boolean tnoCheck(int tno);
   
   
}