package org.nagagu.service;

import java.util.List;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.ReplyPageDTO;
import org.nagagu.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo);
	public ReplyVO get(Long rno);
	public int modify(ReplyVO vo);
	public int remove(Long rno);
	public List<ReplyVO> getList(Criteria cri, Long bno);
	public ReplyPageDTO getListPage(Criteria cri, Long bno);//카운트와 리스트 받아오기
	public List<ReplyVO> getListByReplyer(ReplyVO vo);//카운트와 리스트 받아오기
	
	public List<BoardAttachVO> getAttachList(Long rno);
}
