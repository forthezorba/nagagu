package org.nagagu.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.nagagu.domain.BoardVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.FollowVO;
import org.nagagu.domain.LikeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	@Setter(onMethod_=@Autowired)
	private LikeMapper likemapper;
	
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		BoardVO board= new BoardVO();
		board.setTitle("새글");
		board.setContent("새내용");
		board.setWriter("newbie");
		
		mapper.insert(board);
		log.info(board);
	}
	@Test
	public void testRead() {
		BoardVO board = mapper.read(310L);
		log.info(board);
	}
	@Test
	public void testDelete() {
		log.info("delete count"+mapper.delete(309L));
	}
	@Test
	public void testPaging() {
		Criteria cri=new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVO> list=mapper.getListWithPaging(cri);
		list.forEach(board-> log.info(board.getBno()));
	}
	
	@Test
	public void getLikeList() {
	FollowVO vo = new FollowVO();
	vo.setFollow_from("admin90");
	vo.setFollow_to("user0");
	log.info("serviceimpl likelist...."+likemapper.getFollowList(vo));
	List<Map<String, Object>> list  = likemapper.getFollowList(vo);
	log.info(list);
	//list.forEach(board-> log.info(board));
	}
	@Test
	public void insertFollow() {
		FollowVO vo = new FollowVO();
		vo.setFollow_from("hwanghkt@naver.com");
		vo.setFollow_to("user00");
		
		log.info("serviceimpl FollowVO...."+likemapper.insertFollow(vo));
		log.info(likemapper.insertFollow(vo));
		//list.forEach(board-> log.info(board));
	}
	
	@Test
	public void testSearch() {
		Criteria cri=new Criteria();
		cri.setKeyword("tt");
		cri.setType("T");
		cri.setIsReview(0);
		cri.setCategory("all");
		//cri.setSort("likeCnt");
		List<BoardVO> list= mapper.getListWithPaging(cri);
		log.info(cri);
		list.forEach(board-> log.info(board));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board= new BoardVO();
		board.setBno(509L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user000");
		
		int count = mapper.update(board);
		log.info("update count="+count);
	}
	
}
