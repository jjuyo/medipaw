package org.medipaw.domain;

import lombok.Data;

@Data
public class MarkVO {
	private int mno;
	private int animalhosp_no;
//	private String mHosName;
//	private String mHosAddr;
//	private String mHosImage;
//	private double mreview;
	private String id;
	private AnimalHospVO hvo;
}
