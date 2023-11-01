package org.medipaw.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ReservVO {
	// 예약한 병원, 병원 주소, 병원 전화번호, 예약자 이름, 예약 일자, 예약 시간, 반려동물 이름, 반려동물 종, 반려동물 성별, 반려동물 특이사항
	private int rvno;
	private int hno;
	private String id;
	private String sid;
	private String hosName;
	private String hosAddress;
	private String hosPhone;
	private String name;
	private String rvDate;
	private String rvTime;
	private String petName;
	private String petSpecies;
	private String petGender;
	private String petNote;
	//private HosVO hvo;
}
