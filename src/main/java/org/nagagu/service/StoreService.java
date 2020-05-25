package org.nagagu.service;

import java.util.List;

import org.nagagu.domain.BoardAttachVO;
import org.nagagu.domain.ProductVO;
import org.nagagu.domain.StoreCriteria;

public interface StoreService {
	public void register(ProductVO board);
	public ProductVO get(Long bno);
	public boolean modify(ProductVO board);
	public boolean remove(Long bno);
	public List<ProductVO> getList(StoreCriteria cri);
	public int getTotal(StoreCriteria cri);
	public List<BoardAttachVO> getAttachList(Long bno);
}
