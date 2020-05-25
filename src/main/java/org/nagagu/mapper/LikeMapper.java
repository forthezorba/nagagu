package org.nagagu.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.nagagu.domain.FollowVO;
import org.nagagu.domain.LikeVO;

public interface LikeMapper {
	int insertLike(LikeVO vo);
	int deleteLike(LikeVO vo);
	int cntLike(LikeVO vo);//멤버 특정 게시물like
	int updateLike(LikeVO vo);
	int updateBnoLike(
			@Param("amount") int amount,
			@Param("bno") int bno);
	int cntBnoLike(LikeVO vo);//게시물 like수
	public List<Map<String, Object>> getLikeList(LikeVO vo);
	public List<Map<String, Object>> getFollowList(FollowVO vo);
	public List<Map<String, Object>> getFollowedList(FollowVO vo);
	
	int insertFollow(FollowVO vo);
	int cntFollow(FollowVO vo);//특정 멤버 like
	int deleteFollow(FollowVO vo);
}
