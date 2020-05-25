package org.nagagu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.BoardVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.FollowVO;
import org.nagagu.domain.LikeVO;

public interface CommunityService {
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public List<BoardVO> getList(Criteria cri);
	public List<BoardVO> getListByWriter(BoardVO board);
	
	public int getTotal(Criteria cri);
	public List<BoardAttachVO> getAttachList(Long bno);
	
	public int insertLike(LikeVO vo);
	public int cntBnoLike(LikeVO vo);
	public List<Map<String, Object>> getLikeList(LikeVO vo);
	public List<Map<String, Object>> getFollowList(FollowVO vo);
	public List<Map<String, Object>> getFollowedList(FollowVO vo);
	
	public int insertFollow(FollowVO vo);
	
	public List<BoardVO> getPics(String writer);
//	ArrayList<Map<String, Object>> getLoginMemberReply(HashMap<String, Object> map);//마이페이지에서 내 댓글리스트
}
