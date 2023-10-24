package org.medipaw.controller;

import java.util.List;

import org.medipaw.domain.FaqVO;
import org.medipaw.service.FaqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/faq/*")
@AllArgsConstructor
public class FaqController {
	
	private final FaqService faqService; 

	@GetMapping("list")
	public String list(Model model) {
        List<FaqVO> faqs = faqService.getFaqs();

		log.info("list......");
		model.addAttribute("faqs", faqs);
		return "/faq/list"; // FAQ 리스트 페이지로 이동합니다.
	}

	@PreAuthorize("principal.username == #writer")
	@PostMapping("remove")
	public String remove(@RequestParam("faqNO") int faqNO, RedirectAttributes rttr) {
		log.info("remove......");
		
		if (faqService.remove(faqNO)) { 
			rttr.addFlashAttribute("successMessage", "FAQ successfully removed.");
			return "redirect:/faq/list";
        } else {
            rttr.addFlashAttribute("errorMessage", "Failed to remove FAQ.");
            return "redirect:/faq/list"; // 실패시 FAQ 리스트 페이지로 이동합니다.
        }
    }

    @PreAuthorize("principal.username == #bvo.writer")
    @PostMapping("/modify")
    public String modify(FaqVO fvo, RedirectAttributes rttr) {
        log.info("modify......");

        if (faqService.modify(fvo)) { 
            rttr.addFlashAttribute("successMessage", "FAQ successfully modified.");
            return "redirect:/faq/list"; // 성공시 FAQ 리스트 페이지로 이동합니다.
        } else {
            rttr.addFlashAttribute("errorMessage", "Failed to modify FAQ.");
            return "redirect:/faq/modify?no=" + fvo.getFaqNo(); // 실패시 수정 페이지로 돌아갑니다.
        }
    }

    @PostMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public String register(FaqVO fvo, RedirectAttributes rttr) {
        log.info("register......");

        if (faqService.register(fvo)) { 
            rttr.addFlashAttribute("successMessage", "FAQ successfully registered.");
            return "redirect:/faq/list"; // 성공시 FAQ 리스트 페이지로 이동합니다.
        } else {
            rttr.addFlashAttribute("errorMessage", "Failed to register FAQ.");
            return "redirect:/faq/register"; // 실패시 등록 페이지로 돌아갑니다.
        }
    }
}