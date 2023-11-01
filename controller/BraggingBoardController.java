package org.medipaw.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.medipaw.domain.BraggingAttachFileDTO;
import org.medipaw.domain.BraggingBoardAttachVO;
import org.medipaw.domain.BraggingBoardVO;
import org.medipaw.domain.BraggingCriteria;
import org.medipaw.domain.ConnectingBraggingPageDTO;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.service.BraggingBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/bragging/*")
@AllArgsConstructor
public class BraggingBoardController {
	private BraggingBoardService braggingBoardService;
	
	
	
	//첨부 파일 삭제
		public void deleteFiles(List<BraggingBoardAttachVO> brAttachList) {
			log.info("delete files.....");
			
			if(brAttachList == null || brAttachList.size() == 0) {
				return;
			}
			
			brAttachList.forEach(bbavo -> {
				Path file = Paths.get("c:\\upload\\braggingUpload\\" + bbavo.getUploadPath() + "\\" +
													   bbavo.getUuid() + "_" +
													   bbavo.getFileName());
				try {
					Files.deleteIfExists(file);
					
					if(Files.probeContentType(file).startsWith("filetp")) { // ?
						Path thumbnail = Paths.get("c:\\upload\\braggingUpload\\" + 
												   bbavo.getUploadPath() + "\\s_" +
												   bbavo.getUuid() + "_" +
												   bbavo.getFileName());
						Files.deleteIfExists(thumbnail);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
		}
	
		@PostMapping("remove")
		@PreAuthorize("principal.username == #id or hasRole('ROLE_ADMIN')")
		public String remove(String id, int bno, RedirectAttributes rttr, 
			     			 @ModelAttribute("bcri") BraggingCriteria bcri) {
			log.info("remove...... bno : " + bno);
			
			List<BraggingBoardAttachVO> brAttachList = braggingBoardService.brAttachList(bno);
			
			if(braggingBoardService.remove(bno)) {
				log.info("remove ok");
				//deleteFiles(brAttachList); 첨부파일 삭제
				rttr.addFlashAttribute("result", "success");
			}

			rttr.addAttribute("type", bcri.getType());
			rttr.addAttribute("keyword", bcri.getKeyword());
			rttr.addAttribute("pageNum", bcri.getPageNum());
			rttr.addAttribute("amount", bcri.getAmount());
			return "redirect:/bragging/list";
		}
		
		@PostMapping("modify/{pathId}")
		@PreAuthorize("principal.username == #id")
		public String modify(@PathVariable("pathId") String id,BraggingBoardVO bbvo, HttpSession session,
		                     RedirectAttributes rttr,
		                     @ModelAttribute("bcri") BraggingCriteria bcri,
		                     @RequestParam("uploadedFiles") String uploadFile) {
		    log.info("modify......" + bbvo);

		    if (braggingBoardService.modify(bbvo)) {
		        log.info("service modify" + bbvo);
		        rttr.addFlashAttribute("result", "success");


		        // Parse the string into an array of file info objects
		        String[] fileInfos = uploadFile.split(",");

		        if (fileInfos != null) {
		            for (String fileInfo : fileInfos) {
		                String[] parts = fileInfo.split(":");
		                if(parts.length < 4){
		                    // log an error message and continue with the next fileInfo
		                    log.error("Invalid file info: " + fileInfo);
		                    continue;
		                }
		                BraggingAttachFileDTO badto = new BraggingAttachFileDTO();
		                badto.setUuid(parts[0]);
		                badto.setUploadPath(parts[1]);
		                badto.setFileName(parts[2]);
		                badto.setFileType(Boolean.parseBoolean(parts[3]));

		                // 각 첨부파일 정보의 bno 필드값을 수정된 게시글 번호로 설정
		                badto.setBno(bbvo.getBno());

		                // DB에 첨부파일 정보 저장 로직 추가 (예: braggingBoardService.saveFile(badto);)
		            }
		            // 처리 완료 후 세션에서 첨부파일 정보 제거
		            session.removeAttribute("uploadedFiles");
		        }
		    }

		    rttr.addAttribute("type", bcri.getType());
		    rttr.addAttribute("keyword", bcri.getKeyword());
		    rttr.addAttribute("pageNum", bcri.getPageNum());
		    rttr.addAttribute("amount", bcri.getAmount());

		    return "redirect:/bragging/list";
		}

		@GetMapping(value="brAttachList")
		public ResponseEntity<List<BraggingBoardAttachVO>> brAttachList(int bno){
			log.info("brAttachList........." + bno);
			
			return new ResponseEntity<>(braggingBoardService.brAttachList(bno), 
										HttpStatus.OK);
		}
		
		@GetMapping("list")
		public void list(Model model, BraggingCriteria bcri) {
		    log.info("list......" + bcri);
		    List<BraggingBoardVO> list = braggingBoardService.list(bcri);

		    Date now = new Date();
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		    String today = dateFormat.format(now);

		    for (BraggingBoardVO bbvo : list) {
		        String regDateStr = dateFormat.format(bbvo.getRegDate());
		        if (regDateStr.equals(today)) {
		            // 오늘 올라온 게시글이라면 HH:mm 로 표시
		            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
		            bbvo.setDisplayDate(timeFormat.format(bbvo.getRegDate()));
		        } else {
		            // 오늘이 아니면 yyyy-mm-dd 로 표시
		            bbvo.setDisplayDate(regDateStr);
		        }
		    }

		    model.addAttribute("list", list);
		    
		    int totalCount = braggingBoardService.totalCount(bcri);
		    model.addAttribute("ConnectingBraggingPageDTO", new ConnectingBraggingPageDTO(bcri, totalCount));
		}
		
		@GetMapping("myList")
		public void myList(Principal principal,Model model, BraggingCriteria bcri) {
			String id = principal.getName();
			log.info("id..." + id);
		    log.info("myList......" + bcri);
		    List<BraggingBoardVO> myList = braggingBoardService.myList(id,bcri);

		    Date now = new Date();
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		    String today = dateFormat.format(now);

		    for (BraggingBoardVO bbvo : myList) {
		        String regDateStr = dateFormat.format(bbvo.getRegDate());
		        if (regDateStr.equals(today)) {
		            // 오늘 올라온 게시글이라면 HH:mm 로 표시
		            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
		            bbvo.setDisplayDate(timeFormat.format(bbvo.getRegDate()));
		        } else {
		            // 오늘이 아니면 yyyy-mm-dd 로 표시
		            bbvo.setDisplayDate(regDateStr);
		        }
		    }

		    model.addAttribute("myList", myList);
		    
		    int myTotalCount = braggingBoardService.myTotalCount(id,bcri);
		    model.addAttribute("ConnectingBraggingPageDTO", new ConnectingBraggingPageDTO(bcri, myTotalCount));
		}
		
		
		@GetMapping({"view", "modify"})
		public void view(@RequestParam("bno") int bno, Model model, 
					     @ModelAttribute("bcri") BraggingCriteria bcri) {
			log.info("view or modify......");
			model.addAttribute("bbvo", braggingBoardService.view(bno));
		}
		

		@GetMapping("register")
		@PreAuthorize("isAuthenticated()")
		public void register() { 
			log.info("register......");
		}
		
		@PostMapping("register")
		public String register(BraggingBoardVO bbvo, HttpSession session, RedirectAttributes rttr) {
		    log.info("register......" + bbvo);
		    
		    // 게시글 등록
		    if(braggingBoardService.register(bbvo)) {
		        log.info("rttr.addFlashAttribute" + rttr.addFlashAttribute("result", bbvo.getBno()));
		        rttr.addFlashAttribute("result", bbvo.getBno());

		        // 세션에서 첨부파일 정보 리스트 가져오기
		        List<BraggingAttachFileDTO> list = (List<BraggingAttachFileDTO>) session.getAttribute("uploadedFiles");
		        
		        if(list != null) {
		            for(BraggingAttachFileDTO badto : list) {
		                // 각 첨부파일 정보의 bno 필드값을 새롭게 생성된 게시글 번호로 설정
		                badto.setBno(bbvo.getBno());

		                // DB에 첨부파일 정보 저장 로직 추가 (예: braggingBoardService.saveFile(badto);)
		            }
		            
		            // 처리 완료 후 세션에서 첨부파일 정보 제거
		            session.removeAttribute("uploadedFiles");
		        }
		    }

		    return "redirect:/bragging/list";
		}
		
		@PostMapping(value = "/recommend", produces = MediaType.APPLICATION_JSON_VALUE)
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<?> handleRecommend(@RequestBody BraggingBoardVO bbvo) {
		    try {
		        braggingBoardService.recommend(bbvo);
		        BraggingBoardVO updatedBbvo = braggingBoardService.view(bbvo.getBno());
		        return new ResponseEntity<>(updatedBbvo.getRecommendCnt(), HttpStatus.OK);
		    } catch (Exception e) {
		        return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		    }
		}
	
	
}
