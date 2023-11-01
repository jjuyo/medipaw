package org.medipaw.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.medipaw.domain.AttachImgDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class bycNumUploadController {
	
//	@GetMapping("/upload/formAction")
//	public void uploadForm() {
//		log.info("formAction.jsp..."); 
//	}
//	
//	@PostMapping("/upload/formAction")
//	public void uploadAction(MultipartFile[] uploadfile) {	// input name이랑 이름 같게 하기!
//		log.info("upload action...");
//		String upPath = "c:\\upload";
//		
//		for(MultipartFile multi : uploadfile) {
//			log.info("name : " + multi.getOriginalFilename());
//			log.info("size : " + multi.getSize());
//			log.info("------------------------------");
//			
//			File saveFile = new File(upPath, multi.getOriginalFilename());
//			
//			try {
//				multi.transferTo(saveFile);		// 파일 업로드 처리
//			} catch (IllegalStateException e) {
//				e.printStackTrace();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//	}
//	
	// 현재 시점의 '연/월/일' 폴더 경로 문자열을 생성하여 반환
	public String getFolder() {
		Date today = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");	// 원하는 형태로 날짜 형태를 바꿈
        String formatToday = dateFormat.format(today);		// 2023-08-29
        
		return formatToday.replace("-", File.separator);	// 2023\08\29
	}
	

	@GetMapping("/upload/ajaxAction2")
	public void uploadAjax() {
		// 128 비트 값으로 긴 이름으로 만들어서 업로드 되는 파일명이 중복되지 않게 함
		UUID uuid = UUID.randomUUID();	// 랜덤하게 UUID를 만들어내는 메서드
		System.out.println(uuid);		// d808b5b9-f4b1-4a9e-9b9a-12436add77c7
		log.info("ajaxAction.jsp...");
	}
	
	@PostMapping("/upload/ajaxAction2")
	public ResponseEntity<AttachImgDTO> uploadAjax(@RequestParam("img") MultipartFile img, HttpServletRequest request) {
	    log.info("upload ajax action...");
	 // ServletContext를 얻어옵니다. 이 코드는 Spring Framework에서는 다를 수 있습니다.
	    ServletContext application = request.getServletContext();

	    // 웹 리소스 경로를 지정합니다. 예를 들어, "/resources/img/medipaw"와 같은 상대 경로를 사용합니다.
	    String relativePath = "/resources/img/medipaw";

	    // getRealPath 메서드를 사용하여 상대 경로에 대한 실제 파일 시스템 경로를 가져옵니다.
	    String realPath = application.getRealPath(relativePath);
	    log.info(realPath);
	 
	    String upPath = realPath;


	    try {
	        // UUID를 생성하여 파일명에 포함
	        UUID uuid = UUID.randomUUID();
	        String upFileName = uuid + "_" + img.getOriginalFilename();
	        File saveFile = new File(upPath, upFileName);

	        // 파일을 서버로 복사 (업로드)
	        img.transferTo(saveFile);

	        // AttachImgDTO에 이미지 정보 설정
	        AttachImgDTO afDTO = new AttachImgDTO();
	        afDTO.setFileName(img.getOriginalFilename());
	        afDTO.setUpFolder(getFolder());
	        afDTO.setUuid(uuid.toString());

	        return new ResponseEntity<>(afDTO, HttpStatus.OK);
	    } catch (IOException e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	}


	

	
	// 썸네일 이미지 파일 전송
	@GetMapping("/display2")
	public ResponseEntity<byte[]> display(String fileName, HttpServletRequest request) {
		 // ServletContext를 얻어옵니다. 이 코드는 Spring Framework에서는 다를 수 있습니다.
	    ServletContext application = request.getServletContext();

	    // 웹 리소스 경로를 지정합니다. 예를 들어, "/resources/img/medipaw"와 같은 상대 경로를 사용합니다.
	    String relativePath = "/resources/img/medipaw";

	    // getRealPath 메서드를 사용하여 상대 경로에 대한 실제 파일 시스템 경로를 가져옵니다.
	    String realPath = application.getRealPath(relativePath);
	    log.info(realPath);

		File file = new File(realPath + fileName);
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	
	// 파일 삭제
	@PostMapping("/deleteFile2")
	//@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(String fileName, HttpServletRequest request) {
		 // ServletContext를 얻어옵니다. 이 코드는 Spring Framework에서는 다를 수 있습니다.
	    ServletContext application = request.getServletContext();

	    // 웹 리소스 경로를 지정합니다. 예를 들어, "/resources/img/medipaw"와 같은 상대 경로를 사용합니다.
	    String relativePath = "/resources/img/medipaw";

	    // getRealPath 메서드를 사용하여 상대 경로에 대한 실제 파일 시스템 경로를 가져옵니다.
	    String realPath = application.getRealPath(relativePath);
	    log.info(realPath);

		log.info("delete file : " + fileName);
		try {			// 폴더 경로를 다시 디코딩
			File file = new File(realPath + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
}
