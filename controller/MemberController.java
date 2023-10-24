package org.medipaw.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.MemberVO;
import org.medipaw.domain.PageDTO;
import org.medipaw.member.MailUtils;
import org.medipaw.member.PasswordChangeRequest;
import org.medipaw.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/member/*")
public class MemberController {
	
	private final MemberService memberService;
	
	@RequestMapping(value = "join", method = RequestMethod.POST)
	@ResponseBody
	public String join(HttpServletRequest request, @RequestBody MemberVO memberVO) {
		
		memberService.join(memberVO);
		
		return "home";
	}
		
	@RequestMapping(value = "/terms", method = RequestMethod.GET)
	public String goTermsPage(HttpServletRequest request) {
		
		return "/member/terms";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String goJoinPage(HttpServletRequest request) {
		
		return "/member/join";
	}
	
	@GetMapping("/checkDuplication")
	@PreAuthorize("isAuthenticated()")
	public void checkDuplication() { }
	

	@PostMapping("/checkDuplication")
	public ResponseEntity<String> checkDuplication(@RequestParam("id") String id) {
	   return memberService.findById(id)
	           ? new ResponseEntity<>("success", HttpStatus.OK)
	           : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public String recoverId(HttpServletRequest request) {
		
		return "/member/findId";
		
		   
	}
	
	@PostMapping("/findId")
	public ResponseEntity<String> recoverId(@RequestParam("name") String name,
	                                        @RequestParam("phone") String phone) {
	    String memberId = memberService.findIdByFullNameAndPhone(name, phone);
	    
	    if (memberId != null) {
	        return new ResponseEntity<>(memberId, HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>("No matching user found", HttpStatus.NOT_FOUND);
	    }
	}
	
	@Autowired
	JavaMailSender mailSender ; 
	
	private String strRand ;
	
	@GetMapping(value = "/findpsw")
	public ModelAndView findpsw() {
		return new ModelAndView("/member/findpsw");
	}
	
	@PostMapping(value = "/findpsw")
	@ResponseBody
	public String findpsw_post(@RequestParam("id") String id,
            @RequestParam("email") String email , HttpServletRequest request) {
		   //랜덤한 숫자,문자를 합친 문자열을 전달받은 메일 주소로 보낸다.
	    System.out.println("####sendToEmail: "+ email);
	    Random rand = new Random();
	    strRand = "";
	    for (int i = 0; i < 6; i++) {
	        strRand += rand.nextInt(10);
	    }
	    request.getSession().setAttribute(id, strRand);
	    System.out.println("Generated code for user " + id + ": " + strRand);

	    
	    try {
	        MailUtils sendMail = new MailUtils(mailSender);
	        sendMail.setSubject("회원가입 이메일 인증");
	        String message = new StringBuffer()
	                .append("<h2>[Medipaw]비밀번호 재설정을 위한 인증번호</h2>")
	                .append("<h2>인증번호: ")
	                .append(strRand)
	                .append("</h2>")
	                .toString();
	        
	        sendMail.setText(message);
	        sendMail.setFrom("noreply@noreply.com", "Medipaw");
	        sendMail.setTo(email); // 'email' 변수 사용
	        sendMail.send();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return e.getMessage() ;
	    }
	    
	    return "success"; 
	}
	
	@PostMapping( value = "/checknum")
	@ResponseBody
	public ResponseEntity<String> checkNum(@RequestBody Map<String,String> map, HttpServletRequest request ) {
	    String checkNumClient = map.get("checknum");
	    String id = map.get("id");

	    // 세션에서 해당 id의 인증번호(strRand) 가져오기 
	    String sessionStrRand = (String)request.getSession().getAttribute(id);

	    System.out.println("Checking code for user " + id);
	    System.out.println("Code from client: " + checkNumClient);
	    System.out.println("Code from session: " + sessionStrRand);

	   if(checkNumClient.equals(sessionStrRand))
	       return new ResponseEntity<>("success", HttpStatus.OK);
	   
	   return new ResponseEntity<>("error", HttpStatus.BAD_REQUEST);  // 실패 시 'error' 문자열과 함께 400 Bad Request 상태 코드 반환
	}
	
	@PostMapping("/checkUser")
	   public ResponseEntity<String> checkUser(@RequestParam("id") String id,@RequestParam("email") String email) {
		 return memberService.checkUserExists(id, email)
		           ? new ResponseEntity<>("success", HttpStatus.OK)
		           : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    	
	   }
	
	@PostMapping("/member/resetPassword")
    public ResponseEntity<String> resetPassword(@RequestParam("id") String id,@RequestParam("newPassword") String newPassword) {
		 return memberService.resetPassword(id, newPassword)
		           ? new ResponseEntity<>("success", HttpStatus.OK)
		           : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    
    }
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/myPage")
    public String myPage(Principal principal, Model model) {
        String userId = principal.getName();

        MemberVO mvo = memberService.getMemberByUsername(userId);

        model.addAttribute("mvo", mvo);

        return "/member/myPage";
    }
    
   
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/update")
    @ResponseBody  // 추가: HTTP 응답 본문에 직접 데이터를 작성하기 위한 어노테이션
    public Map<String, String> updateUser(@RequestBody MemberVO mvo) {  // 변경: ResponseEntity -> Map<String, String>
        System.out.println("ID: " + mvo.getId());

        Map<String, String> result = new HashMap<>();
        if(memberService.updateUser(mvo)) {
            result.put("result", "success");
        } else {
            result.put("result", "fail");
        }
        
        return result;  // 변경: 리다이렉션 대신 결과 맵 반환
    }
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/updatePassword")
    public ResponseEntity<?> updatePassword(@RequestBody PasswordChangeRequest passwordChangeRequest) {
        try {
            boolean result = memberService.updatePassword(passwordChangeRequest);
            if (result) {
                return new ResponseEntity<>(HttpStatus.OK);
            } else {
                return new ResponseEntity<>("unmatch", HttpStatus.BAD_REQUEST);
            }
        } catch (Exception e) {
            return new ResponseEntity<>("패스워드 변경 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/delete")
    public ResponseEntity<?> deleteMember(@RequestBody MemberVO mvo, HttpServletRequest request) {
        boolean result = memberService.deleteMember(mvo.getId());
        if (result) {
            // If the current user is not an admin
            if (!request.isUserInRole("ROLE_ADMIN")) {
                // Clear the security context
                SecurityContextHolder.clearContext();

                // Invalidate HttpSession
                request.getSession().invalidate();
            }
            
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>("error", HttpStatus.BAD_REQUEST);
        }
    }
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping("list")
	public void list(Model model, Criteria cri) {
		log.info("list......" + cri);
		model.addAttribute("list", memberService.list(cri));
		int totalCount = memberService.totalCount(cri);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping("/view/{id}")
    public String view(@PathVariable("id") String userId, Model model) {
        System.out.println(userId);
    	MemberVO mvo = memberService.getMemberByUsername(userId); // Service layer method to fetch member by ID
        model.addAttribute("mvo", mvo);
        System.out.println(mvo.getId());
        System.out.println(mvo.getName());
        System.out.println(mvo.getEmail());
        
        return "/member/view"; // name of the JSP file (view.jsp)
    }
    
    @PostMapping("/temppw")
    public ResponseEntity<String> temporaryPassword(@RequestBody Map<String, String> data) {

        try {
            String id = data.get("id");

            // ID에 해당하는 회원 정보 가져오기
            MemberVO mvo = memberService.getMemberByUsername(id);
         
            // 임시 비밀번호 생성
            String tempPassword = memberService.generateTempPassword();
            
                boolean result = memberService.resetPassword(id,tempPassword );
                System.out.println(result);
                if (result) {  
                    MailUtils sendMail = new MailUtils(mailSender);
                    sendMail.setSubject("Medipaw Temporary Password");
                    String message = new StringBuffer()
                            .append("<h2>[Medipaw] 임시비밀번호 발급</h2>")
                            .append("<p> 임시비밀번호는 ")
                            .append(tempPassword)
                            .append("입니다")
                            .append("</p>")
                            .append("로그인 후 반드시 비밀번호를 변경해주세요")
                            .toString();
                    
                    sendMail.setText(message);
                    sendMail.setFrom("noreply@noreply.com", "Medipaw");
                    sendMail.setTo(mvo.getEmail()); 
                    sendMail.send();
                    return new ResponseEntity<>(HttpStatus.OK);
                } else {
                    return new ResponseEntity<>("unmatch", HttpStatus.BAD_REQUEST);
                }
        } catch (Exception e) {
           return new ResponseEntity<>("Error occurred while changing password: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
       }
    }
}
	
