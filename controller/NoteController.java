package org.medipaw.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import org.medipaw.domain.PageDTO;
import org.medipaw.mapper.NoteMapper;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.medipaw.domain.Criteria;
import org.medipaw.domain.NoteVO;
import org.medipaw.service.NoteService;

@Controller
@RequestMapping("/note/*")
public class NoteController {
    private final NoteService noteService;
    private final NoteMapper noteMapper;

    public NoteController(NoteService noteService, NoteMapper noteMapper) {
        this.noteService = noteService;
		this.noteMapper = noteMapper;
    }

    @GetMapping("selectRecp")
    public String selectResp(Model model, Criteria cri,Principal p) {
        String id = p.getName();
        int totalCount1 = noteService.totalCount1(id);      
    	model.addAttribute("list", noteMapper.selectRecp(id,cri));
        model.addAttribute("pageDTO", new PageDTO(cri, totalCount1));       
        return "note/list";
    }

    @GetMapping("selectSend")
    public String selectSend(Model model, Criteria cri,Principal p) {
        String id = p.getName();
        int totalCount2 = noteService.totalCount2(id);      
    	model.addAttribute("list", noteMapper.selectSend(id,cri));
        model.addAttribute("pageDTO", new PageDTO(cri, totalCount2));       
        return "note/list";
    } 
    
    @GetMapping("selectSave")
    public String selectSave(Model model, Criteria cri,Principal p) {
        String id = p.getName();
        int totalCount3 = noteService.totalCount3(id);      
    	model.addAttribute("list", noteMapper.selectSave(id,cri));
        model.addAttribute("pageDTO", new PageDTO(cri, totalCount3));       
        return "note/list";
    } 

    
    @GetMapping("view")
    public void view(int nno, Model model) {
    	System.out.println("view 작동");
        model.addAttribute("nvo", noteService.view(nno));
    }
    
    @GetMapping("send")
    public String sendNote(@RequestParam("userId") String userId, Model model) {
    	System.out.println("send 실행");
        model.addAttribute("userId", userId);
        return "/note/send";
    }

    @GetMapping("resend")
    public String resendNote(@RequestParam("bno") int note_no,@RequestParam("userId") String userId, Model model,@RequestParam("title") String title) {
    	System.out.println("resend 실행" + note_no + userId);
        model.addAttribute("userId", userId);
        model.addAttribute("note_no", note_no);
        model.addAttribute("note_title", title);
        return "/note/send";
    }

	@PostMapping(value = "register")
	public ResponseEntity<String> insert(@ModelAttribute NoteVO nvo, Principal p) {
	    String id = p.getName();
	    nvo.setNote_sender(id);
	    System.out.println("note_register 실행");
	    if (noteService.register(nvo)) { 
	        return new ResponseEntity<>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	@GetMapping(value = "noteSave")
	@ResponseBody
	public ResponseEntity<String> noteSave(@ModelAttribute NoteVO nvo, Principal p) {
	    String id = p.getName();
	    nvo.setId(id);
	    System.out.println(nvo.getNote_no());
	    System.out.println(nvo.getId());	    
	    boolean result = noteMapper.updateSave(nvo);
	    if (result) {
	        return new ResponseEntity<>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@GetMapping(value = "noteUnSave")
	@ResponseBody
	public ResponseEntity<String> noteUnSave(@ModelAttribute NoteVO nvo, Principal p) {
	    String id = p.getName();
	    nvo.setId(id);
	    System.out.println("unsave 실행");
	    boolean result = noteMapper.unSave(nvo);
	    if (result) {
	        return new ResponseEntity<>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@GetMapping(value = "noteCheck")
	@ResponseBody
	public ResponseEntity<String> noteCheck(@ModelAttribute NoteVO nvo, Principal p) {
	    String id = p.getName();
	    nvo.setId(id);
	    System.out.println("note check 실행");
	    boolean result = noteMapper.noteCheck(nvo);
	    if (result) {
	        return new ResponseEntity<>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@GetMapping(value = "noteDelete")
	@ResponseBody
	public ResponseEntity<String> noteDelete(@ModelAttribute NoteVO nvo, Principal p) {
	    String id = p.getName();
	    nvo.setId(id);
	    System.out.println("Delete 실행");
	    boolean result = noteMapper.noteDelete(nvo);
	    if (result) {
	        return new ResponseEntity<>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@GetMapping("/note/getNewNotes")
	public void getNewNotes(Model model, Principal p, HttpServletResponse response) {
	    String id = p.getName();
	    List<NoteVO> notes = noteMapper.getNewNotes(id);
	    model.addAttribute("notes", notes);
	    
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    
	    try {
	        PrintWriter out = response.getWriter();
	        out.print(new Gson().toJson(notes));
	        out.flush();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
}