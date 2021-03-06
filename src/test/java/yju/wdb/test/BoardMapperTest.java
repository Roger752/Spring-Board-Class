package yju.wdb.test;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import yju.wdb.domain.BoardVO;
import yju.wdb.domain.Criteria;
import yju.wdb.mapper.BoardMapper;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTest {
	Logger log = Logger.getLogger(BoardMapperTest.class);
	@Autowired
	private BoardMapper mapper;
	
//	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
		
	}
	
//	@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("새로 작성하느 글");
		vo.setContent("새로 작성하는 내용");
		vo.setWriter("newbie");
		
		mapper.insert(vo);
		
		log.info(vo);
	}
	
//	@Test
	public void testInsertSelectKey() {
		BoardVO vo = new BoardVO();
		vo.setTitle("새로 작성하느 글 select key");
		vo.setContent("새로 작성하는 내용 select key");
		vo.setWriter("newbie");
		
		mapper.insertSelectKey(vo);
		
		log.info(vo);
	}
	
//	@Test
	public void testRead() {
		BoardVO board = mapper.read(3);
		
		log.info(board);
	}
	
//	@Test
	public void testDelete() {
		log.info("DELETE COUNT: " + mapper.delete(2));
	}
	
//	@Test
	public void testUpdate() {
		BoardVO vo = new BoardVO();
		vo.setBno(1);
		vo.setTitle("새로 작성하느 글");
		vo.setContent("새로 작성하는 내용");
		vo.setWriter("newbie");
		
		log.info("UPDATE COUNT: " + mapper.update(vo));
	}
	
	@Test
	public void testPaging() {
		Criteria crt = new Criteria();
//		crt.setKeyword("새로");
//		crt.setType("TC");
//		crt.setPageNum(2);
//		crt.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(crt);
		
		list.forEach(board -> log.info(board));
	}
}
