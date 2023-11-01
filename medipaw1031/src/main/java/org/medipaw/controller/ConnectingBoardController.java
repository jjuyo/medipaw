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
import org.medipaw.domain.ConnectingAttachFileDTO;
import org.medipaw.domain.ConnectingBoardAttachVO;
import org.medipaw.domain.ConnectingBoardVO;
import org.medipaw.domain.ConnectingCriteria;
import org.medipaw.domain.ConnectingBraggingPageDTO;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.PageDTO;
import org.medipaw.service.ConnectingBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/connecting/*")
@AllArgsConstructor
public class ConnectingBoardController {
	private ConnectingBoardService connectingBoardService;
	
	
	
	//첨부 파일 삭제
		public void deleteFiles(List<ConnectingBoardAttachVO> cnAttachList) {
			log.info("delete files.....");
			
			if(cnAttachList == null || cnAttachList.size() == 0) {
				return;
			}
			
			cnAttachList.forEach(cbavo -> {
				Path file = Paths.get("c:\\upload\\connectingUpload\\" + cbavo.getUploadPath() + "\\" +
													   cbavo.getUuid() + "_" +
													   cbavo.getFileName());
				try {
					Files.deleteIfExists(file);
					
					if(Files.probeContentType(file).startsWith("filetp")) { // ?
						Path thumbnail = Paths.get("c:\\upload\\connectingUpload\\" + 
												   cbavo.getUploadPath() + "\\s_" +
												   cbavo.getUuid() + "_" +
												   cbavo.getFileName());
						Files.deleteIfExists(thumbnail);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
		}
	
		@PostMapping("remove")
		@PreAuthorize("principal.username == #id or hasRole('ROLE_ADMIN')")
		public String remove(String id, int cno, RedirectAttributes rttr, 
			     			 @ModelAttribute("ccri") ConnectingCriteria ccri) {
			log.info("remove...... cno : " + cno);
			
			List<ConnectingBoardAttachVO> cnAttachList = connectingBoardService.cnAttachList(cno);
			
			if(connectingBoardService.remove(cno)) {
				log.info("remove ok");
				//deleteFiles(cnAttachList); 첨부파일 삭제
				rttr.addFlashAttribute("result", "success");
			}

			rttr.addAttribute("type", ccri.getType());
			rttr.addAttribute("keyword", ccri.getKeyword());
			rttr.addAttribute("pageNum", ccri.getPageNum());
			rttr.addAttribute("amount", ccri.getAmount());
			return "redirect:/connecting/list";
		}
		
		@PostMapping("modify/{pathId}")
		@PreAuthorize("principal.username == #id")
		public String modify(@PathVariable("pathId") String id,ConnectingBoardVO cbvo, HttpSession session,
		                     RedirectAttributes rttr,
		                     @ModelAttribute("ccri") ConnectingCriteria ccri,
		                     @RequestParam("uploadedFiles") String uploadFile) {
		    log.info("modify......" + cbvo);

		    if (connectingBoardService.modify(cbvo)) {
		        log.info("service modify" + cbvo);
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
		                ConnectingAttachFileDTO cadto = new ConnectingAttachFileDTO();
		                cadto.setUuid(parts[0]);
		                cadto.setUploadPath(parts[1]);
		                cadto.setFileName(parts[2]);
		                cadto.setFileType(Boolean.parseBoolean(parts[3]));

		                // 각 첨부파일 정보의 cno 필드값을 수정된 게시글 번호로 설정
		                cadto.setCno(cbvo.getCno());

		                // DB에 첨부파일 정보 저장 로직 추가 (예: connectingBoardService.saveFile(cadto);)
		            }
		            // 처리 완료 후 세션에서 첨부파일 정보 제거
		            session.removeAttribute("uploadedFiles");
		        }
		    }

		    rttr.addAttribute("type", ccri.getType());
		    rttr.addAttribute("keyword", ccri.getKeyword());
		    rttr.addAttribute("pageNum", ccri.getPageNum());
		    rttr.addAttribute("amount", ccri.getAmount());

		    return "redirect:/connecting/list";
		}

		@GetMapping(value="cnAttachList")
		public ResponseEntity<List<ConnectingBoardAttachVO>> cnAttachList(int cno){
			log.info("cnAttachList........." + cno);
			
			return new ResponseEntity<>(connectingBoardService.cnAttachList(cno), 
										HttpStatus.OK);
		}
		
		@GetMapping("list")
		public void list(@RequestParam(required = false) String classification,
				Model model, ConnectingCriteria ccri) {
		    log.info("list......" + ccri);
		    ccri.setClassification(classification);
		    List<ConnectingBoardVO> list = connectingBoardService.list(ccri);

		    Date now = new Date();
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		    String today = dateFormat.format(now);

		    for (ConnectingBoardVO cbvo : list) {
		        String regDateStr = dateFormat.format(cbvo.getRegDate());
		        if (regDateStr.equals(today)) {
		            // 오늘 올라온 게시글이라면 HH:mm 로 표시
		            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
		            cbvo.setDisplayDate(timeFormat.format(cbvo.getRegDate()));
		        } else {
		            // 오늘이 아니면 yyyy-mm-dd 로 표시
		            cbvo.setDisplayDate(regDateStr);
		        }
		    }

		    model.addAttribute("list", list);
		    
		    int totalCount = connectingBoardService.totalCount(ccri);
		    model.addAttribute("ConnectingBraggingPageDTO", new ConnectingBraggingPageDTO(ccri, totalCount));
		}
		
		
		
		@GetMapping("myList")
		public void myList(Principal principal,Model model, ConnectingCriteria ccri) {
			String id = principal.getName();
			log.info("id..." + id);
		 
		    List<ConnectingBoardVO> myList = connectingBoardService.myList(id,ccri);

		    Date now = new Date();
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		    String today = dateFormat.format(now);

		    for (ConnectingBoardVO cbvo : myList) {
		        String regDateStr = dateFormat.format(cbvo.getRegDate());
		        if (regDateStr.equals(today)) {
		            // 오늘 올라온 게시글이라면 HH:mm 로 표시
		            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
		            cbvo.setDisplayDate(timeFormat.format(cbvo.getRegDate()));
		        } else {
		            // 오늘이 아니면 yyyy-mm-dd 로 표시
		            cbvo.setDisplayDate(regDateStr);
		        }
		    }

		    model.addAttribute("myList", myList);
		    
		    int myTotalCount = connectingBoardService.myTotalCount(id,ccri);
		    model.addAttribute("ConnectingBraggingPageDTO", new ConnectingBraggingPageDTO(ccri, myTotalCount));
		}
		
		
		@GetMapping({"view", "modify"})
		public void view(@RequestParam("cno") int cno, Model model, 
					     @ModelAttribute("ccri") ConnectingCriteria ccri) {
			log.info("view or modify......");
			model.addAttribute("cbvo", connectingBoardService.view(cno));
		}
		

		@GetMapping("register")
		@PreAuthorize("isAuthenticated()")
		public void register() { 
			log.info("register......");
		}
		
		@PostMapping("register")
		public String register(ConnectingBoardVO cbvo, HttpSession session, RedirectAttributes rttr) {
		    log.info("register......" + cbvo);
		    
		    // 게시글 등록
		    if(connectingBoardService.register(cbvo)) {
		        log.info("rttr.addFlashAttribute" + rttr.addFlashAttribute("result", cbvo.getCno()));
		        rttr.addFlashAttribute("result", cbvo.getCno());

		        // 세션에서 첨부파일 정보 리스트 가져오기
		        List<ConnectingAttachFileDTO> list = (List<ConnectingAttachFileDTO>) session.getAttribute("uploadedFiles");
		        
		        if(list != null) {
		            for(ConnectingAttachFileDTO cadto : list) {
		                // 각 첨부파일 정보의 cno 필드값을 새롭게 생성된 게시글 번호로 설정
		                cadto.setCno(cbvo.getCno());

		                // DB에 첨부파일 정보 저장 로직 추가 (예: connectingBoardService.saveFile(cadto);)
		            }
		            
		            // 처리 완료 후 세션에서 첨부파일 정보 제거
		            session.removeAttribute("uploadedFiles");
		        }
		    }

		    return "redirect:/connecting/list";
		}
		
		@PostMapping(value = "/recommend", produces = MediaType.APPLICATION_JSON_VALUE)
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<?> handleRecommend(@RequestBody ConnectingBoardVO cbvo) {
		    try {
		        connectingBoardService.recommend(cbvo);
		        ConnectingBoardVO updatedCbvo = connectingBoardService.view(cbvo.getCno());
		        return new ResponseEntity<>(updatedCbvo.getRecommendCnt(), HttpStatus.OK);
		    } catch (Exception e) {
		        return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		    }
		}
	
	
}
