package org.medipaw.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ConnectingBoardVO {
	private int cno; // 게시판 번호
	private String classification; // 분류화 Ex) [강아지, 고양이, 기타]
	private String segmentation; // 세분화 Ex) [말티즈, 도베르만, 치와와]
	private List<ConnectingBoardAttachVO> cnAttachList; // 첨부파일 리스트
	private int rno; // 추천 번호
	private String title; // 글제목
	private String content; // 글내용
	private String id; // 작성자
	private int hit; // 게시글 조회수
	private int recommendCnt; // 추천
	private Date regDate; // 등록일
	private Date updateDate; // 업데이트일
	private String displayDate; //화면에 보이는 날짜
	
}
