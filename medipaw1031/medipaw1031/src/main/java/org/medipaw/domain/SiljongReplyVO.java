package org.medipaw.domain;

import java.util.Date;
import lombok.Data;

@Data
public class SiljongReplyVO {
	private int sjrno;			// 댓글 번호	
	private int sjno;			// 글 번호
	private String sjReply;		// 댓글
	private String id;			// 댓글 작성자
	private Date sjrRegDate;	// 작성일자
}
