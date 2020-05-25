package org.nagagu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.nagagu.domain.Criteria;
import org.nagagu.domain.ReplyVO;

public interface ReplyMapper {
	public void insert(ReplyVO vo);
	public int insertSelectKey(ReplyVO vo);
	public ReplyVO read(Long rno);
	public int delete(Long rno);
	public int deleteAll(Long bno);
	public int update(ReplyVO reply);
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno
			);
	public List<ReplyVO> getListByReplyer(ReplyVO vo);
	public int getCountByBno(Long bno);
	
}
