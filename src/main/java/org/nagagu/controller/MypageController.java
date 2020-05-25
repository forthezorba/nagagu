package org.nagagu.controller;


import org.nagagu.domain.BoardVO;
import org.nagagu.domain.FollowVO;
import org.nagagu.domain.LikeVO;
import org.nagagu.service.CommunityService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Controller
@Log4j
@RequestMapping("/mypage/*")
@AllArgsConstructor
public class MypageController {
	private CommunityService service; 
	@GetMapping("/mypage")
	public void mypage(Model model,BoardVO vo) { 
	}
	@GetMapping("/edit")
	public void edit(Model model,BoardVO vo) { 
	}
	@GetMapping("/like")
	public void like(Model model,BoardVO vo) { 
	}
	@GetMapping("/picture")
	public void picture(Model model,BoardVO vo) { 
	}
	@GetMapping("/review")
	public void review(Model model,BoardVO vo) { 
	}
	@GetMapping("/reply")
	public void reply(Model model,BoardVO vo) { 
	}
	
	@GetMapping("/other")
	public void other(Model model,BoardVO vo) {
		log.info("other.."+vo);
		model.addAttribute("list",service.getListByWriter(vo));
		LikeVO like = new LikeVO();
		like.setLike_member(vo.getWriter());
		model.addAttribute("likeList",service.getLikeList(like));
		log.info("like..."+service.getLikeList(like));
	}
	@GetMapping("/follow")
	public void follow(Model model,BoardVO vo) { 
		log.info("other.."+vo);
		model.addAttribute("list",service.getListByWriter(vo));
		FollowVO follow = new FollowVO();
		follow.setFollow_from(vo.getWriter());
		follow.setFollow_to(vo.getWriter());
		model.addAttribute("followList",service.getFollowList(follow));
		log.info("follow...."+service.getFollowList(follow));
		model.addAttribute("followedList",service.getFollowedList(follow));
		log.info("followed...."+service.getFollowedList(follow));
	}
}
