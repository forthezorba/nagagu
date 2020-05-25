package org.nagagu.domain;

import java.util.Date;

import lombok.Data;
@Data
public class OrderVO {
	private int order_num;  /*basket id */
	private int order_amount ;/* 수량 */
	private int order_price; /*총가격*/
	private int order_product; /* 완제품 id */

	private String order_id; //주문 id	
	private String order_size; /* 번호 */
	private String order_color; /* 번호 */
	private String order_member; /* 회원 번호 */
	private Date order_date;  /* 주문일자 */
	
	private String order_name; /* 수령인 */
	private String order_phone; /* 번호 */
	private String order_memo; /* 메모 */
	private String order_address; /* 주소*/
	private int order_state; /* 주문상태 */
}
