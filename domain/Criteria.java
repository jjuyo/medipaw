package org.medipaw.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
		private int amount;
	private int pageNum;
	private String type;
	private String keyword;
	
	public Criteria(int amount, int pageNum) {
		this.amount = amount;
		this.pageNum = pageNum;
	}
	public Criteria() {
		this(10, 1);
	}
	public String[] getTypeArr() {	
		return type == null ? new String[] {} : type.split("");
	}
}
