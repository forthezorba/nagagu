package org.nagagu.domain;

import lombok.Data;

@Data
public class BasketVO {
	private int basket_num ; /* 장바구니 ID */
	private int basket_memberNum ; /* 장바구니 ID */
	private String basket_member ; /* 회원 번호 */
	private int basket_product; /* 완제품 ID */
	private String basket_color ;
	private String basket_size	;
	private int basket_amount ;/* 수량 */
	private int basket_check;
}
