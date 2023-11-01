package org.medipaw.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AnimalHospVO {
    int animalhosp_no; // 동물병원 고유번호
    String animalhosp_name; // 사업장명
    Date license_date; // 인허가 날짜
    String sales_status; // 영업상태명
    Date closed_date; // 폐업 날짜
    String hsop_roadname_address; // 소재지 도로명주소 
    int hsop_postnum;//소재지 우편번호
    double a_latitude;//위도 
    double a_hardness;//경도 
    String animalhosp_pic;//기본 사진 
    String animalhosp_open;//영업시간 
	String animalhosp_rest;//휴무일 
	double star_total;//평점 총점 
	int rv_cnt;//리뷰 숫자  
	String sid;	// 병원 관계자 id
	String hsop_phonenum;  //전화번호  
}
