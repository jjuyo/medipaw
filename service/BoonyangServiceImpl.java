package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.BoonyangAttachVO;
import org.medipaw.domain.BoonyangVO;
import org.medipaw.domain.Criteria;
import org.medipaw.mapper.BoonyangAttachMapper;
import org.medipaw.mapper.BoonyangMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoonyangServiceImpl implements BoonyangService {
	@Setter(onMethod_ = @Autowired)
	private BoonyangMapper byMapper;
	@Setter(onMethod_ = @Autowired)
	private BoonyangAttachMapper baMapper;
	private boolean result;
	
	@Override
	public List<BoonyangVO> pageList(Criteria cri) {
		log.info("pageList.....");
		return byMapper.selectAllPaging(cri);
	}
	
	@Override
	public List<BoonyangVO> myList(String id, Criteria cri) {
		// TODO Auto-generated method stub
		return byMapper.selectMyList(id, cri);
	}

	@Override
	@Transactional
	public boolean register(BoonyangVO bvo) {
		log.info("register...." + bvo);
		result = byMapper.insert(bvo) == 1;					// insert 먼저 실행
		if(bvo.getAttachList() != null && bvo.getAttachList().size() > 0) {
			bvo.getAttachList().forEach(bavo ->{				// 첨부파일 등록할 내용이 있으면 값 넣기
				bavo.setByno(bvo.getByno());					// 그래야 첨부 파일 등록할 때 필요한 sjno가 생성됨
				baMapper.insertAttach(bavo);
	      });
		}
		return result;
	}

//	@Override
//	public String attachList(int Byno) {
////		log.info("attachList.....");
////		return byAttachMapper.select(Byno); //게시판 상세보기에서 첨부파일 리스트
//	}
	

	@Override
	public BoonyangVO view(int Byno) {
		log.info("view.....");
		return byMapper.select(Byno);
	}
	
	@Transactional
	@Override
	public boolean remove(int byno) {
		log.info("remove..." + byno);
		
		baMapper.deleteAttachAll(byno);
		return byMapper.delete(byno) == 1;
	}

	@Override
	@Transactional
	public boolean modify(BoonyangVO bvo) {
		log.info("modify..." + bvo);
		baMapper.deleteAttachAll(bvo.getByno()); 		
		
		result = byMapper.update(bvo) == 1;				
		if(bvo.getAttachList() != null && bvo.getAttachList().size() > 0) {
			bvo.getAttachList().forEach(bavo ->{		
				bavo.setByno(bvo.getByno());			
					baMapper.insertAttach(bavo);
		      });
		}
		return result;
	}

	@Override
	public int totalCount(Criteria cri) {
		log.info("totalCnt.....");
		return byMapper.totalCount(cri);
	}

	@Override
	public List<BoonyangAttachVO> attachList(int byno) {
		log.info("Boonyang attachList...");
		return baMapper.selectAttach(byno);
	}

	@Override
	public int mytotalCount(String id, Criteria cri) {
		log.info("mytotalCnt.....");
		return byMapper.mytotalCount(id, cri);
	}


}