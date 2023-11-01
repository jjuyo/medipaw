package org.medipaw.domain;

import java.util.Date;
import java.util.List;


import lombok.Data;

@Data
public class StaffVO {
	private String sid, spw, sname, sphone, semail;
	private Date regDate;
	private String companyNum;
	private List<StaffAuthVO> authList;
	private boolean enabled;
	private String img;
	//private List<StaffAttachVO> attachList; 사진 그냥 sid로 가져와도 될듯
	}
	


