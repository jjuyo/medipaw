package org.medipaw.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private final double NUM_PER_PAGE = 5.0;	// 한 페이지에 표시할 페이지 번호 수
	private int start;			// 시작 페이지 번호
	private int end;			// 끝 페이지 번호
	private boolean prev;		// 이전 값이 있는지 여부
	private boolean next;		// 다음 값이 있는지 여부
	private Criteria cri;		// 한 페이지에 표시할 게시물의 수 및 페이지 번호(Criteria 사용)
	
	public PageDTO(Criteria cri, int totalCount) {
		this.cri = cri;
		
		int pages = (int)(Math.ceil((double)totalCount / cri.getAmount()));	// 페이지 수 소수점 필요해서 double로 casting
		end = (int)(Math.ceil(cri.getPageNum() / NUM_PER_PAGE) * NUM_PER_PAGE);
		start = end - (int)(NUM_PER_PAGE - 1);
		end   = end >= pages? pages : end;		// end가 pages보다 같거나 커지면 pages를 씀
		prev = start > 1;
		next = end < pages;
	}
}
