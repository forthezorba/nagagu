package org.nagagu.service;

import java.util.List;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.ReplyPageDTO;
import org.nagagu.domain.ReplyVO;
import org.nagagu.mapper.BoardAttachMapper;
import org.nagagu.mapper.BoardMapper;
import org.nagagu.mapper.ReplyMapper;
import org.nagagu.mapper.StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardmapper;
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	@Setter(onMethod_=@Autowired)
	private StoreMapper storemapper;
	
	@Override
	public List<BoardAttachVO> getAttachList(Long rno){
		return attachMapper.findByRno(rno);
	}
	
	@Override
	@Transactional
	public int register(ReplyVO vo) {
		log.info("register.."+vo);
		storemapper.updateReviewCnt(vo.getBno(), 1);
		
		int result = mapper.insertSelectKey(vo);
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> {
				log.info("attachList.."+attach);
				attach.setRno(vo.getRno());
				attachMapper.insert(attach);
			});
		}
		return result;
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("read.."+rno);
		return mapper.read(rno);
	}
	
	@Override
	@Transactional
	public int modify(ReplyVO vo) {
		log.info("modify.."+vo);
		
		attachMapper.deleteAllByRno(vo.getRno());
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> {
				attach.setRno(vo.getRno());
				attachMapper.insert(attach);
			});
		}
		return mapper.update(vo);
	}

	
	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove.."+rno);
		ReplyVO vo= mapper.read(rno);
		boardmapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get List.."+bno);
		return mapper.getListWithPaging(cri, bno);
	}
	@Override
	public List<ReplyVO> getListByReplyer(ReplyVO vo) {
		return mapper.getListByReplyer(vo);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(
				mapper.getCountByBno(bno), 
				mapper.getListWithPaging(cri, bno)
				);
	}

}
