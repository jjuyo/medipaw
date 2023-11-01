package org.medipaw.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ConnectingCriteria {
    private int amount;
    private int pageNum;
    private String type;
    private String keyword;

    private String classification; // 분류화 Ex) [강아지, 고양이, 기타]
    private String segmentation; // 세분화 Ex) [말티즈, 도베르만, 치와와]
    
  //값을 지정하지 않은 경우
  	//한 페이지 게시물은 3개, 페이지 번호는 1로 지정
  	public ConnectingCriteria() {
  		this(10, 1,"없음");
  	}

  	//값을 지정한 경우
  	//매개변수로 전달 받은 값으로 지정
  	public ConnectingCriteria(int amount, int pageNum, String classification) {
  		this.amount = amount;
  		this.pageNum = pageNum;
  		this.classification = classification;
  	
  	}
  	
  	public String[] getTypeArr() {
  		return type == null ? new String[]{} : type.split("");
  	}
  	
}