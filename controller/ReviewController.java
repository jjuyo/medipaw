package org.medipaw.controller;

import java.security.Principal;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.domain.ReviewVO;
import org.medipaw.service.ReviewService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review/*")
@AllArgsConstructor
public class ReviewController {
	private ReviewService reviewService;
	@GetMapping("list")
	public void list(int animalhosp_no,  Model model,  Criteria cri) {
		log.info("list().................."+ animalhosp_no );
		reviewService.list(animalhosp_no, cri);
		
		model.addAttribute("list", reviewService.list(animalhosp_no, cri));
		model.addAttribute("pageDTO", new PageDTO(cri, reviewService.totalCount(animalhosp_no, cri)));
	}
	
	@GetMapping("myList")
	public void myList(Principal principal, Model model, Criteria cri) {
		log.info("myList().................." + cri);
		String id = principal.getName();
		model.addAttribute("list", reviewService.myList(id, cri));
		model.addAttribute("pageDTO", new PageDTO(cri, reviewService.mytotalCount(id,cri)));
	}
	
	@GetMapping("write")
	@PreAuthorize("isAuthenticated()")
	public String write() {
		log.info("write()..................");
		return "/review/write";
	}

	@PostMapping("write")
	@PreAuthorize("isAuthenticated()")
	public String write(ReviewVO rvo, RedirectAttributes rttr) {
		log.info("write()..................");
		if (reviewService.register(rvo)) {
			rttr.addFlashAttribute("result", "리뷰가 등록되었습니다.");
		}
		return "redirect:/review/list?animalhosp_no="+rvo.getAnimalhosp_no(); // 목록으로 가야되니까 void 아니고 String으로 리턴값 주기
	}

	@GetMapping("view")
	public void view(int rno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("view ...");
		model.addAttribute("rvo", reviewService.view(rno));
	}
	
	@GetMapping("modify")
	public void modify(int rno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("modify ...");
		model.addAttribute("rvo", reviewService.view(rno));
	}
	
	
	@PostMapping("modify")
	public String modify(ReviewVO rvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("modify()..................");
		if (reviewService.modify(rvo)) {
			rttr.addFlashAttribute("result", "리뷰가 수정되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/review/view?rno="+rvo.getRno();
	}

	@PostMapping("remove")
	public String remove(int rno, int animalhosp_no, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("remove()..................");
		if (reviewService.remove(rno)) {
			rttr.addFlashAttribute("result", "리뷰가 삭제되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/review/list?animalhosp_no="+animalhosp_no; // 목록으로 가야되니까 void 아니고 String으로 리턴값 주기
	}
	
	// 리뷰 중복 검사
			@PostMapping(value = "/review/tnoCheck")
			@ResponseBody
			public boolean tnoCheck(int tno) throws Exception{
				log.info("tnoCheck()...");	
				log.info(reviewService.tnoCheck(tno));
				return reviewService.tnoCheck(tno);
			} 
}