package org.medipaw.controller;

import java.security.Principal;
import java.util.List;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.domain.ReservVO;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/reserv/*")
@AllArgsConstructor
public class ReservController {
	private ReservService rService;
	private TreatService trService;
	
	@PostMapping("duplTime")	// 예약 중복처리
	@ResponseBody			 	// JSON 응답을 지정
	public List<String> duplTime(@RequestParam("rvDate") String rvDate, @RequestParam("hno") int hno) {
	    log.info("예약된 시간 조회 컨트롤러");
	    return rService.duplRvTime(rvDate, hno);
	}
	
	@PostMapping("register")	
	@PreAuthorize("isAuthenticated()")
	public String register(ReservVO rvvo, String id, RedirectAttributes rttr) {		
		log.info("registerController...");
		
		if(rService.register(rvvo)) {
			rttr.addFlashAttribute("result", "successR");
		} else {
			rttr.addFlashAttribute("result", "fail");
		}
		rttr.addAttribute("id", id);
		return "redirect:/reserv/listUser";
	}
	
	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")
	public void register(@RequestParam("hno") int hno) {
		log.info("register.jsp...");
	}
	
	@GetMapping({"view", "modify"})		// 원래는 view 컨트롤러였는데 수정하기 전에 수정 폼에서 view처리 해야하므로 묶음
	public void view(Model model, int rvno, @ModelAttribute("cri") Criteria cri) {	// cri를 view.jsp로 넘겨야함
		log.info("viewController....");
		model.addAttribute("treatCnt", trService.treatCnt(rvno));
		model.addAttribute("view", rService.view(rvno));
	}
	
	@PostMapping("modify")
	public String modify(ReservVO rvvo, String id, String sid, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// BoardControllerTests에서 돌려보기
		log.info("modifyController...");
		
		if(rService.modify(rvvo)) {
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
		rttr.addAttribute("rvno", rvvo.getRvno());
		rttr.addAttribute("id", id);
		rttr.addAttribute("sid", sid);
		
		return "redirect:/reserv/view";
	}
	
	@PostMapping("remove")
	public String remove(int rvno, String id, String sid, Authentication auth, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// BoardControllerTests에서 돌려보기
		log.info("removeController...");
		
		if(rService.remove(rvno)) {
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
		
		if (auth.getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_MEMBER"))) {
		    return "redirect:/reserv/listUser";
		} else if (auth.getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_STAFF"))) {
		    return "redirect:/reserv/listStaff";
		} else {
			return "redirect:/reserv/listAdm"; // 권한에 따라 리다이렉트하는 경로 정해주기
		}
	}
	
	@GetMapping("listUser")	
	@Secured("ROLE_MEMBER")
	public void listUser(Model model, Principal p, Criteria cri) {
		String id = p.getName();
		log.info("listUserController... id : " + id +" / "+ cri);
		model.addAttribute("pageDTOUser", new PageDTO(cri, rService.totalCountUser(id, cri)));
		model.addAttribute("listUser", rService.listPagingUser(id, cri));
	}
	
	@GetMapping("listStaff")	
	@Secured("ROLE_STAFF")
	public void listStaff(Model model, String sid, Criteria cri) {		
		log.info("listStaffController..." + cri);
		model.addAttribute("pageDTOStaff", new PageDTO(cri, rService.totalCountStaff(sid, cri)));
		model.addAttribute("listStaff", rService.listPagingStaff(sid, cri));
	}
	
	@GetMapping("listAdm")
	@Secured("ROLE_ADMIN")
	public void listAdm(Model model, Criteria cri) {		
		log.info("listAdmController..." + cri);
		model.addAttribute("pageDTOAdm", new PageDTO(cri, rService.totalCountAdm(cri)));
		model.addAttribute("listAdm", rService.listPagingAdm(cri));
	}
	
}
