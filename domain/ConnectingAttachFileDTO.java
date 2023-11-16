package org.medipaw.domain;

import lombok.Data;

@Data
public class ConnectingAttachFileDTO {
	private int cno;
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean fileType;
}
