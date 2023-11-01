package org.medipaw.domain;

import lombok.Data;

@Data
public class MarkVO {
	// 즐찾번호, 등록일자, 병원이름, 병원주소, 사진, 리뷰 평점, 아이디
	private int mno;
	private int hno;
//	private String mHosName;
//	private String mHosAddr;
//	private String mHosImage;
//	private double mreview;
	private String id;
	private AnimalHospVO hvo;
}
