package org.nagagu.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.PageDTO;
import org.nagagu.domain.ProductVO;
import org.nagagu.domain.StoreCriteria;
import org.nagagu.service.StoreService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/store/*")
@AllArgsConstructor
public class StoreController{
	private StoreService service;
	private final S3Uploader s3Uploader;
	
	@GetMapping("/entry")
	public void entry() {
		log.info("entry...");
	}

	
	@GetMapping("/list")
	public void list(Model model, StoreCriteria cri) {
		log.info("list.."+cri);
		model.addAttribute("list",service.getList(cri));
		int total= service.getTotal(cri);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
	}
	
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno,@ModelAttribute("store_cri") StoreCriteria cri,Model model) {
		log.info("/get or modify");
		log.info("get.."+cri);
		model.addAttribute("board",service.get(bno));
	}
	
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_WORKSHOP')")
	public void register() {
	}
	
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_WORKSHOP')") 
	public String register(ProductVO board, RedirectAttributes rttr) {
		log.info("register.."+board);
		service.register(board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		rttr.addFlashAttribute("result",board.getBno());
		return "redirect:/store/list"; 
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(ProductVO board, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		log.info("modify.."+board);
		log.info(service.modify(board));
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");	
		}
		return "redirect:/store/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri, 
			RedirectAttributes rttr, String writer) {
		log.info("remove.."+bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {
			deletefiles(attachList);
			rttr.addFlashAttribute("result","success");	
		}
		return "redirect:/store/list" + cri.getListLink();
	}
	//s3 파일 지우기
	private void deletefiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("attachlist "+attachList);
		
		attachList.forEach(attach -> {
			try {
				s3Uploader.deleteFile(attach.getFileName());
			}catch(Exception e) {
				e.printStackTrace();
			}
		});
	}
	
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList ....");
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
}