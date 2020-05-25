package org.nagagu.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno; 
	private String title;
	private String content;
	private String writer;
	private String writer_picture;
	private String nick;
	private String tags;
	private String category;
	private Date regdate;
	private Date updateDate;
	private int replyCnt;
	private int likeCnt;
	private int readCnt;
	private int isReview;
	private String mainImage;
	private Long productNo;
	
	private List<BoardAttachVO> attachList;
}
