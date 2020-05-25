package org.nagagu.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.nagagu.domain.BoardVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.ProductVO;
import org.nagagu.domain.StoreCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreMapperTests {
	@Setter(onMethod_=@Autowired)
	private StoreMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(product -> log.info(product));
	}
	
	@Test
	public void testInsert() {
		ProductVO board= new ProductVO();
		board.setTitle("상품제목");
		board.setWorkshopName("workshop name");
		mapper.insert(board);
		log.info(board);
	}
	
	@Test
	public void testRead() {
		ProductVO board = mapper.read(2L);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("delete count"+mapper.delete(7L));
	}
	@Test
	public void testPaging() {
		StoreCriteria cri=new StoreCriteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<ProductVO> list=mapper.getListWithPaging(cri);
		list.forEach(board-> log.info(board.getBno()));
	}
	
	@Test
	public void testSearch() {
		StoreCriteria cri=new StoreCriteria();
		cri.setKeyword("제목");
		cri.setType("T");
		cri.setCategory("all");
		//cri.setSort("likeCnt");
		List<ProductVO> list= mapper.getListWithPaging(cri);
		log.info(cri);
		list.forEach(board-> log.info(board));
	}
	
	@Test
	public void testUpdate() {
		ProductVO board= new ProductVO();
		board.setBno(263L);
		board.setTitle("수정된 제목");
		board.setCategory("bed");
		board.setWorkshopName("gongbang123");
		
		int count = mapper.update(board);
		log.info("update count="+count);
	}
	
}
