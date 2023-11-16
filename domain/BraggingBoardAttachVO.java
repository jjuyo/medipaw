package org.medipaw.domain;

import lombok.Data;

@Data
public class BraggingBoardAttachVO {
	private int bno; // 게시판 번호
	private String fileName; // 파일 이름
	private String uploadPath; // 파일 경로
	private String uuid; // 파일 물리 아이디 (파일 이름 중복방지) PK
	private boolean fileType; // 파일 타입 (이미지인지 아닌지 판별)
	
}
