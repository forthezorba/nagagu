
package org.nagagu.domain;

import java.util.Date;
import java.util.List;

import org.nagagu.domain.BoardAttachVO;

import lombok.Data;
@Data
public class ProductVO {
	private Long bno;
	private String writer;
	private String writer_picture;
	private String workshopName;
	private String title;
	private String category;
	private Date regdate;
	private Date updateDate;
	private int replyCnt;
	private int likeCnt;
	private int readCnt;
	private int price;
	private int salesCnt;
	private String color;
	private String allsize;
	private String content;
	private String banner;	
	private String mainImage;
	private int status;
	private int stock;
	private List<BoardAttachVO> attachList;
	
	private int shipPrice;
	private String shipCompany;	
	private int shipReturnPrice;
	private int shipChangePrice;
	private String shipReturnPlace;
	private String shipDays;
	private String shipInfo;	
	
}
