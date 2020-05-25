package org.nagagu.service;

import java.util.ArrayList;
import java.util.Map;

import org.nagagu.domain.BasketVO;
import org.nagagu.domain.OrderDTO;
import org.nagagu.domain.OrderVO;
import org.nagagu.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class BasketServiceImpl implements BasketService{
	@Setter(onMethod_=@Autowired)
	private OrderMapper mapper;
	@Override
	public int insertCart(BasketVO basketVO) {
		return mapper.insertBasket(basketVO);
	}
	@Override
	public int countBasket(BasketVO basketVO) {
		return mapper.countBasket(basketVO);
	}
	@Override
	public int deleteBasket(int basket_num) {
		return mapper.deleteBasket(basket_num);
	}
	@Override
	public int updateAmount(BasketVO basketVO) {
		return mapper.updateAmount(basketVO);
	}
	@Override
	public int updateCheck(BasketVO basketVO) {
		return mapper.updateCheck(basketVO);
	}
	@Override
	public ArrayList<Map<String, Object>> getBasketList(BasketVO basketVO) {
		return mapper.getBasketList(basketVO);
	}
	@Override
	public int insertOrder(OrderVO orderVO) {
		mapper.deleteBasket(orderVO.getOrder_num());
		return mapper.insertOrder(orderVO);
	}
	@Override
	public int countOrder(OrderVO OrderVO) {
		return mapper.countOrder(OrderVO);
	}
	@Override
	public ArrayList<Map<String, Object>> cntGroupById(OrderVO OrderVO) {
		return mapper.cntGroupById(OrderVO);
	}
	@Override
	public ArrayList<Map<String, Object>> getOrderList(OrderVO orderVO) {
		return mapper.getOrderList(orderVO);
	}
	@Override
	public ArrayList<Map<String, Object>> getOrderListById(OrderVO orderVO) {
		return mapper.getOrderListById(orderVO);
	}
	/*
	
	@Override
	public ArrayList<Map<String, Object>> getCount(HashMap<String, Object> map) {
		return mapper.getCount(map);
	}
	@Override
	public ArrayList<Map<String, Object>> getPaidDetail(HashMap<String, Object> map) {
		return mapper.getPaidDetail(map);
	}
	*/
	
}
