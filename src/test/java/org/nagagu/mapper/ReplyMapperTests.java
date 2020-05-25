package org.nagagu.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	private Long[] bnoArr= {1L,2L,3L};
	
	@Test
	public void testRead() {

		Long targetRno = 237L;

		ReplyVO vo = mapper.read(targetRno);

		log.info(vo);

	}
/*
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1,10).forEach(i -> {
			ReplyVO vo=new ReplyVO();
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글 테스트"+i);
			vo.setReplyer("replyer"+i);
			
			mapper.insert(vo);
		});
	}
*/
	@Test
	public void testList2() {
		Criteria cri=new Criteria(2,10);
		List<ReplyVO> replies=mapper.getListWithPaging(cri, 1L);
		replies.forEach(reply-> log.info(reply));
	}
}
