package org.nagagu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.nagagu.domain.BasketVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.OrderDTO;
import org.nagagu.domain.OrderVO;
import org.nagagu.domain.ReplyPageDTO;

public interface BasketService {
	int insertCart(BasketVO basketVO);
	ArrayList<Map<String, Object>> getBasketList(BasketVO basketVO);//장바구니 리스트
	int countBasket(BasketVO basketVO);
	int deleteBasket(int basket_num);
	int updateAmount(BasketVO basketVO);
	int updateCheck(BasketVO basketVO);//장바구니1단계 -> 2단계(주문상세페이지)
	
	int insertOrder(OrderVO orderVO);
	int countOrder(OrderVO OrderVO);
	ArrayList<Map<String, Object>> cntGroupById(OrderVO orderVO);//주문 리스트
	
	ArrayList<Map<String, Object>> getOrderList(OrderVO orderVO);//주문 리스트
	ArrayList<Map<String, Object>> getOrderListById(OrderVO orderVO);//
//	ArrayList<Map<String, Object>> getPaidDetail(HashMap<String, Object> map);//주문내역(결제 리스트)
//	ArrayList<Map<String, Object>> getCount(HashMap<String, Object> map);//주문내역(결제 리스트)
}
