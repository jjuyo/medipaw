package org.medipaw.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.domain.SiljongAttachVO;
import org.medipaw.domain.SiljongVO;
import org.medipaw.service.SiljongService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/siljong/*")
@AllArgsConstructor
public class SiljongController {
	private SiljongService sjService;
	
	@PostMapping("register")
	@PreAuthorize("isAuthenticated()")
	public String register(SiljongVO sjvo, RedirectAttributes rttr) {	
		log.info("siljong register Controller...");
		
		if(sjvo.getAttachList() != null) {								// 첨부파일 들어가는 list log로 보기
			sjvo.getAttachList().forEach(attach -> log.info(attach));
		}
		
		if(sjService.register(sjvo)) {
			rttr.addFlashAttribute("result", "successR");
		}
		return "redirect:/siljong/list";
	}
	
	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("siljong register.jsp...");
	}
	
	@GetMapping({"view", "modify"})		// 원래는 view 컨트롤러였는데 수정하기 전에 수정 폼에서 view처리 해야하므로 묶음
	public void view(Model model, int sjno, Authentication auth, @ModelAttribute("cri") Criteria cri) {	// cri를 view.jsp로 넘겨야함
		log.info("siljong view Controller....");
		
	    String currentUserId = auth.getName();				// 현재 로그인한 사용자의 id
	    String postUserId = sjService.view(sjno).getId();	// 게시물의 작성자 id
	    
	    // 현재 로그인한 사용자와 게시물 작성자 id 비교
	    if (!currentUserId.equals(postUserId)) {
	        sjService.updateHit(sjno); // 조회수 업데이트
	    }
		model.addAttribute("view", sjService.view(sjno));
	}
	
	@PostMapping("modify")
	public String modify(SiljongVO sjvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// BoardControllerTests에서 돌려보기
		log.info("siljong modify Controller...");
		
		if(sjService.modify(sjvo)) {
			rttr.addFlashAttribute("result", "successM");	
		};
		// redirect는 reponse 객체 사용하는데 @ModelAttribute는 request 객체를 사용해서 결과 페이지까지 못 감
		// 그래서 rttr 사용해서 attribute에 담아서 보냄
		rttr.addAttribute("amount", cri.getAmount());	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("sjno", sjvo.getSjno());
		
		return "redirect:/siljong/view";
	}
	
	@PostMapping("remove")
	public String remove(String writer, int sjno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// BoardControllerTests에서 돌려보기
		log.info("siljong remove Controller...");	// 추후에 writer 대신 id 넣고 권한 체크하기
		
		List<SiljongAttachVO> attachList = sjService.attachList(sjno);  // 해당 게시글의 첨부 파일 목록 가져오기
		
		if(sjService.remove(sjno)) {
			deleteFiles(attachList);									// 첨부 파일 삭제 메서드 호출
			rttr.addFlashAttribute("result", "successD");
		}
		rttr.addAttribute("amount", cri.getAmount());	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/siljong/list";
	}
	
	@GetMapping("list")					
	public void list(Model model, Criteria cri) {	
		log.info("siljong list Controller..." + cri);
		model.addAttribute("pageDTO", new PageDTO(cri, sjService.totalCount(cri)));
		model.addAttribute("list", sjService.listPaging(cri));
	}
	
	@GetMapping("mine")					
	public void mine(Model model, Principal p, Criteria cri) {	
		log.info("mine list Controller..." + cri);
		String id = p.getName();
		model.addAttribute("pageDTO", new PageDTO(cri, sjService.totalCountMine(id, cri)));
		model.addAttribute("list", sjService.listMine(id, cri));
	}
	
	// 첨부파일 목록 가져오기
	@GetMapping("getAttachList")
	public ResponseEntity<List<SiljongAttachVO>> getAttachList(int sjno) {
		log.info("getAttachList...");
		return new ResponseEntity<>(sjService.attachList(sjno), HttpStatus.OK);
	}

	// 첨부파일 업로드 폴더에서 삭제
	public void deleteFiles(List<SiljongAttachVO> attachList) {
		log.info("delete files...");
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(satvo -> {
			Path file = Paths.get("c:\\upload\\" + satvo.getUpFolder() + "\\" + satvo.getUuid() +
						"_" + satvo.getFileName());						// file에 경로를 담음
			
			try {
				Files.deleteIfExists(file);								// file이 존재하면 삭제
				if(Files.probeContentType(file).startsWith("image")) {	// image인 경우
					Path thumbnail = Paths.get("c:\\upload\\" + satvo.getUpFolder() + "\\s_" + satvo.getUuid() +
									 "_" + satvo.getFileName());		// thumbnail에 썸네일의 경로를 담음
					Files.deleteIfExists(thumbnail);					// thumbnail 존재하면 삭제
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}
}
