package org.medipaw.controller;

import java.util.List;

import org.medipaw.domain.PetMapVO;
import org.medipaw.service.PetMapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
@Controller
@RequiredArgsConstructor
public class PetMapController {
	@Autowired
    private PetMapService petMapService;
	

	 @GetMapping("/petmap")
	 public String showPetMap(Model model) {
	     List<PetMapVO> petmap = petMapService.getPetMap();
	     model.addAttribute("petmap", petmap);
	     model.addAttribute("isList", true);
	     return "/map/petMap";
	 }
	 

	 @GetMapping("/petmap/info")
	 @ResponseBody
	 public PetMapVO infoPetMap(@RequestParam("lat") Double lcLa, @RequestParam("lng") Double lcLo, Model model) {
	     PetMapVO petmapData = petMapService.getPetMapInfo(lcLa, lcLo);
	     System.out.println(petmapData);
	     return petmapData;
	 }
}