package org.medipaw.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.medipaw.domain.AnimalHospVO;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.mapper.AnimalHospMapper;
import org.medipaw.service.AnimalHospService;

@Log4j
@AllArgsConstructor
@Controller
@RequestMapping("/animalhosp/*")
public class AnimalHospController {
	private AnimalHospService animalHospService;
	private AnimalHospMapper aMapper;

	@GetMapping("test")
	public String animalHosp() {
		System.out.println("test  ۵  Ȯ  ");
	    return "animalhosp/animalhosp";
	}
	
	@GetMapping("add")
	public String animalHospAdd() {
		System.out.println("add  ۵ Ȯ  ");
	    return "animalhosp/animalhospAdd";
	}
	
	@GetMapping("mod")
	public String animalHospMod() {
		System.out.println("mod  ۵ Ȯ  ");
	    return "animalhosp/animalhospMod";
	}	
	
	@GetMapping("/animalhospView")
	public String animalHospView(@RequestParam("animalhosp_no") int animalHospNo) {
	    System.out.println("View - animalHosNo: " + animalHospNo);
	    return "animalhosp/animalhospView";
	}
	
	@GetMapping("list")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> list(Criteria cri) {
		System.out.println("List");
	    List<AnimalHospVO> hospitalList = animalHospService.selectAllPaging(cri);
	    int totalCount = animalHospService.totalCount(cri);
	    PageDTO pageDTO = new PageDTO(cri, totalCount);
	    Map<String, Object> response = new HashMap<>();
	    response.put("hospitals", hospitalList);
	    response.put("pageMaker", pageDTO); // Add this line  
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	@GetMapping("view") //     ȸ
	@ResponseBody 
	public ResponseEntity<AnimalHospVO> view(@RequestParam("ano") int ano) {
	    System.out.println("view"+ano);
	    AnimalHospVO avo = animalHospService.select(ano);
	    return new ResponseEntity<>(avo, HttpStatus.OK);
	}
	
	@GetMapping("myview") //  ڽ           ȸ
	@ResponseBody 
	public ResponseEntity<AnimalHospVO> myview(@RequestParam("sid") String sid) {
	    System.out.println("myview" + sid);
	    AnimalHospVO avo = aMapper.Myview(sid);
	    if (avo != null) {
	        return new ResponseEntity<>(avo, HttpStatus.OK);
	    } else {
	        AnimalHospVO nullAvo = new AnimalHospVO();
	        nullAvo.setSid("NULL");
	        return new ResponseEntity<>(nullAvo, HttpStatus.OK);
	    }
	}
	
	@PostMapping("register")//   
	public String register(@ModelAttribute AnimalHospVO avo, RedirectAttributes rttr) {
		System.out.println("register  ۵ Ȯ  ");    
		System.out.println(avo.getSid());
	    if(animalHospService.register(avo)) {
	        rttr.addFlashAttribute("result", avo.getAnimalhosp_no());
	    }
	    return "home";
	}
	
	@PostMapping("modify")//    
	public String modify(@ModelAttribute AnimalHospVO avo, RedirectAttributes rttr,Principal p) {
		System.out.println("modify  ۵ Ȯ  ");    
		String sid = p.getName();
	    if(animalHospService.modify(avo)) {
	        rttr.addFlashAttribute("result", avo.getAnimalhosp_no());
	    }
	    return "home";
	}

  @GetMapping(value = "remove")//    
  public String remove(Principal p, RedirectAttributes rttr){
	  System.out.println("remove  ۵ Ȯ  ");
	  String sid = p.getName();
    if(animalHospService.remove(sid)){
       rttr.addFlashAttribute("result", "success");
    }
    return "home";
  }
  
  @GetMapping(value="selectbymap") //         ߽   ǥ        ȸ
  @ResponseBody
  public ResponseEntity<Map<String, Object>> selectByMap(Criteria cri,
                        @RequestParam double aLatitude,
                        @RequestParam double aHardness) {
      System.out.println("selectByMap     ");

      List<AnimalHospVO> searchResult = animalHospService.selectByMap(cri, aLatitude, aHardness);
      int totalCount = searchResult.size();
      PageDTO pageDTO = new PageDTO(cri, totalCount);
      Map<String, Object> response = new HashMap<>();
      response.put("hospitals", searchResult);
      response.put("pageMaker", pageDTO); 
      return new ResponseEntity<>(response, HttpStatus.OK);
  }
}
