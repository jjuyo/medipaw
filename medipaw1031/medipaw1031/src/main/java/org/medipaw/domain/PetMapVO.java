package org.medipaw.domain;

import lombok.Data;

@Data
public class PetMapVO {
	private String fcltyNm;
    private String ctgryOneNm;
    private String ctgryTwoNm;
    private String ctgryThreeNm;
    private String lcLa; 
    private String lcLo; 
    private String zipNo; 
    private String rdnmadrNm; 
    private String lnmAddr; 
   	private	String telNo;		// 전화번호	
	private	String hmpgUrl;	// 홈페이지URL	
	private	String rstdeGuidCn;	// 휴무일안내내용	
	private	String operTime;	// 운영시간	
	private	String parkngPosblAt;	// 주차가능여부	
	private	String utiliizaPrcCn; // 이용가격내용	VARCHAR	1000	N	N
 	private	String petLmttMtrCn; // 반려동물제한사항내용	CLOB		

}
