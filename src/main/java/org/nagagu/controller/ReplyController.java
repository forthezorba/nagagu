package org.nagagu.controller;

import java.util.List;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.ReplyPageDTO;
import org.nagagu.domain.ReplyVO;
import org.nagagu.service.CommunityService;
import org.nagagu.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/replies/")
@AllArgsConstructor
public class ReplyController { 
	private ReplyService service;
	private CommunityService communityService;
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new",consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO: "+vo);
		
		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT: " + insertCount);
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> log.info(attach));
		}
		
		return insertCount==1? new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		return new ResponseEntity<>(communityService.getAttachList(bno), HttpStatus.OK);
	}
	
	@GetMapping(value="/getAttachListByRno", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachListByRno(Long rno){
		return new ResponseEntity<>(service.getAttachList(rno), HttpStatus.OK);
	}
	
	@GetMapping(value="/pages/{bno}/{page}",
			produces= {
					MediaType.APPLICATION_ATOM_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno){ 
		log.info("getReplyList........................");
		log.info("bno........................"+bno);
		Criteria cri= new Criteria(page,10);
		log.info(cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK);
	}                        
	
	@GetMapping(value="/{rno}",
			produces= {
					MediaType.APPLICATION_ATOM_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno)
	{
		log.info("get........................");
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	} 
	
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value="/{rno}",	produces= {	MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno, @RequestBody ReplyVO vo)
	{
		log.info("remove........................"+vo.getRno());
		log.info("replyer.."+vo.getReplyer());
		return service.remove(rno)==1 
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{rno}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno,RedirectAttributes rttr){
		log.info("rno: "+rno);
		log.info("modify: "+vo);
		if(service.modify(vo)==1) {
			rttr.addFlashAttribute("result","success");	
		}
		
		
		return service.modify(vo)==1? new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
