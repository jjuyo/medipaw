package org.medipaw.controller;

import java.util.List;

import org.medipaw.domain.FaqVO;
import org.medipaw.service.FaqService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/delete/{faqNo}")
	public String deleteFaq(@PathVariable int faqNo, RedirectAttributes rttr) {
	    log.info("delete......");

	    if (faqService.deleteFaq(faqNo)) { 
	        rttr.addFlashAttribute("successMessage", "FAQ successfully deleted.");
	        return "redirect:/faq/list"; // 성공시 FAQ 리스트 페이지로 이동합니다.
	    } else {
	        rttr.addFlashAttribute("errorMessage", "Failed to delete FAQ.");
	        return "redirect:/faq/list"; // 실패시 같은 페이지에 머무릅니다.
	    }
	}
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping("/update")
    public ResponseEntity<String> updateFaq(@RequestBody FaqVO fvo) {
        return faqService.updateFaq(fvo) 
                    ? new ResponseEntity<>("success", HttpStatus.OK)
                    : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping("/add")
    public String addFaq(@RequestBody FaqVO fvo, RedirectAttributes rttr) {
        log.info("register......");

        if (faqService.addFaq(fvo)) { 
            rttr.addFlashAttribute("successMessage", "FAQ successfully registered.");
            return "redirect:/faq/list"; // 성공시 FAQ 리스트 페이지로 이동합니다.
        } else {
            rttr.addFlashAttribute("errorMessage", "Failed to register FAQ.");
            return "redirect:/faq/list"; // 실패시 등록 페이지로 돌아갑니다.
        }
    }
}