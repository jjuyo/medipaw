package org.medipaw.controller;

import java.security.Principal;
import java.util.Collections;
import java.util.List;

import org.medipaw.domain.LikesVO;
import org.medipaw.domain.PetMapVO;
import org.medipaw.service.LikesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
@RequestMapping("/like/*")
public class LikesController {

    @Autowired
    private LikesService likesService;

    @PostMapping("/add")
    public ResponseEntity<?> addLike(LikesVO like, Principal principal) {
        if (principal == null) {
            // 로그인하지 않았을 경우
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).contentType(MediaType.APPLICATION_JSON_UTF8).body("찜하기는 로그인 후 이용 가능합니다.");
        }

        String id = principal.getName();
        like.setId(id);
        System.out.println(like);
        likesService.addLike(like);
        return ResponseEntity.ok().body(Collections.singletonMap("message", "Added like")); // JSON 응답 반환
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeLike(Principal principal, @RequestParam("placeNo") String placeNo) {
        String id = principal.getName();

    	likesService.removeLike(placeNo, id);
        return ResponseEntity.ok().body(Collections.singletonMap("message", "Removed like")); // JSON 응답 반환
    }
    
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/mypetmap")
    public String myPetMap(Principal principal, Model model) {
        String id = principal.getName();
        System.out.println(id);
        List<PetMapVO> userLikes = likesService.getUserLikes(id);
        System.out.println(userLikes);
        model.addAttribute("userLikes", userLikes);
        return "map/myPetMap";
    }
    
    
    @GetMapping("/likes")
    @ResponseBody
    public List<String> getLikedPlaces(Principal principal) {
        if (principal == null) {
            // 로그인하지 않았을 경우
            return Collections.emptyList();
        }

        String id = principal.getName();
        return likesService.getLikedPlaces(id);
    }
}