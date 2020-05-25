package org.nagagu.controller;

import java.io.File;

import org.aspectj.lang.annotation.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.nagagu.domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
	("file:src/main/webapp/WEB-INF/spring/root-context.xml"),
	("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")	
})
@Log4j
public class BoardControllerTests {
	@Setter(onMethod_=@Autowired)
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@org.junit.Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		String img = "https://nagagu.s3.ap-northeast-2.amazonaws.com/cm/2020-04-15/45c02d8a-f5f3-40ac-a9a0-4154d6402064_puppy3.jpg";
		String imgName = (img).replace(File.separatorChar, '/');
	    log.info("img..."+imgName);
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/community/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}

	@Test
	public void testRegister()throws Exception{
		String resultPage=mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "테스트 새글 제목")
				.param("content", "테스트 새글 내용")
				.param("writer", "user")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	@Test
	public void testGet() throws Exception{
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
						.param("bno", "327"))
				.andReturn().getModelAndView().getModelMap()
				);
	}
	@Test
	public void testModify()throws Exception{
		String resultPage=mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", "327")
				.param("title", "수정 테스트 새글 제목")
				.param("content", "수정 테스트 새글 내용")
				.param("writer", "user11")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	@Test
	public void testRemove()throws Exception{
		String resultPage=mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "310")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	@Test
	public void testListWithPaging() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
						.param("pageNum", "2")
						.param("amount", "50")
						)
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
}
