package org.medipaw.domain;



import lombok.Data;

@Data
public class BraggingAttachFileDTO {
	
	private int bno;
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean fileType;
	
}
