package org.medipaw.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class SiljongReplyPageDTO {
	private int replyCnt;
	private List<SiljongReplyVO> list;
}
