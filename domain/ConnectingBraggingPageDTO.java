package org.medipaw.domain;

import org.medipaw.domain.BraggingCriteria;
import org.medipaw.domain.ConnectingCriteria;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ConnectingBraggingPageDTO {
	private final double NUM_PER_PAGE = 5.0;
	private int start; // 시작 페이지
	private int end; // 끝 페이지
	private boolean prev; // 이전
	private boolean next; // 다음
	private BraggingCriteria bcri; // 한 페이지에 표시할 게시물의 수 및 페이지 번호
	private ConnectingCriteria ccri;
	
	public ConnectingBraggingPageDTO(BraggingCriteria bcri, int totalCount) {
		this.bcri = bcri;
		
		int pages = (int)(Math.ceil((double)totalCount/bcri.getAmount())); 
		end = (int)(Math.ceil(bcri.getPageNum()/NUM_PER_PAGE) * NUM_PER_PAGE); 
		start = end - (int)(NUM_PER_PAGE - 1);
		end   = end >= pages ? pages : end; 

		prev = start > 1;
		next = end < pages;
	}
	
	public ConnectingBraggingPageDTO(ConnectingCriteria ccri, int totalCount) {
		this.ccri = ccri;
		
		int pages = (int)(Math.ceil((double)totalCount/ccri.getAmount())); 
		end = (int)(Math.ceil(ccri.getPageNum()/NUM_PER_PAGE) * NUM_PER_PAGE); 
		start = end - (int)(NUM_PER_PAGE - 1);
		end   = end >= pages ? pages : end; 

		prev = start > 1;
		next = end < pages;
	}
}
