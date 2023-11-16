package org.medipaw.domain;

import java.sql.Date;
import lombok.Data;
@Data
public class NoteVO {
	int note_no;
	int note_sender_status; // 0 그냥 상태 1 삭제상태 2 보관상태  select 할때 0,2만 불러옴 
	int note_recipient_status;//마찬가지로 
	String note_recipient;
	String note_sender;
	String note_content;
	String note_title;
	Date note_date;	
	String id;
}
