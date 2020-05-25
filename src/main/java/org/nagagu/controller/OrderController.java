package org.nagagu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nagagu.domain.BasketVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.OrderVO;
import org.nagagu.service.BasketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
	@Autowired
	private BasketService basketService;

	@GetMapping("/basket")
	public void basket(Model model, Criteria cri) {
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/insertBasket")
	public @ResponseBody  Map<String, Object> insertBasket(BasketVO basketVO) {
		log.info("insert basket..."+basketVO);
		Map<String, Object> retVal = new HashMap<String, Object>();
		try {
			basketService.insertCart(basketVO);
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/basketList")
	public void basketList(Model model,BasketVO basketVO) {
	}
 	//장바구니 페이지
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/getBasket")
	public @ResponseBody Map<String, Object> getMyBasket(BasketVO basketVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		try {
			//장바구니 개수세기
			int countBasket = basketService.countBasket(basketVO);
			ArrayList<Map<String, Object>> getbasketList = null;
			getbasketList = basketService.getBasketList(basketVO);
			retVal.put("countBasket", countBasket);
			retVal.put("getbasketList", getbasketList);
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal; 
	}
	//수량 변경 업데이트
	@RequestMapping(value = "/updateAmount")
	public @ResponseBody  Map<String, Object> updateBasket(BasketVO basketVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		log.info("upadetebasket..."+basketVO);
		try {
			basketService.updateAmount(basketVO);
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	//장바구니에서 삭제
	@RequestMapping(value = "/deleteBasket")
	public @ResponseBody Map<String, Object> deleteBasket(BasketVO basketVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		try {
			basketService.deleteBasket(basketVO.getBasket_num());
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	} 
	//2단계로 check상태 변경
	@RequestMapping(value = "/updateCheck")
	public @ResponseBody Map<String, Object> MypageOrder(HttpServletRequest request,BasketVO basketVO) {
		String[] arr = request.getParameterValues("arr[]");
		Map<String, Object> retVal = new HashMap<String, Object>();
		String category = request.getParameter("category");
		try {
			if(category.equals("order")) {
				for(int i=0; i<arr.length; i++) {
					basketVO.setBasket_num(Integer.parseInt(arr[i]));
					basketVO.setBasket_check(1);
					basketService.updateCheck(basketVO);
				}
			}
			if(category.equals("paid")) {
				for(int i=0; i<arr.length; i++) {
					basketVO.setBasket_num(Integer.parseInt(arr[i]));
					basketVO.setBasket_check(1);
					//선주-결제되면 PRODUCT 테이블에서 PRODUCT_SALES+1해줌(판매량+1)
					//productService.updateSales(map);
				}
			}
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/basketList2")
	public void basketList2(Model model,BasketVO basketVO) {
		basketVO.setBasket_check(1);
		
		int countBasket = basketService.countBasket(basketVO);
		ArrayList<Map<String, Object>> getbasketList = null;
		getbasketList = basketService.getBasketList(basketVO);
		model.addAttribute("countBasket",countBasket);
		model.addAttribute("getbasketList",getbasketList);
	}
	@RequestMapping(value = "/insertOrder")
	public @ResponseBody  Map<String, Object> insertOrder(OrderVO orderVO, BasketVO basketVO){
		Map<String, Object> retVal = new HashMap<String, Object>();
		log.info(orderVO);
		try {
			basketService.insertOrder(orderVO);
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	//주문성공
	@GetMapping("/orderDetail")
	public void success(Model model) {
		log.info("success");
	}
	//주문내역(DETAIL)
	@GetMapping("/orderDetail/{order_id}")
	public String orderGet(Model model,@ModelAttribute("order_id") String order_id) {
		log.info(order_id);
		return "order/orderDetail";
	}
	
	//결제내역 페이지(오더리스트?)
	@RequestMapping(value = "/orderList/{order_member}/{order_id}",
			produces= {
					MediaType.APPLICATION_ATOM_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
	})
	public @ResponseBody Map<String, Object> orderList(OrderVO vo,Model model){
		log.info(vo);
		Map<String, Object> retVal = new HashMap<String, Object>();
		try {
			retVal.put("orderList", basketService.getOrderList(vo));
			retVal.put("orderListById", basketService.getOrderListById(vo));
			retVal.put("cntOrder", basketService.countOrder(vo));
			retVal.put("cntGroupById",basketService.cntGroupById(vo));
			retVal.put("res", "OK");
		}catch(Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal; 
	} 
	@GetMapping("/orderList")
	public void orderList(Model model) {
	}
}

