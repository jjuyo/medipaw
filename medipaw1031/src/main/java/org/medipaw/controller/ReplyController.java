package org.medipaw.controller;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.ReplyPageDTO;
import org.medipaw.domain.ReplyVO;
import org.medipaw.service.ReplyService;
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

@RestController
@Log4j
@RequestMapping("/byReply/")
@AllArgsConstructor
public class ReplyController {
	private ReplyService replySerivce;
	
	@DeleteMapping(value = "{byrno}",produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> delete(@PathVariable("byrno") int byrno) {
		log.info("delete()..................");
		return replySerivce.remove(byrno)  ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@RequestMapping(value = "{byrno}", method = {RequestMethod.PUT, RequestMethod.PATCH}, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody ReplyVO rvo, @PathVariable("byrno") int byrno) {
		log.info("modify()..................");
		return replySerivce.modify(rvo)  ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "{byrno}")
	public ResponseEntity<ReplyVO> view(@PathVariable("byrno") int byrno) {
		log.info("view()..................");
		return new ResponseEntity<ReplyVO>(replySerivce.view(byrno), HttpStatus.OK);
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "add", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> add(@RequestBody ReplyVO rvo) {
		log.info("add()..................");
		return replySerivce.add(rvo)  ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "pages/{byno}/{pageNum}")
	public ResponseEntity<ReplyPageDTO> list(@PathVariable("byno") int byno, @PathVariable("pageNum") int pageNum) {
		log.info("list()..................");
		Criteria cri = new Criteria(3, pageNum);
		return new ResponseEntity<ReplyPageDTO>(replySerivce.list(byno, cri), HttpStatus.OK);
	}

	

}