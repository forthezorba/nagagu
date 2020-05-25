package org.nagagu.service;

import java.util.List;
import java.util.Map;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.BoardVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.FollowVO;
import org.nagagu.domain.LikeVO;
import org.nagagu.mapper.BoardAttachMapper;
import org.nagagu.mapper.BoardMapper;
import org.nagagu.mapper.LikeMapper;
import org.nagagu.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CommunityServiceImpl implements CommunityService{
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	@Setter(onMethod_=@Autowired)
	private ReplyMapper replyMapper;
	@Setter(onMethod_=@Autowired)
	private LikeMapper likeMapper;
	@Override
	public BoardVO get(Long bno) {
		log.info("get............"+bno);
		mapper.updateCnt(bno);
		return mapper.read(bno);
	}
	@Override
	public List<BoardAttachVO> getAttachList(Long bno){
		return attachMapper.findByBno(bno);
	}

	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register.."+board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {    
		log.info("getList with criteria....");
		return mapper.getListWithPaging(cri);
	}
	@Override
	public List<BoardVO> getListByWriter(BoardVO vo) {
		log.info("getList with writer....");
		return mapper.getListByWriter(vo);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count ");
		return mapper.getTotalCount(cri);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify...."+board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board)==1;
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("delete...."+bno);
		attachMapper.deleteAll(bno);
		replyMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
	}
	
	@Override
	public int insertLike(LikeVO vo){
		//DB에 없으면 insert, 있으면 Delete후 0반환
		if(likeMapper.cntLike(vo)!=1) {
			likeMapper.insertLike(vo);
			return likeMapper.updateBnoLike(1,vo.getLike_bno());
		}else {
			likeMapper.deleteLike(vo);
			return likeMapper.updateBnoLike(-1,vo.getLike_bno());
		}
	}
	@Override
	public int cntBnoLike(LikeVO vo) {
		//특정 게시물 좋아요 수
		log.info(likeMapper.cntBnoLike(vo));
		return likeMapper.cntBnoLike(vo);
	}
	@Override
	public List<Map<String, Object>> getLikeList(LikeVO vo) {
		//로그인 회원의 좋아요 리스트
		return likeMapper.getLikeList(vo);
	}
	@Override
	public List<Map<String, Object>> getFollowList(FollowVO vo) {
		//로그인 회원의 좋아요 리스트
		return likeMapper.getFollowList(vo);
	}
	@Override
	public List<Map<String, Object>> getFollowedList(FollowVO vo) {
		//로그인 회원의 좋아요 리스트
		return likeMapper.getFollowedList(vo);
	}
	@Override
	public int insertFollow(FollowVO vo) {
		//DB에 없으면 insert 1, 있으면 Delete후 0반환
		log.info("impl.."+vo);
		log.info(likeMapper.cntFollow(vo));
		if(likeMapper.cntFollow(vo)!=1) {
			likeMapper.insertFollow(vo);
			return 1;
		}else {
			likeMapper.deleteFollow(vo);
			return 0;
		}
	}
	@Override
	public List<BoardVO> getPics(String writer) {
		return mapper.getPics(writer);
	}
}
