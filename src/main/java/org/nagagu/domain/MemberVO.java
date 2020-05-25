package org.nagagu.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class MemberVO {
	private Long member_num;
	private String member_id;
	private String member_pass;
	private String member_name;
	private String member_nick;
	private String member_phone;
	private Date member_date;
	private String member_picture;
	private int member_status;
	private int address_zip;
	private String address_address1;
	private String address_address2;
	private int member_license;
	
	private boolean enabled;
	
	private List<AuthVO> authList;
}
