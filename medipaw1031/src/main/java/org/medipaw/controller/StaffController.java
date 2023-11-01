package org.medipaw.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.domain.StaffVO;
import org.medipaw.security.CustomUserDetailsService;
import org.medipaw.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class StaffController {
	private StaffService staffService;
	@Autowired
	private PasswordEncoder pwEncoder;
	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@GetMapping("/genStaff/login")
	public String login(String error, String logout, Model model) {
		log.info("login()..................");
		log.info("error: "+error);
		log.info("logout: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인 에러 - 계정을 확인해주세요.");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃이 완료되었습니다.");
		}
		return "/genStaff/login";
	}

	@GetMapping("/genStaff/findId")
	public void findId() {
	    log.info("findId()..................");
	}

	@PostMapping("/genStaff/findId")
	public String findId(@RequestParam("sname") String sname, @RequestParam("sphone") String sphone, RedirectAttributes rttr) {
	    log.info("findId()..................");
	    String foundId = staffService.findId(sname, sphone);

	    if (foundId != null) {
	        // 아이디를 찾았을 경우 모델에 저장
	        rttr.addFlashAttribute("foundId", foundId);
	    } else {
	        // 아이디를 찾지 못했을 경우 모델에 에러 메시지 저장
	    	rttr.addFlashAttribute("result", "일치하는 아이디를 찾을 수 없습니다.");
	        return "redirect:/genStaff/findId";
	    }

	    return "redirect:/genStaff/login";
	}
	@GetMapping("/genStaff/findPw")
	public void findPw() {
	    log.info("findPw()..................");
	}

	@PostMapping("/genStaff/findPw")
	public String findPw(@RequestParam("sname") String sname, @RequestParam("sid") String sid, @RequestParam("sphone") String sphone, RedirectAttributes rttr) {
	    log.info("findPw() post..................");
	    //이름, 연락처로 일치하는 회원정보가 있다면 비밀번호 재설정으로 이동
	    if (staffService.findPw(sid, sname, sphone)==1) {
	    	return "redirect:/genStaff/pwChange?sid="+sid;
	    }
	    else{
	    	rttr.addFlashAttribute("result", "일치하는 회원정보를 찾을 수 없습니다.");
	    	return "redirect:/genStaff/findPw";
	    }
	}
	@GetMapping("/genStaff/pwChange")
	public void pwChange() {
	    log.info("findPw()..................");
  
	}
	@PostMapping("/genStaff/pwChange")
	public String pwChange(@RequestParam("sid") String sid,@RequestParam("spw") String spw, Model model) {
	    log.info("pwChange()..................");
	    log.info(sid);
	    log.info(spw);
        String encodePw = "";
        encodePw = pwEncoder.encode(spw);
       
	    staffService.modifyPw(sid, encodePw);

	    return "redirect:/genStaff/login";
	}
	@GetMapping("/genStaff/join")
	public String register() {
		log.info("register() ..................");
		return "/genStaff/join";
	}
	
	@PostMapping("/genStaff/join")
	public String register(StaffVO svo, RedirectAttributes rttr) {
		log.info("register() post!!..................");
		String rawPw = "";
        String encodePw = "";

        rawPw = svo.getSpw();
        encodePw = pwEncoder.encode(rawPw);
        svo.setSpw(encodePw);
 
		
		if (staffService.register(svo)) {
			rttr.addFlashAttribute("result", svo.getSname());
		}
		return "redirect:/"; // 목록으로 가야되니까 void 아니고 String으로 리턴값 주기
	}
	// 첨부 파일 삭제
	public void deleteFile(String img) {
	    log.info("delete file...");
	    if (img != null) {
	        Path file = Paths.get("c:\\upload\\" + img);
	        try {
	            Files.deleteIfExists(file);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	}


	// 파일 삭제
	@PostMapping("/staff/deleteFile")
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
		return new ResponseEntity<String>("삭제했습니다.", HttpStatus.OK);
	}
	// 아이디 중복 검사
		@PostMapping(value = "/genStaff/idCheck")
		@ResponseBody
		public boolean idCheck(String sid) throws Exception{
			log.info("idCheck()...");	
			return staffService.idCheck(sid);
		} 
	

	//관리자 - 병원관계자 목록
	@GetMapping("/admin/staffList")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void list(Model model, Criteria cri) {
		log.info("list().................." + cri);
		log.info(staffService.totalCount(cri));
		model.addAttribute("list", staffService.pageList(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, staffService.totalCount(cri)));
	}
	@GetMapping("/admin/view")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void view(@RequestParam("sid") String sid, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("view ...");
		model.addAttribute("svo", staffService.view(sid));
	}
	@PreAuthorize("hasRole('ROLE_STAFF')")
	@GetMapping("/staff/view")
	public void view(Principal principal, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("view ...");
		String loginId = principal.getName();
		model.addAttribute("svo", staffService.view(loginId));
	}
	@PreAuthorize("hasAnyRole('ROLE_STAFF', 'ROLE_ADMIN')")
	@GetMapping("/staff/modify")
	public void modify(@RequestParam("sid") String sid, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("modify ...");

		model.addAttribute("svo", staffService.view(sid));
		
	}
	@PreAuthorize("hasAnyRole('ROLE_STAFF', 'ROLE_ADMIN')")
	@PostMapping("/staff/modify")
	public String modify(Principal principal, StaffVO svo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("modify()..................");
		String loginId = principal.getName();
		if (staffService.modify(svo)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		if ("admin11".equals(loginId)) {
			return "redirect:/admin/view?sid="+svo.getSid();
		}
		
		return "redirect:/staff/view"; // 목록으로 가야되니까 void 아니고 String으로 리턴값 주기
	}
	@PreAuthorize("hasRole('ROLE_STAFF')")
	@GetMapping("/staff/pwCheck")
	public void pwCheck() {
	    log.info("pwCheck()..................");
	  
	}
	@PreAuthorize("hasRole('ROLE_STAFF')")
	@PostMapping("/staff/pwCheck")
	public String pwCheck(Principal principal, @RequestParam("spw") String spw, RedirectAttributes rttr) {
	    log.info("pwCheck(). post.................");
	    
	    if (principal != null) {
	        String username = principal.getName(); // 현재 인증된 사용자의 이름(사용자 아이디)
	        
	        // 사용자의 이름(사용자 아이디)를 기반으로 UserDetails 객체를 가져옵니다.
	        UserDetails userDetails = customUserDetailsService.loadUserByUsername(username);
	        String encodedPassword = userDetails.getPassword(); // 데이터베이스에서 가져온 암호화된 비밀번호
	        
	        // 사용자가 입력한 비밀번호와 데이터베이스에서 가져온 비밀번호를 비교
	        boolean passwordMatches = pwEncoder.matches(spw, encodedPassword);

	        if (passwordMatches) {
	            return "redirect:/staff/pwUpdate?sid="+username; // 비밀번호 일치
	        }
	    }
	    
	    rttr.addFlashAttribute("result", "비밀번호가 올바르지 않습니다.");
	    return "redirect:/staff/pwCheck";
	}

	@PreAuthorize("hasRole('ROLE_STAFF')")
	@GetMapping("/staff/pwUpdate")
	public void pwUpdate() {
	    log.info("pwUpdate()..................");
	}
	@PreAuthorize("hasRole('ROLE_STAFF')")
	@PostMapping("/staff/pwUpdate")
	public String pwUpdate(@RequestParam("sid") String sid,@RequestParam("spw") String spw, Model model) {
	    log.info("pwUpdate()..................");
	    
		
        String encodePw = "";
        encodePw = pwEncoder.encode(spw);
	    staffService.modifyPw(sid, encodePw);
	 
	    return "redirect:/staff/view";
	}
	
	@PostMapping("/admin/removeByAdmin")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String removeByAdmin(String sid, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
	    log.info("removeByAdmin()..................");
	    staffService.remove(sid);
	    // 관리자가 삭제한 경우
	    rttr.addAttribute("pageNum", cri.getPageNum());
	    rttr.addAttribute("amount", cri.getAmount());
	    rttr.addAttribute("type", cri.getType());
	    rttr.addAttribute("keyword", cri.getKeyword());
	    rttr.addFlashAttribute("result", "계정을 삭제했습니다.");
	    return "redirect:/admin/staffList";
	}

	@PostMapping(value = "/staff/removeByStaff")
	@PreAuthorize("hasRole('ROLE_STAFF')")
	@ResponseBody
	public boolean removeByStaff(String sid) {
	    log.info("removeByStaff()..................");
	   
	    // 스태프가 삭제한 경우
	    SecurityContextHolder.clearContext();
	    return staffService.remove(sid);
	}
}