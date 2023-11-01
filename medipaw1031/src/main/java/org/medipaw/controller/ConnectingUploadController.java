package org.medipaw.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

import org.medipaw.domain.ConnectingAttachFileDTO;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/connecting/*")
public class ConnectingUploadController {
	//현재 시점의 '연/월/일' 폴더 경로 문자열을 생성하여 반환
	public String getUploadPath() {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String str = sdf.format(new Date());
	    return str.replace("-", File.separator);
	}

		//이미지 파일 여부 확인
		public boolean isFileType(File file) {
		    try {
		        String contentType = Files.probeContentType(file.toPath());
		        return contentType.startsWith("image");
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		    
		    return false;
		}//END isFileType()
		
		//썸네일 이미지 파일 전송
		@GetMapping("display")
		public ResponseEntity<byte[]> display(String fileName){
			File file = new File("c:\\upload\\connectingUpload\\" + fileName);
			ResponseEntity<byte[]> result = null;
			
			try {
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type", 
						   Files.probeContentType(file.toPath()));
				
				result = new ResponseEntity<>(
								FileCopyUtils.copyToByteArray(file),
								header,
								HttpStatus.OK);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return result;
		}//END display()
		
		//일반 파일 다운로드
		@GetMapping(value="download",
					produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
		public ResponseEntity<Resource> download(String fileName){
			Resource resource = new FileSystemResource("c:\\upload\\connectingUpload\\" + fileName);
			
			if(!resource.exists()) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
			String resourceFileNm = resource.getFilename();
			resourceFileNm = resourceFileNm.substring(resourceFileNm.indexOf("_") + 1); //파일명에서 UUID 제거
			
			log.info(resourceFileNm);
			
			HttpHeaders header = new HttpHeaders();
			try {
				header.add("Content-Disposition", 
						   "attachment; filename=" + 
								   new String(resourceFileNm.getBytes("UTF-8"), "ISO-8859-1"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			return new ResponseEntity<>(resource, header, HttpStatus.OK);
		}//END download()
		
		//파일 삭제
		@PostMapping("deleteFile")
		//@PreAuthorize("isAuthenticated()")
		public ResponseEntity<String> deleteFile(String fileName, String type){
			log.info("delete file : " + fileName);
			try {
				File file = new File("c:\\upload\\connectingUpload\\" + 
									 URLDecoder.decode(fileName, "UTF-8"));
				
				file.delete();		//파일 삭제
				
				if(type.equals("image")) {
					String originFile = file.getAbsolutePath().replace("s_", "");
					file = new File(originFile);
					file.delete();	//썸네일 원본 이미지 파일 삭제
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			return new ResponseEntity<String>("deleted", HttpStatus.OK);
		}
		
		//업로드 결과 목록 반환
		@PostMapping("upload/ajaxAction")
		public ResponseEntity<List<ConnectingAttachFileDTO>> 
		            uploadAjaxAction(MultipartFile[] uploadFile, HttpSession session) {
		    log.info("upload ajax action");
		    String upPath = "c:\\upload\\connectingUpload\\";

		    // 연/월/일 폴더 생성
		    File uploadPath = new File(upPath, getUploadPath());

		    if(!uploadPath.exists()) { // 생성된 폴더가 존재하지 않는 경우 폴더 만들기
		        uploadPath.mkdirs();
		    }

		    List<ConnectingAttachFileDTO> list = new ArrayList<ConnectingAttachFileDTO>();

		    for(MultipartFile multi : uploadFile) {
		        log.info("name : " + multi.getOriginalFilename());
		        log.info("size : " + multi.getSize());
		        log.info("----------------------------");

		        //UUID를 이용하여 파일명('UUID값_파일명' 형태) 중복 방지 처리
		        UUID uuid = UUID.randomUUID();
		        String upFileNm = uuid + "_" + multi.getOriginalFilename();

		        ConnectingAttachFileDTO cadto = new ConnectingAttachFileDTO();
		        cadto.setFileName(multi.getOriginalFilename());
		        cadto.setUuid(uuid.toString());
		        cadto.setUploadPath(getUploadPath());

				// Log the DTO object before saving to the session.
			    log.info("Before saving to session: " + cadto);

				File saveFile = new File(uploadPath, upFileNm);

				try {
				    multi.transferTo(saveFile);     //파일 업로드 처리

				    //이미지 파일의 경우 섬네일 이미지 만들기
				    //파일명이 's_'로 시작하도록 처리
				    if(isFileType(saveFile)) {
				        cadto.setFileType(true);

				        FileOutputStream fos = new FileOutputStream(
				                new File(uploadPath, "s_" + upFileNm));

				        Thumbnailator.createThumbnail(
				                multi.getInputStream(), fos, 100, 100);

				        fos.close();                  
				    }
				} catch (IllegalStateException e) {
				    e.printStackTrace();
				} catch (IOException e) {
				    e.printStackTrace();
				}

			    list.add(cadto);
			    // Log the DTO object before passing to the service.
			    log.info("Passing to service: " + cadto);
			    
			    } 

			  // Save the list of DTOs in the session.
			  session.setAttribute("uploadedFiles", list);

			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		
		@GetMapping("upload/ajaxAction")
		public void uploadAjax() {
			log.info("upload ajax");
		}
		
		@PostMapping("upload/formAction")
		public void uploadAction(MultipartFile[] uploadFile) {
			log.info("upload action");
			String upPath = "c:\\upload\\connectingUpload\\";
			for(MultipartFile multi : uploadFile) {
				log.info("name : " + multi.getOriginalFilename());
				log.info("size : " + multi.getSize());
				
				log.info("----------------------------");
				
				File saveFile = new File(upPath, multi.getOriginalFilename());
				
				try {
					multi.transferTo(saveFile);		//파일 업로드 처리
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}	
			}
		}
		
		@GetMapping("upload/formAction")
		public void uploadForm() {
			log.info("upload form");
		}
	}







