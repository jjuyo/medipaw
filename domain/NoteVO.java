package org.medipaw.domain;

import java.sql.Date;
import lombok.Data;
@Data
public class NoteVO {
	int note_no;
	int note_sender_status; // 0 �׳� ���� 1 �������� 2 ��������  select �Ҷ� 0,2�� �ҷ��� 
	int note_recipient_status;//���������� 
	String note_recipient;
	String note_sender;
	String note_content;
	String note_title;
	Date note_date;	
	String id;
}
