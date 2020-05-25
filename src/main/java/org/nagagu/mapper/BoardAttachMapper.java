package org.nagagu.mapper;

import java.util.List;

import org.nagagu.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public int insert(BoardAttachVO vo);
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(Long bno);
	public List<BoardAttachVO> findByRno(Long rno);
	public void deleteAll(Long bno);
	public void deleteAllByRno(Long rno);
	public List<BoardAttachVO> getOldFiles();
}
