package org.medipaw.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.medipaw.domain.ConnectingBoardVO;
import org.medipaw.domain.ConnectingCriteria;
import org.medipaw.domain.ConnectingAttachFileDTO;
import org.medipaw.domain.ConnectingBoardAttachVO;
import org.medipaw.domain.ConnectingBoardVO;
import org.medipaw.domain.ConnectingCriteria;
import org.medipaw.domain.ConnectingBoardAttachVO;
import org.medipaw.mapper.ConnectingBoardAttachMapper;
import org.medipaw.mapper.ConnectingBoardMapper;
import org.medipaw.mapper.ConnectingBoardAttachMapper;
import org.medipaw.mapper.ConnectingBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ConnectingBoardServiceImpl implements ConnectingBoardService {
	private ConnectingBoardMapper connectingBoardMapper;
	private ConnectingBoardAttachMapper connectingBoardAttachMapper;
	private Set<ConnectingBoardVO> recommends = new HashSet<>();
	
	@Override
	@Transactional
	public boolean remove(int cno) {
		log.info("remove..........");
		connectingBoardAttachMapper.deleteAll(cno);
		return connectingBoardMapper.delete(cno) == 1;
	}

	@Override
	@Transactional
	public boolean modify(ConnectingBoardVO cbvo) {
		log.info("modify..........");
		
		connectingBoardAttachMapper.deleteAll(cbvo.getCno());	//기존 첨부파일 모두 삭제
		boolean result = connectingBoardMapper.update(cbvo) == 1;//게시물 수정

		if(cbvo.getCnAttachList() != null &&  
		   cbvo.getCnAttachList().size() > 0) {
			
			cbvo.getCnAttachList().forEach( cbavo -> {
				cbavo.setCno(cbvo.getCno());
				connectingBoardAttachMapper.insert(cbavo);
			});
		}
		return result;
	}
	
	@Override
	@Transactional
	public boolean register(ConnectingBoardVO cbvo) {
		log.info("register...." + cbvo);
		boolean result = connectingBoardMapper.insertSelectKey(cbvo) == 1;
		
		if(cbvo.getCnAttachList() != null && 
		   cbvo.getCnAttachList().size() > 0) {
			
			cbvo.getCnAttachList().forEach( cbavo -> {
				cbavo.setCno(cbvo.getCno());
				connectingBoardAttachMapper.insert(cbavo);
			});
		}
		return result;
	}
	
	@Override
	public void saveFile(ConnectingAttachFileDTO cadto) {
	    ConnectingBoardAttachVO cbavo = new ConnectingBoardAttachVO();
	    
	    // DTO 객체에서 필요한 정보 추출 후 VO 객체에 설정
	    cbavo.setUuid(cadto.getUuid());
	    cbavo.setUploadPath(cadto.getUploadPath());
	    cbavo.setFileName(cadto.getFileName());
	 
	    
	    connectingBoardAttachMapper.insert(cbavo);
	}
	@Override
	public List<ConnectingBoardAttachVO> cnAttachList(int cno) {
		return connectingBoardAttachMapper.select(cno);
	}


	@Override
	public List<ConnectingBoardVO> list(ConnectingCriteria ccri) {
		log.info("list..........");
		return connectingBoardMapper.selectAllPaging(ccri);
	}

	@Override
	public int totalCount(ConnectingCriteria ccri) {
		log.info("totalCount..........");
		return connectingBoardMapper.totalCount(ccri);
	}
	
	@Override
	public List<ConnectingBoardVO> myList(String id, ConnectingCriteria ccri) {
		// TODO Auto-generated method stub
		return connectingBoardMapper.mySelectAllPaging(id, ccri);
	}
	
	@Override
	public int myTotalCount(String id, ConnectingCriteria ccri) {
		log.info("mytotalCnt.....");
		return connectingBoardMapper.myTotalCount(id, ccri);
	}


	@Override
	public ConnectingBoardVO view(int cno) {
		log.info("view..........");
		connectingBoardMapper.increaseHit(cno); // 조회수 증가 처리
		return connectingBoardMapper.select(cno);
	}
	
	@Override
	public List<ConnectingBoardVO> list() {
		log.info("list..........");
		return connectingBoardMapper.selectAll();
	}
	
	
	@Override 
	@Transactional
	public void recommend(ConnectingBoardVO cbvo) throws Exception {
	    if (connectingBoardMapper.countRecommend(cbvo.getCno(), cbvo.getId()) > 0) {
	        throw new Exception("게시물 당 1번만 추천 가능합니다");
	    }
	    connectingBoardMapper.insertRecommend(cbvo);
	    connectingBoardMapper.increaseRecommendCount(cbvo.getCno());
	}
}
