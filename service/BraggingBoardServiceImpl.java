package org.medipaw.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.medipaw.domain.BraggingBoardVO;
import org.medipaw.domain.BoonyangVO;
import org.medipaw.domain.BraggingAttachFileDTO;
import org.medipaw.domain.BraggingBoardAttachVO;
import org.medipaw.domain.BraggingCriteria;
import org.medipaw.domain.Criteria;
import org.medipaw.mapper.BraggingBoardAttachMapper;
import org.medipaw.mapper.BraggingBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BraggingBoardServiceImpl implements BraggingBoardService {
	private BraggingBoardMapper braggingBoardMapper;
	private BraggingBoardAttachMapper braggingBoardAttachMapper;
	private Set<BraggingBoardVO> recommends = new HashSet<>();
	
	@Override
	@Transactional
	public boolean remove(int bno) {
		log.info("remove..........");
		braggingBoardAttachMapper.deleteAll(bno);
		return braggingBoardMapper.delete(bno) == 1;
	}

	@Override
	@Transactional
	public boolean modify(BraggingBoardVO bbvo) {
		log.info("modify..........");
		
		braggingBoardAttachMapper.deleteAll(bbvo.getBno());	//기존 첨부파일 모두 삭제
		boolean result = braggingBoardMapper.update(bbvo) == 1;//게시물 수정

		if(bbvo.getBrAttachList() != null &&  
		   bbvo.getBrAttachList().size() > 0) {
			
			bbvo.getBrAttachList().forEach( bbavo -> {
				bbavo.setBno(bbvo.getBno());
				braggingBoardAttachMapper.insert(bbavo);
			});
		}
		return result;
	}
	
	@Override
	@Transactional
	public boolean register(BraggingBoardVO bbvo) {
		log.info("register...." + bbvo);
		boolean result = braggingBoardMapper.insertSelectKey(bbvo) == 1;
		
		if(bbvo.getBrAttachList() != null && 
		   bbvo.getBrAttachList().size() > 0) {
			
			bbvo.getBrAttachList().forEach( bbavo -> {
				bbavo.setBno(bbvo.getBno());
				braggingBoardAttachMapper.insert(bbavo);
			});
		}
		return result;
	}
	
	@Override
	public void saveFile(BraggingAttachFileDTO badto) {
	    BraggingBoardAttachVO bbavo = new BraggingBoardAttachVO();
	    
	    // DTO 객체에서 필요한 정보 추출 후 VO 객체에 설정
	    bbavo.setUuid(badto.getUuid());
	    bbavo.setUploadPath(badto.getUploadPath());
	    bbavo.setFileName(badto.getFileName());
	 
	    
	    braggingBoardAttachMapper.insert(bbavo);
	}
	@Override
	public List<BraggingBoardAttachVO> brAttachList(int bno) {
		return braggingBoardAttachMapper.select(bno);
	}

	@Override
	public List<BraggingBoardVO> list(BraggingCriteria bcri) {
		log.info("list..........");
		return braggingBoardMapper.selectAllPaging(bcri);
	}

	@Override
	public int totalCount(BraggingCriteria bcri) {
		log.info("totalCount..........");
		return braggingBoardMapper.totalCount(bcri);
	}
	
	@Override
	public List<BraggingBoardVO> myList(String id, BraggingCriteria bcri) {
		// TODO Auto-generated method stub
		return braggingBoardMapper.mySelectAllPaging(id, bcri);
	}
	
	@Override
	public int myTotalCount(String id, BraggingCriteria bcri) {
		log.info("mytotalCnt.....");
		return braggingBoardMapper.myTotalCount(id, bcri);
	}


	@Override
	public BraggingBoardVO view(int bno) {
		log.info("view..........");
		braggingBoardMapper.increaseHit(bno); // 조회수 증가 처리
		return braggingBoardMapper.select(bno);
	}
	
	@Override
	public List<BraggingBoardVO> list() {
		log.info("list..........");
		return braggingBoardMapper.selectAll();
	}
	
	
	@Override 
	@Transactional
	public void recommend(BraggingBoardVO bbvo) throws Exception {
	    if (braggingBoardMapper.countRecommend(bbvo.getBno(), bbvo.getId()) > 0) {
	        throw new Exception("게시물 당 1번만 추천 가능합니다");
	    }
	    braggingBoardMapper.insertRecommend(bbvo);
	    braggingBoardMapper.increaseRecommendCount(bbvo.getBno());
	}
}
