package org.nagagu.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	private String url;
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean fileType;
	private Long bno;
	private Long rno;
}
