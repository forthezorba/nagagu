package org.nagagu.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class ReplyVO {
	private Long rno;
	private Long bno;
	
	private String reply;
	private String replyer;
	private String replyerNick;
	private Date replyDate;
	private Date updateDate;
	private int grade;
	private List<BoardAttachVO> attachList;
}
