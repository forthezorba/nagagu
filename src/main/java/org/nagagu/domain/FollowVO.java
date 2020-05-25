package org.nagagu.domain;

import lombok.Data;

@Data
public class FollowVO {
	private int follow_num;  /* 팔로우 ID */
	private String follow_from;  /* 회원 번호 */
	private String follow_to;
}
