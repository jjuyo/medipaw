package org.medipaw.controller;

import java.security.Principal;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.domain.TreatVO;
import org.medipaw.service.ReservService;
import org.medipaw.service.TreatService;
import org.springframework.security.access.annotation.Secured;
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
@RequestMapping("/treat/*")
@AllArgsConstructor
public class TreatController {
	private TreatService trService;
	private ReservService rvService;			
	
	@PostMapping("register")	
	@Secured("ROLE_STAFF")
	public String register(TreatVO tvo, String sid, RedirectAttributes rttr) {		
		log.info("registerController...");
		if(trService.treatCnt(tvo.getRvno()) <= 0) {		// 하나의 예약 정보에 대해 진료 기록이 없으면 등록하기
			if(trService.register(tvo)) {
				rttr.addFlashAttribute("result", "successR");
			} else {
				rttr.addFlashAttribute("result", "fail");
			}
		} else {											// 진료 기록이 있다면 result에 full 보내기
			rttr.addFlashAttribute("result", "full");
		}
		
		rttr.addAttribute("hno", tvo.getHno());
		rttr.addAttribute("sid", sid);
		
		return "redirect:/treat/listStaff";
	}
	
	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")
	public void register(Model model, int rvno) {
		log.info("register.jsp...");
		model.addAttribute("reservView", rvService.view(rvno));
	}
	
	@GetMapping({"view", "modify"})		
	public void view(Model model, int tno, @ModelAttribute("cri") Criteria cri) {	// cri를 view.jsp로 넘겨야함
		log.info("viewController....");
		model.addAttribute("view", trService.view(tno));
	}
	
	@PostMapping("modify")
	public String modify(TreatVO tvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		
		log.info("modifyController...");
		
		if(trService.modify(tvo)) {
			rttr.addFlashAttribute("result", "successM");	// modify가 성공적으로 되면 result에 success 담아서 보내
		} else {
			rttr.addFlashAttribute("result", "fail");
		}
		// redirect는 reponse 객체 사용하는데 @ModelAttribute는 request 객체를 사용해서 결과 페이지까지 못 감
		// 그래서 rttr 사용해서 attribute에 담아서 보냄
		rttr.addAttribute("amount", cri.getAmount());	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("tno", tvo.getTno());
		
		return "redirect:/treat/view";
	}
	
	@PostMapping("remove")
	@PreAuthorize("hasRole('ROLE_STAFF') or hasRole('ROLE_ADMIN')")
	public String remove(int tno, String id, String sid, Authentication auth, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// BoardControllerTests에서 돌려보기
		log.info("removeController...");
		
		if(trService.remove(tno)) {
			rttr.addFlashAttribute("result", "successD");
		} else {
			rttr.addFlashAttribute("result", "fail");
		}
		rttr.addAttribute("amount", cri.getAmount());	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("id", id);
		rttr.addAttribute("sid", sid);
		
		if (auth.getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_STAFF"))) {
		    return "redirect:/treat/listStaff";
		}
		return "redirect:/treat/listAdm";
	}
	
	@GetMapping("listUser")
	@Secured("ROLE_MEMBER")
	public void listUser(Model model, Principal p, Criteria cri) {		
		String id = p.getName();
		log.info("listController..." + id + " / " + cri);
		model.addAttribute("pageDTOUser", new PageDTO(cri, trService.totalCountUser(id, cri)));
		model.addAttribute("listUser", trService.listPagingUser(id, cri));
	}
	
	@GetMapping("listStaff")
	@Secured("ROLE_STAFF")
	public void listStaff(Model model, String sid, Criteria cri) {		
		log.info("listController..." + cri);
		model.addAttribute("pageDTOStaff", new PageDTO(cri, trService.totalCountStaff(sid, cri)));
		model.addAttribute("listStaff", trService.listPagingStaff(sid, cri));
	}
	
	@GetMapping("listAdm")		
	@Secured("ROLE_ADMIN")
	public void listAdm(Model model, Criteria cri) {		
		log.info("listController..." + cri);
		model.addAttribute("pageDTOAdm", new PageDTO(cri, trService.totalCountAdm(cri)));
		model.addAttribute("listAdm", trService.listPagingAdm(cri));
	}
	
	@PostMapping("delCheck")	// 회원의 진료 정보 삭제(숨기기)
	public String delCheck(TreatVO tvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// BoardControllerTests에서 돌려보기
		log.info("removeController...");
		
		if(trService.updateDelCheck(tvo)) {
			rttr.addFlashAttribute("result", "successDC");
		} else {
			rttr.addFlashAttribute("result", "fail");
		}
		rttr.addAttribute("amount", cri.getAmount());	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("id", tvo.getId());
		
		return "redirect:/treat/listUser";
	}
	
}
