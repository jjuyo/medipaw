package org.medipaw.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReplyVO {
	private int byrno;
	private int byno;
	private String reply;
	private String id;
	private Date regDate;
}
