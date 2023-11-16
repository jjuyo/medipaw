package org.medipaw.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.NoteVO;
import org.medipaw.mapper.NoteMapper;

@Service
@AllArgsConstructor
@Slf4j
public class NoteServiceImpl implements NoteService {
    private final NoteMapper noteMapper;

    @Override
    public List<NoteVO> list(String id,Criteria cri) {
        log.info("list with paging..........");
        return noteMapper.selectAllPaging(id,cri);
    }

    @Override
    public int totalCount1(String id) {
        log.info("total count..........");
        return noteMapper.totalCount1(id);
    }
    
    @Override
    public int totalCount2(String id) {
        log.info("total count..........");
        return noteMapper.totalCount2(id);
    }
    
    @Override
    public int totalCount3(String id) {
        log.info("total count..........");
        return noteMapper.totalCount3(id);
    }
    @Override
    @Transactional
    public boolean delete(NoteVO nvo) {
        log.info("remove..........");
        return noteMapper.noteDelete(nvo) ;  
        }

   @Override
   @Transactional 
   public boolean register(NoteVO nvo) { 
       log.info("register...." + nvo); 
       boolean result = noteMapper.insert(nvo);
	   return result;
   } 

   @Override 
   public List<NoteVO> list() { 
       log.info("list all.........."); 
       return noteMapper.selectAll();  
   } 

   @Override 
   public NoteVO view(int nno) {  
      log.info("view single record..........");  
      return noteMapper.select(nno);   
  }

@Override
public boolean save(NoteVO nvo) {//쪽지 보관
    log.info("update saveLoc..........");
    return noteMapper.updateSave(nvo);
}

@Override
public List<NoteVO> selectSend(String id,Criteria cri) {
    log.info("list with paging..........");
    return noteMapper.selectSend(id,cri);
}

@Override
public List<NoteVO> selectRecp(String id,Criteria cri) {
    log.info("list with paging..........");
    return noteMapper.selectRecp(id,cri);
}

	@Override
	public List<NoteVO> selectSave(String id,Criteria cri) {
	    log.info("list with paging..........");
	    return noteMapper.selectSave(id,cri);
	}
}
