package org.nagagu.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StoreCriteria {
	private int pageNum;
	private int amount;

	//검색
	private String type;
	private String keyword;
	
	//카테고리
	private String category;
	//정렬(최신,판매량,평점,조회,좋아요,가격)
	private String sort;
	
	
	
	public StoreCriteria() {
		this(1,9,"all","regdate");
	}
	public StoreCriteria(int pageNum, int amount, String category, String sort) {
		this.pageNum=pageNum;
		this.amount=amount;
		this.category = category;
		this.sort = sort;
	}
	//for reply
	public StoreCriteria(int pageNum, int amount) {
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
