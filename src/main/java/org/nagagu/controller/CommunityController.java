package org.nagagu.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.BoardVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.FollowVO;
import org.nagagu.domain.LikeVO;
import org.nagagu.domain.PageDTO;
import org.nagagu.domain.ProductVO;
import org.nagagu.domain.ReplyVO;
import org.nagagu.service.CommunityService;
import org.nagagu.service.ReplyService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/community/*")
@AllArgsConstructor
public class CommunityController{
	private CommunityService service;
	private StoreService storeService;
	private ReplyService replyService;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri){
		log.info("list.."+cri);
		model.addAttribute("list",service.getList(cri));
		int total= service.getTotal(cri);
		
		model.addAttribute("pageMaker",new PageDTO(cri,total));
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri,Model model){
		log.info("/get or modify");
		log.info("get.."+cri);
		BoardVO board = service.get(bno);
		
		model.addAttribute("board",board);
		model.addAttribute("pics",service.getPics(board.getWriter()));
		log.info(service.getPics(board.getWriter()));
		if(board.getProductNo()!=null) {
			log.info(board.getProductNo());
			ProductVO vo = storeService.get(board.getProductNo());
			log.info(vo);
			model.addAttribute("product",vo); 
		} 
		
		int total= service.getTotal(cri);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
	}
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		log.info("modify.."+board);
		log.info(service.modify(board));
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");	
		}
		return "redirect:/community/list" + cri.getListLink();
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
		return "redirect:/community/list" + cri.getListLink();
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr){
		log.info("register.."+board);
		service.register(board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		rttr.addFlashAttribute("result",board.getBno());
		return "redirect:/community/list"; 
	}
	
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList ....");
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	private void deletefiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("attachlist "+attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\project138\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\project138\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		});;
	}
	//사진 좋아요 누르기 insert(좋아요 or 좋아요 삭제 후 게시물 좋아요 갯수 반환)
		@RequestMapping(value = "/insertLike")
		public ResponseEntity<Integer> insertLike(LikeVO likeVO) {
			log.info("insertLike..."+likeVO);
			return service.insertLike(likeVO)==1
					? new ResponseEntity<>(service.cntBnoLike(likeVO),HttpStatus.OK)
					: new ResponseEntity<>(0,HttpStatus.OK);
		} 
		
		@RequestMapping(value = "/insertFollow")
		public ResponseEntity<String> insertFollow(FollowVO vo) {
			log.info("followAction컨트롤러 시작"+vo);
			return	service.insertFollow(vo)==1
						? new ResponseEntity<String>("INSERT",HttpStatus.OK)
						: new ResponseEntity<String>("DELETE",HttpStatus.OK);
		} 
		//로그인멤버 좋아요 리스트 get
		@RequestMapping(value = "/getLikeList")
		public @ResponseBody List<Map<String, Object>> getLikeList(LikeVO vo){
			//log.info("getLikeList..."+service.getLikeList(vo));
			return service.getLikeList(vo);
		}
		@RequestMapping(value = "/getFollowList")
		public @ResponseBody List<Map<String, Object>> getFollowList(FollowVO vo) {
			//log.info("getFollowList..."+service.getFollowList(vo));
			return service.getFollowList(vo);
		} 
		@RequestMapping("/getUploadPics")
		public @ResponseBody List<BoardVO> getLikeList(BoardVO vo){
			log.info("other.."+vo);
			return service.getListByWriter(vo);
		}
		@RequestMapping(value="/getListByReplyer")
		public @ResponseBody List<ReplyVO> getListByReplyer(ReplyVO vo){ 
			log.info("getListByReplyer........................"+vo);
			return replyService.getListByReplyer(vo);
		}
	
}