package org.medipaw.domain;

import lombok.Data;

@Data
public class BoonyangAttachVO {
	private int byno;			// 게시물 번호
	private String fileName;	// 파일명
	private String upFolder;	// 폴더 경로
	private String uuid;		// 중복 방지 아이디(pk)
}
