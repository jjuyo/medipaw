package org.medipaw.domain;

import lombok.Data;

@Data
public class TreatVO {
	// 예약한 병원, 병원 주소, 병원 전화번호, 예약자 이름, 진료 일자, 진료 시간, 진료 내용
	private int tno;
	private int rvno;
	private int hno;
	private String id;
	private String sid;
//	private String hosName;		// 병원 내용은 병원 VO에 있으니까 빼도 됨
//	private String hosAddr;		
//	private String hosTel;
	private String trDate;
	private String trTime;
	private String trNote;	
	private boolean delCheck;	// 회원이 진료 기록을 지웠는지 체크 -> default 0(false) -> 삭제 처리하면 1(true)로 변경
//	private int trCnt;			// 진료 테이블에 이미 count가 1 이상이라면 진료 추가 못 하게 함
	private AnimalHospVO hvo;
	private MemberVO mvo;
}
