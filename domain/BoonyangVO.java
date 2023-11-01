package org.medipaw.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoonyangVO {
	private int byno;
	private String title, kind, content, gender, id, state;
	private int age;
	private Date regDate;
	private int replyCnt;
	private String byImg;
	private List<BoonyangAttachVO> attachList;	
}	
