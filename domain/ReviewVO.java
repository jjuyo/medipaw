package org.medipaw.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private String id, title, content;
	private Date regDate;
	int rno, animalhosp_no, tno; // 진료1개당 리뷰1개 작성 가능
	double star;
}
