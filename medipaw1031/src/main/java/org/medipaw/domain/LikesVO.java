package org.medipaw.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class LikesVO {
	private String placeNo;
	private String id;
	private Date likeDate;
}
