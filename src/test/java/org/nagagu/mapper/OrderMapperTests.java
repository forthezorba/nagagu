package org.nagagu.mapper;

import java.util.HashMap;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.nagagu.domain.BasketVO;
import org.nagagu.domain.BasketVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderMapperTests {
	@Setter(onMethod_=@Autowired)
	private OrderMapper mapper;
	
	@Test
	public void testInsert() {
		BasketVO board= new BasketVO();
		board.setBasket_member("admin90");
		board.setBasket_amount(1);
		board.setBasket_color("blue");
		board.setBasket_product(376);
		
		mapper.insertBasket(board);
		log.info(board);
	}
	@Test
	public void testGetList() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("basket_member", "admin90");
		map.put("basket_check", 0);
		BasketVO basketVO = new BasketVO();
		mapper.getBasketList(basketVO).forEach(board -> log.info(board));
	}
	
	@Test
	public void testCountBasket() {
		BasketVO board= new BasketVO();
		board.setBasket_member("admin90");
		int cnt = mapper.countBasket(board);
		log.info(cnt);
	}
	
	@Test
	public void testDelete() {
		BasketVO board= new BasketVO();
		board.setBasket_num(46);
		log.info("delete count..."+mapper.deleteBasket(46));
	}
	@Test
	public void testUpdateAmount() {
		BasketVO board= new BasketVO();
		board.setBasket_num(47);
		board.setBasket_amount(3);
		int count = mapper.updateAmount(board);
		log.info("update count="+count);
	}
	@Test
	public void testUpdateCheck() {
		BasketVO board= new BasketVO();
		board.setBasket_num(47);
		//board.setBasket_check(1);
		int count = mapper.updateCheck(board);
		log.info("update check="+count);
	}
	@Test
	public void testInsertOrder() {
		OrderVO board= new OrderVO();
		
		board.setOrder_num(47);
		board.setOrder_product(376);
		board.setOrder_member("admin90");
		board.setOrder_price(30000);
		
		mapper.insertOrder(board);
		log.info(board);
	}
	@Test
	public void testGetOrderList() {
		OrderVO board= new OrderVO();
		board.setOrder_member("forthezorba@gmail.com");
		
		
		mapper.getOrderList(board).forEach(vo -> log.info(vo));
	}
	
	/*
	@Test
	public void testPaging() {
		Criteria cri=new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BasketVO> list=mapper.getListWithPaging(cri);
		list.forEach(board-> log.info(board.getBno()));
	}
	
	@Test
	public void testSearch() {
		Criteria cri=new Criteria();
		cri.setKeyword("tt");
		cri.setType("T");
		cri.setIsReview(0);
		cri.setCategory("all");
		//cri.setSort("likeCnt");
		List<BasketVO> list= mapper.getListWithPaging(cri);
		log.info(cri);
		list.forEach(board-> log.info(board));
	}
	

	
	*/
	
}
