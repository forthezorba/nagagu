package org.nagagu.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	private int isReview;
	private String category;
	private String sort;
	
	public Criteria() {
		this(1,9,0,"all","regDate");
	}
	public Criteria(int pageNum, int amount, int review, String category, String sort) {
		this.pageNum=pageNum;
		this.amount=amount;
		this.isReview=review;
		this.category = category;
		this.sort = sort;
	}
	//for reply
	public Criteria(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	
	public String[] getTypeArr() {
		return type==null? new String[] {}: type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword()
				);
		return builder.toUriString();
	}
}
