package yju.wdb.mapper;

import java.util.List;

import yju.wdb.domain.BoardVO;
import yju.wdb.domain.Criteria;

public interface BoardMapper {
	
//	@Select("select * from tb1_board")
	public List<BoardVO> getList();
	
	public void insert(BoardVO vo);
	
	public void insertSelectKey(BoardVO vo);
	
	public BoardVO read(int bno);
	
	public int delete(int bno);
	
	public int update(BoardVO vo);
	
	public List<BoardVO> getListWithPaging(Criteria crt);
	
	public int getTotalCount(Criteria crt);
}