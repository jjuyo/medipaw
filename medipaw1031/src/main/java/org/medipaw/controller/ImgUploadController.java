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

import org.medipaw.domain.AttachImgDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class ImgUploadController {
	
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
	@GetMapping("/upload/ajaxAction")
	public void uploadAjax() {
		// 128 비트 값으로 긴 이름으로 만들어서 업로드 되는 파일명이 중복되지 않게 함
		UUID uuid = UUID.randomUUID();			// 랜덤하게 UUID를 만들어내는 메서드
		System.out.println("uuid : " + uuid);	// d808b5b9-f4b1-4a9e-9b9a-12436add77c7
		log.info("ajaxAction.jsp...");
	}
	
	@PostMapping("/upload/ajaxAction")
	//@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<AttachImgDTO>> uploadAjax(MultipartFile[] uploadfile) {	// input name이랑 이름 같게 하기!
		log.info("upload ajax action...");
		String upPath = "c:\\upload";
		List<AttachImgDTO> list = new ArrayList<AttachImgDTO>();	// list 객체 생성
		
		// 연/월/일 폴더 생성
		File upFolder = new File(upPath, getFolder());
		
		// 생성된 폴더가 존재하지 않는 경우 해당 디렉토리를 생성
		if(upFolder.exists() == false) {
			upFolder.mkdirs();
		}
		
		for(MultipartFile multi : uploadfile) {
			log.info("name : " + multi.getOriginalFilename());
			log.info("size : " + multi.getSize());
			log.info("------------------------------");

			// UUID를 이용하여 파일명('UUID값_파일명')으로 중복 방지 처리
			UUID uuid = UUID.randomUUID();
			String upFileName = uuid + "_" + multi.getOriginalFilename();
			
			// upPath 이 경로에 multi.getOriginalFilename() 이름의 파일이 저장됨
			// File saveFile = new File(upPath, multi.getOriginalFilename());
			// 생성된 폴더에 파일이 저장됨
			// File saveFile = new File(upFolder, multi.getOriginalFilename());
			// UUID값을 붙인 파일명이 저장됨
			File saveFile = new File(upFolder, upFileName);
			
			AttachImgDTO afDTO= new AttachImgDTO();
			afDTO.setFileName(multi.getOriginalFilename());
			afDTO.setUpFolder(getFolder());
			afDTO.setUuid(uuid.toString());
			// afDTO.setImage(isImage(saveFile));
		    list.add(afDTO);					// AttachFileDTO 객체를 리스트에 추가
			
			try {
				multi.transferTo(saveFile);		// 파일 업로드 처리
				// 이미지 파일의 경우 썸네일 이미지 만들기
				if(isImage(saveFile)) {	
					// 파일명이 's_'로 시작하도록 처리
					FileOutputStream fos = new FileOutputStream(new File(upFolder, "s_" + upFileName));	// 파일 객체 만들기
					Thumbnailator.createThumbnail(multi.getInputStream(), fos, 100, 100);	// 지정된 파일로 100 x 100 크기로 썸네일 만들기
					fos.close();
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<List<AttachImgDTO>>(list, HttpStatus.OK);
	}
	
	// 현재 시점의 '연/월/일' 폴더 경로 문자열을 생성하여 반환
	public String getFolder() {
		Date today = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");	// 원하는 형태로 날짜 형태를 바꿈
        String formatToday = dateFormat.format(today);		// 2023-08-29
        
		return formatToday.replace("-", File.separator);	// 2023\08\29
	}
	
	// 이미지 파일 여부 확인
	public boolean isImage(File file) {
		 // file이 이미지 파일이면 true, 아니면 false 반환
		try {
			String contentType = Files.probeContentType(file.toPath());		// 파일 타입을 반환해줌
			System.out.println(contentType);								// image/png
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}		
		return false;
	}
	
	// 썸네일 이미지 파일 전송
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String fileName) {
		File file = new File("c:\\upload\\" + fileName);
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
	
	// 일반 파일 다운로드
//	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
//	public ResponseEntity<Resource> download(String fileName) {
//		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
//		
//		if(!resource.exists()) {		// resource 존재하지 않으면 notFound 띄우기
//			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//		}
//		
//		String resourceFileNm = resource.getFilename();		// 3e6e71ea-644b-483f-9ea0-595b69d50de1_selector.txt
//		log.info("resourceFileNm : " + resourceFileNm);
//		
//		String fileNameOnly = resourceFileNm.substring(resourceFileNm.indexOf("_") + 1);
//		log.info("fileNameOnly : " + fileNameOnly);			// selector.txt
//		
//		HttpHeaders header = new HttpHeaders();
//		try {
//			header.add("Content-Disposition", "attachment; filename=" + 
//						new String(fileNameOnly.getBytes("UTF-8"), "ISO-8859-1"));
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
//		return new ResponseEntity<>(resource, header, HttpStatus.OK);
//	}
	
	// 파일 삭제
	@PostMapping("/deleteFile")
	//@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("delete file : " + fileName);
		try {			// 폴더 경로를 다시 디코딩
			File file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if(type.equals("image")) {	// type이 이미지일 경우에는 썸네일과 원본 이미지도 지워야함
				String originFile = file.getAbsolutePath().replace("s_", "");
				file = new File(originFile);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
}
