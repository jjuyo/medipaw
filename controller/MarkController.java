package org.medipaw.controller;

import java.security.Principal;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.MarkVO;
import org.medipaw.domain.PageDTO;
import org.medipaw.service.MarkService;
import org.springframework.security.access.prepost.PreAuthorize;
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
@RequestMapping("/mark/*")
@AllArgsConstructor
public class MarkController {
	private MarkService mService;
	
	@PostMapping("register")	
	@PreAuthorize("isAuthenticated()")
	public String register(MarkVO mvo, RedirectAttributes rttr) {		
		log.info("mark register Controller");
		if(mService.register(mvo)) {
			rttr.addFlashAttribute("result", "successR");
		}
		rttr.addAttribute("id", mvo.getId());
		return "redirect:/mark/list";
	}
	
	@PostMapping("remove")
	@PreAuthorize("isAuthenticated()")
	public String remove(int mno, String id, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// BoardControllerTests에서 돌려보기
		log.info("mark remove Controller..." + mno);
		
		if(mService.remove(mno)) {
			rttr.addFlashAttribute("result", "successD");
		}
		rttr.addAttribute("amount", cri.getAmount());	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("id", id);
		rttr.addAttribute("mno", mno);
		return "redirect:/mark/list";
	}
	
	@GetMapping("list")		
	@PreAuthorize("isAuthenticated()")
	public void list(Principal p, Model model, Criteria cri) {		
		log.info("mark list Controller..." + cri);
		String id = p.getName();
		model.addAttribute("pageDTO", new PageDTO(cri, mService.totalCount(id, cri)));
		
		if("H".equals(cri.getType())) {			// 병원 가나다순으로 정렬 시 listHos 보내기
			model.addAttribute("list", mService.listHos(id, cri));
		} else {								// 등록 최신순이거나 기본 페이지는 listMno 보내기
			model.addAttribute("list", mService.listMno(id, cri));
		}
	}
	
}
