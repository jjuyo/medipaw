package org.medipaw.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

import org.medipaw.domain.BoonyangAttachVO;
import org.medipaw.domain.BoonyangVO;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.service.BoonyangService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/boonyang/*")
@AllArgsConstructor
public class BoonyangController {
	private BoonyangService byService;

	// 첨부 파일 삭제
	public void deleteFiles(String byImg) {
	    log.info("delete file...");
	    if (byImg != null) {
	        Path file = Paths.get("c:\\upload\\" + byImg);
	        try {
	            Files.deleteIfExists(file);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	}

	// 파일 삭제
	@PostMapping("/deleteFile")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("delete file: " + fileName);
		try {
			File file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();

			if (type.equals("image")) {
				String originFile = file.getAbsolutePath().replace("s_", "");
				file = new File(originFile);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	@GetMapping("list")
	public void list(Model model, Criteria cri) {
		log.info("list().................." + cri);
		model.addAttribute("list", byService.pageList(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, byService.totalCount(cri)));
	}
	@GetMapping("myList")
	@PreAuthorize("isAuthenticated()")
	public void myList(Principal principal, Model model, Criteria cri) {
		log.info("mylist().................." + cri);
		String id = principal.getName();
		model.addAttribute("myList", byService.myList(id,cri));
		model.addAttribute("pageDTO", new PageDTO(cri, byService.mytotalCount(id,cri)));
	}

	@GetMapping("write")
	@PreAuthorize("isAuthenticated()")
	public void write() {
		log.info("write()..................");
	
	}

	@PostMapping("write")
	@PreAuthorize("isAuthenticated()")
	public String write(BoonyangVO bvo, RedirectAttributes rttr) {
		log.info("write()..................");
		if (byService.register(bvo)) {
			//log.info(bvo.getByno());
			rttr.addFlashAttribute("result", "게시물 등록이 완료되었습니다.");
		}
		return "redirect:/boonyang/list"; // 목록으로 가야되니까 void 아니고 String으로 리턴값 주기
	}

	@GetMapping({ "view", "modify" })
	public void view(int byno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("view or modify...");
		model.addAttribute("bvo", byService.view(byno));
	}
	@PreAuthorize("principal.username == #id || principal.username == 'admin11'")
	@PostMapping("modify")
	public String modify(String id, @RequestParam("byno") int byno, BoonyangVO bvo, RedirectAttributes rttr,  Criteria cri) {
		log.info("modify()..................");
		if (byService.modify(bvo)) {
			rttr.addFlashAttribute("result", "게시물 수정이 완료되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("byno", byno);
		return "redirect:/boonyang/view"; // 목록으로 가야되니까 void 아니고 String으로 리턴값 주기
	}
	@PreAuthorize("principal.username == #id || principal.username == 'admin11'")
	@PostMapping("remove")
	public String remove(String id, @RequestParam("byno") int byno, RedirectAttributes rttr, Criteria cri) {
		log.info("remove()..................");
		List<BoonyangAttachVO> attachList = byService.attachList(byno);
		if (byService.remove(byno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "게시물 삭제가 완료되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/boonyang/list"; // 목록으로 가야되니까 void 아니고 String으로 리턴값 주기
	}
	
	// 첨부파일 목록 가져오기
		@GetMapping("getAttachList")
		public ResponseEntity<List<BoonyangAttachVO>> getAttachList(int byno) {
			log.info("getAttachList...");
			return new ResponseEntity<>(byService.attachList(byno), HttpStatus.OK);
		}

	// 첨부파일 업로드 폴더에서 삭제
	public void deleteFiles(List<BoonyangAttachVO> attachList) {
		log.info("delete files...");
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(bavo -> {
			Path file = Paths.get("c:\\upload\\" + bavo.getUpFolder() + "\\" + bavo.getUuid() +
						"_" + bavo.getFileName());						// file에 경로를 담음
			
			try {
				Files.deleteIfExists(file);								// file이 존재하면 삭제
				if(Files.probeContentType(file).startsWith("image")) {	// image인 경우
					Path thumbnail = Paths.get("c:\\upload\\" + bavo.getUpFolder() + "\\s_" + bavo.getUuid() +
									 "_" + bavo.getFileName());		// thumbnail에 썸네일의 경로를 담음
					Files.deleteIfExists(thumbnail);					// thumbnail 존재하면 삭제
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}
}
