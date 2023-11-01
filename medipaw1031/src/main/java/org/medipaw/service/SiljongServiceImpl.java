package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.SiljongAttachVO;
import org.medipaw.domain.SiljongVO;
import org.medipaw.mapper.SiljongAttachMapper;
import org.medipaw.mapper.SiljongMapper;
import org.medipaw.mapper.SiljongReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SiljongServiceImpl implements SiljongService {
	@Setter(onMethod_ = @Autowired)		
	private SiljongMapper sjMapper;
	@Setter(onMethod_ = @Autowired)		
	private SiljongAttachMapper sjattMapper;
	@Setter(onMethod_ = @Autowired)		
	private SiljongReplyMapper sjrMapper;
	private boolean result;

	@Override
	public SiljongVO view(int sjno) {
		log.info("실종 상세조회...");
		sjattMapper.selectAttach(sjno);		// 첨부파일 불러오기
		return sjMapper.select(sjno);
	}

	@Override
	@Transactional
	public boolean register(SiljongVO sjvo) {
		log.info("실종 등록...");
		result = sjMapper.insert(sjvo) == 1;					// insert 먼저 실행
		if(sjvo.getAttachList() != null && sjvo.getAttachList().size() > 0) {
			sjvo.getAttachList().forEach(satvo ->{				// 첨부파일 등록할 내용이 있으면 값 넣기
				satvo.setSjno(sjvo.getSjno());					// 그래야 첨부 파일 등록할 때 필요한 sjno가 생성됨
				sjattMapper.insertAttach(satvo);
	      });
		}
		return result;
	}

	@Override
	@Transactional
	public boolean remove(int sjno) {
		log.info("실종 삭제...");
		sjattMapper.deleteAttachAll(sjno);
		return sjMapper.delete(sjno) == 1;
	}

	@Override
	@Transactional
	public boolean modify(SiljongVO sjvo) {
		log.info("실종 수정...");
		sjattMapper.deleteAttachAll(sjvo.getSjno()); 		// 해당 sjno의 첨부파일을 싹 삭제하고 추가하기
		
		result = sjMapper.update(sjvo) == 1;				// 수정 먼저 해야 함
		if(sjvo.getAttachList() != null && sjvo.getAttachList().size() > 0) {
				sjvo.getAttachList().forEach(satvo ->{		// 첨부파일 등록할 내용이 있으면 값 넣기
					satvo.setSjno(sjvo.getSjno());			// 그래야 첨부 파일 새로 넣을 때 필요한 sjno를 가져옴
					sjattMapper.insertAttach(satvo);
		      });
		}
		return result;
	}

	@Override
	public List<SiljongVO> listPaging(Criteria cri) {
		log.info("실종 전체 목록...");
		return sjMapper.selectAllPaging(cri);
	}

	@Override
	public List<SiljongVO> listMine(String id, Criteria cri) {
		log.info("실종 내 목록...");
		return sjMapper.selectMine(id, cri);
	}
	
	@Override
	public int totalCount(Criteria cri) {
		log.info("실종 게시물 수");
		return sjMapper.totalCount(cri);
	}

	@Override
	public void updateHit(int sjno) {
		log.info("조회수 + 1");
		sjMapper.updateHit(sjno);
	}

	@Override
	public int totalCountMine(String id, Criteria cri) {
		log.info("실종 내 게시물 수");
		return sjMapper.totalCountMine(id, cri);
	}

	@Override
	public List<SiljongAttachVO> attachList(int sjno) {
		log.info("Siljong attachList...");
		return sjattMapper.selectAttach(sjno);
	}

	@Override
	public int getReplyCount(int sjno) {
		log.info("실종 댓글 수");
		return sjrMapper.countReply(sjno);
	}

}
