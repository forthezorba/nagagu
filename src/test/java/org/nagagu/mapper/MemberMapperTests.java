package org.nagagu.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.nagagu.domain.AuthVO;
import org.nagagu.domain.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"
		})
@Log4j
public class MemberMapperTests {
	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Test
	public void testInsert() {
	  MemberVO list = new MemberVO();
	  
	  //list.setMember_id("admin");
	  
	  AuthVO auth = new AuthVO();
	  List<AuthVO> authList = new ArrayList<>();
	  auth.setAuth("ROLE_MEMBER");
	  authList.add(0, auth);
	  auth.setAuth("ROLE_ADMIN"); 
	  authList.add(1, auth);
	  log.info(authList);
	  //list.setAuthList(auth);
	 // mapper.insert_member(list);
	}
	
	@Test
	public void testRead() {
		MemberVO vo= mapper.read("admin90");
		log.info(vo);
		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
	
	@Test
	public void emailchk() {
		MemberVO vo = new MemberVO();
		//vo.setMember_email("1@email.com");
		int chk= mapper.email_chk(vo);
		log.info("chk....."+chk);
		//vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
	
}
