package org.medipaw.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	// 한 페이지에 출력할 게시물의 수, 페이지 번호, 검색 타입, 검색 키워드 저장 및 전달
	private int amount;
	private int pageNum;
	private String type;
	private String keyword;
	
	// 값을 지정한 경우 매개변수로 전달 받은 값으로 지정
	public Criteria(int amount, int pageNum) {
		this.amount = amount;
		this.pageNum = pageNum;
	}
	
	// 값을 지정하지 않은 경우 한 페이지 게시물은 10개, 페이지 번호를 1로 지정 -> 기본 생성자
	public Criteria() {
		this(10, 1);
	}
	
	public String[] getTypeArr() {	// type이 null일 경우 빈 문자열 배열을 만들어서 넘기고 아니라면 split으로 잘라서 배열로 만듦
		// TCW가 넘어왔는데 split을 했다면 T | C | W로 쪼개져서 배열로 들어감
		return type == null ? new String[] {} : type.split("");
	}
	
}
