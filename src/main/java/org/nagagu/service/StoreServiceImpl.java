package org.nagagu.service;

import java.util.List;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.ProductVO;
import org.nagagu.domain.StoreCriteria;
import org.nagagu.mapper.BoardAttachMapper;
import org.nagagu.mapper.StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class StoreServiceImpl implements StoreService{
	@Setter(onMethod_=@Autowired)
	private StoreMapper mapper;
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	@Override
	public List<ProductVO> getList(StoreCriteria cri) {
		log.info("getProductList with criteria....");
		log.info(mapper.getListWithPaging(cri));
		log.info("cri..."+cri);
		return mapper.getListWithPaging(cri);
	}
	@Override
	public int getTotal(StoreCriteria cri) {
		log.info("get total count ");
		return mapper.getTotalCount(cri);
	}

	@Override
	public ProductVO get(Long bno) {
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
	public void register(ProductVO board) {
		log.info("register product.."+board);
		
		log.info(board);
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
	public boolean modify(ProductVO board) {
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
		//replyMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
	}
}
