package org.nagagu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.nagagu.domain.MemberVO;
import org.nagagu.domain.ProductVO;
import org.nagagu.domain.StoreCriteria;

public interface StoreMapper {
	public List<ProductVO> getList();
	public List<ProductVO> getListWithPaging(StoreCriteria cri);
	public void insert(ProductVO product);
	public void insertSelectKey(ProductVO product);
	public ProductVO read(Long bno);
	public int updateCnt(Long bno);
	public int delete(Long bno);
	public int update(ProductVO product);
	public int getTotalCount(StoreCriteria cri);
	public void updateReviewCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	public void member_edit_update(MemberVO vo); 
	
}
