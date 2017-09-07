package boxoffice.movie.model;

import java.util.ArrayList;

import boxoffice.common.util.PagingVO;

public interface ReplyService {
	
	//select
	public ArrayList<ReplyVO> selectMovieReply(ReplyVO replyVO, PagingVO pagingVO);
	
	//select count
	public int selectMovieReplyCount(ReplyVO replyVO);
	
	//select star avg
	public int selectMovieReplyStarAvg(int m_id);
	
	//select search count
	public int selectMovieReplySearchCount(ReplyVO replyVO);
	
	//insert
	public boolean insertMovieReply(ReplyVO replyVO);
	
	//delete
	public boolean deleteMovieReply(int m_re_id);
	
	//update
	public boolean updateMovieReply(ReplyVO replyVO);
}
