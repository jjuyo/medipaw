package org.medipaw.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SiljongVO {
	private int sjno;			// 글 번호
	private String sjState;		// 실종 상태
	private String sjTitle;		// 제목
	private String sjContent;	// 내용
	private String id;			// 작성자
	private Date sjRegDate;		// 등록 일자
	private int sjHit;			// 조회 수
	private int sjReplyCnt;		// 댓글 수
	private List<SiljongAttachVO> attachList;	
}
