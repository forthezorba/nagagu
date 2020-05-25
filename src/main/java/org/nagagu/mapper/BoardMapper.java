package org.nagagu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.nagagu.domain.BoardVO;
import org.nagagu.domain.Criteria;

public interface BoardMapper {
	public List<BoardVO> getList();
	public List<BoardVO> getListByWriter(BoardVO vo);
	public List<BoardVO> getListWithPaging(Criteria cri);
	public void insert(BoardVO board);
	public void insertSelectKey(BoardVO board);
	public BoardVO read(Long bno);
	public int updateCnt(Long bno);
	public int delete(Long bno);
	public int update(BoardVO board);
	public int getTotalCount(Criteria cri);
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	public List<BoardVO> getPics(String writer);
}
