package org.nagagu.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.nagagu.domain.BasketVO;
import org.nagagu.domain.OrderVO;


public interface OrderMapper {
	int insertBasket(BasketVO basketVO);//장바구니 담기
	ArrayList<Map<String, Object>> getBasketList(BasketVO basketVO);//장바구니 리스트
	ArrayList<Map<String, Object>> getOrderList(OrderVO orderVO);//장바구니 리스트
	int countBasket(BasketVO basketVO);
	int countOrder(OrderVO OrderVO);
	
	ArrayList<Map<String, Object>> cntGroupById(OrderVO orderVO);//오더 리스트
	ArrayList<Map<String, Object>> getOrderListById(OrderVO orderVO);//오더 리스트
	
	int deleteBasket(int basket_num);
	int updateAmount(BasketVO basketVO);
	int updateCheck(BasketVO basketVO);
	int insertOrder(OrderVO OrderVO);
	

//	ArrayList<Map<String, Object>> getPaidList(HashMap<String, Object> map);//장바구니 리스트
//	ArrayList<Map<String, Object>> getPaidDetail(HashMap<String, Object> map);//장바구니 더보기
//	ArrayList<Map<String, Object>> getCount(HashMap<String, Object> map);//장바구니 리스트
}
