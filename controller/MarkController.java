package org.medipaw.controller;

import java.security.Principal;
import java.util.Map;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.MarkVO;
import org.medipaw.domain.PageDTO;
import org.medipaw.mapper.MarkMapper;
import org.medipaw.service.MarkService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mark/*")
@AllArgsConstructor
public class MarkController {
	private MarkService mService;
	private MarkMapper mMapper;
	
	@PostMapping("register")	
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String register(@RequestBody MarkVO mvo, RedirectAttributes rttr) {		
		log.info("mark register Controller");
		System.out.println(mvo.getId());
		System.out.println(mvo.getAnimalhosp_no());
		if(mService.register(mvo)) {
			rttr.addFlashAttribute("result", "successR");
		}
		rttr.addAttribute("id", mvo.getId());
		return "redirect:/mark/list";
	}
	
	@GetMapping("markCnt")
	@ResponseBody
	public int markCnt(Principal p, @RequestParam("animalhosp_no") int animalhosp_no) {
		String id = p.getName();
	    System.out.println(id + animalhosp_no); 
	    int count = mMapper.select(id,animalhosp_no);
	    System.out.println(count);
	    return count;
	}
	
	@PostMapping("remove")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String remove(@RequestBody MarkVO mvo, RedirectAttributes rttr) {		
		log.info("mark register Controller");
		System.out.println(mvo.getId());
		System.out.println(mvo.getAnimalhosp_no());
		if(mService.remove(mvo)) {
			rttr.addFlashAttribute("result", "successR");
		}
		rttr.addAttribute("id", mvo.getId());
		return "redirect:/mark/list";
	}
	
	@GetMapping("list")		
	@PreAuthorize("isAuthenticated()")
	public void list(Principal p, Model model, Criteria cri) {		
		log.info("mark list Controller..." + cri);
		String id = p.getName();
		model.addAttribute("pageDTO", new PageDTO(cri, mService.totalCount(id, cri)));	
		if("H".equals(cri.getType())) {	
			model.addAttribute("list", mService.listHos(id, cri));
		} else {						
			model.addAttribute("list", mService.listMno(id, cri));
		}
	}	
}
