package org.medipaw.controller;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.SiljongReplyPageDTO;
import org.medipaw.domain.SiljongReplyVO;
import org.medipaw.service.SiljongReplyService;
import org.medipaw.service.SiljongService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController					// JSON 사용하면 @RestController 사용 -> @Controller 안돼!!!
@Log4j
@RequestMapping("/sjreply/")
@AllArgsConstructor
public class SiljongReplyController {
	private SiljongReplyService sjrService;
	private SiljongService sjService;
	
	
	// 댓글 목록 및 200번 상태 코드 반환
	@GetMapping(value="pages/{sjno}/{pageNum}")			// url : /sjreply/pages/:sjno/:pageNum으로 갈겨!				
	public ResponseEntity<SiljongReplyPageDTO> list(@PathVariable("sjno") int sjno, @PathVariable("pageNum") int pageNum) {		
		log.info("siljong reply list Controller...");
		Criteria cri = new Criteria(10, pageNum);
		return new ResponseEntity<SiljongReplyPageDTO>(sjrService.listPaging(sjno, cri), HttpStatus.OK);
	}
	
	// JSON으로 댓글 등록
	@PostMapping(value="add", produces=MediaType.TEXT_PLAIN_VALUE)	
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> add(@RequestBody SiljongReplyVO sjrvo) {		
		log.info("siljong reply add Controller...");
		if(sjrService.add(sjrvo)) {
			// 등록 성공이면 200과 successA 보내고
			return new ResponseEntity<>("successA", HttpStatus.OK);
		} else {
			// 실패하면 500 상태코드 반환
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 댓글 1개 및 200번 상태 코드 반환
	@GetMapping(value="{sjrno}")			// url : /sjreply/:sjrno로 갈겨!				
	public ResponseEntity<SiljongReplyVO> view(@PathVariable("sjrno") int sjrno) {		
		log.info("siljong reply view Controller...");
		return new ResponseEntity<SiljongReplyVO>(sjrService.view(sjrno), HttpStatus.OK);
	}
		
	// JSON으로 댓글 수정
	@RequestMapping(value="{sjrno}", produces=MediaType.TEXT_PLAIN_VALUE, 
					method = {RequestMethod.PUT, RequestMethod.PATCH})		
	public ResponseEntity<String> modify(@RequestBody SiljongReplyVO sjrvo, @PathVariable("sjrno") int sjrno) {		
		log.info("siljong reply modify Controller...");
		if(sjrService.modify(sjrvo)) {
			// 수정 성공이면 200과 success 보내고
			return new ResponseEntity<>("successRM", HttpStatus.OK);
		} else {
			// 실패하면 500 상태코드 반환
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// JSON으로 댓글 삭제
	@DeleteMapping(value="{sjrno}", produces="text/plain; charset=UTF-8")		
	public ResponseEntity<String> remove(String writer, @PathVariable("sjrno") int sjrno) {		
		log.info("siljong reply remove Controller...");
		if(sjrService.remove(sjrno)) {
			// 삭제 성공이면 200과 success 보내고
			return new ResponseEntity<>("successRD", HttpStatus.OK);
		} else {
			// 실패하면 500 상태코드 반환
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
    // 댓글 수를 불러오는 메서드
    @GetMapping(value = "count/{sjno}", produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> getReplyCount(@PathVariable("sjno") int sjno) {
        log.info("Get Siljong Reply Count Controller...");
        int count = sjService.getReplyCount(sjno); // SiljongService를 사용하여 댓글 수 가져오기
        return new ResponseEntity<>(String.valueOf(count), HttpStatus.OK);
    }

}
