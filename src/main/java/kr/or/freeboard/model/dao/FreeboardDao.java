package kr.or.freeboard.model.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.freeboard.model.vo.Freeboard;
import kr.or.freeboard.model.vo.FreeboardComment;
import kr.or.freeboard.model.vo.FreeboardFile;
import kr.or.freeboard.model.vo.FreeboardLike;

@Repository
public class FreeboardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Freeboard> selectFreeList(HashMap<String, Object> map) {
		List<Freeboard> list = sqlSession.selectList("freeboard.freeList", map);
		return (ArrayList<Freeboard>) list;
	}

	public int selectTotalCount() {
		int totalCount = sqlSession.selectOne("freeboard.totalCount");
		return totalCount;
	}

	public ArrayList<FreeboardComment> selectCommentList(int freeNo) {
		List<FreeboardComment> commentList = sqlSession.selectList("freeboard.commentList", freeNo);
		return (ArrayList<FreeboardComment>) commentList;
	}

	public ArrayList<FreeboardFile> selectFileList(int freeNo) {
		List<FreeboardFile> fileList = sqlSession.selectList("freeboard.fileList", freeNo);
		return (ArrayList<FreeboardFile>) fileList;
	}

	public Freeboard selectOneFree(int freeNo) {
		Freeboard fb = sqlSession.selectOne("freeboard.selectOneFree", freeNo);
		return fb;
	}

	public int insertFreeboardLike(HashMap<String, Object> map) {
		int result = sqlSession.insert("freeboard.freeboardLike", map);
		return result;
	}

	public int selectOneFreeLike(HashMap<String, Object> map) {
		int result = sqlSession.selectOne("freeboard.oneFreeLike", map);
		return result;
	}

	public int insertFreeboardComment(FreeboardComment fc) {
		int result = sqlSession.insert("freeboard.freeboardComment", fc);
		return result;
	}

	public int readCountUpdate(int freeNo) {
		int result = sqlSession.update("freeboard.rcUpdate", freeNo);
		return result;
	}

	public int deleteFreeboardComment(int fcNo) {
		int result = sqlSession.delete("freeboard.delFreeboardComment", fcNo);
		return result;
	}

	public int updateFreeboardComment(HashMap<String, Object> map) {
		int result = sqlSession.update("freeboard.updateFreeboardComment", map);
		return result;
	}


	public ArrayList<FreeboardLike> selectFcLikeList(HashMap<String, Object> map) {
		List<FreeboardLike> list = sqlSession.selectList("freeboard.selectFcLikeList", map);
		return (ArrayList<FreeboardLike>) list;
	}

	public int insertFcLike(HashMap<String, Object> map) {
		int result = sqlSession.insert("freeboard.insertFcLike", map);
		return result;
	}

	public int insertFreeboard(Freeboard f) {
		int result = sqlSession.insert("freeboard.insertFree", f);
		return result;
	}

	public int insertFreeboardFile(FreeboardFile ff) {
		int result = sqlSession.insert("freeboard.insertFreeFile", ff);
		return result;
	}

	public int selectFreeNo(Freeboard f) {
		int freeNo = sqlSession.selectOne("freeboard.selectFreeNo", f);
		return freeNo;
	}

	public ArrayList<Freeboard> searchFreeList(HashMap<String, Object> map) {
		List<Freeboard> searchList = sqlSession.selectList("freeboard.searchList", map);
		return (ArrayList<Freeboard>) searchList;
	}

	public int selectTotalCount(String searchtype, String searchword) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("searchtype", searchtype);
		map.put("searchword", searchword);
		int totalCount = sqlSession.selectOne("freeboard.searchCount", map);
		return totalCount;
	}

	public FreeboardFile getFreeboardFile(int ffNo) {
		FreeboardFile ff = sqlSession.selectOne("freeboard.selectFreeboardFile", ffNo);
		return ff;
	}

	public int updateFreeboard(Freeboard fb) {
		int result = sqlSession.update("freeboard.updateFreeboard", fb);
		return result;
	}

	public int updateFreeboardFile(HashMap<String, Object> map) {
		int result = sqlSession.update("freeboard.updateFreeboardFile", map);
		return result;
	}

	public int deleteFreeboardFile(int freeNo) {
		int result = sqlSession.delete("freeboard.deleteFreeboardFile", freeNo);
		return result;
	}

	public int deleteFcLike(HashMap<String, Object> map) {
		int result = sqlSession.delete("freeboard.deleteFcLike", map);
		return result;
	}
}
