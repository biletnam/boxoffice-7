package boxoffice.movie.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import boxoffice.common.util.Paging;
import boxoffice.common.util.PagingVO;
import boxoffice.movie.model.MovieDAO;
import boxoffice.movie.model.MovieService;
import boxoffice.movie.model.MovieVO;
import boxoffice.movie.model.ReplyService;
import boxoffice.movie.model.ReplyVO;

@WebServlet(urlPatterns = "/movie/detail.do")
public class DetailMovieController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String contextPath=request.getContextPath();

		HttpSession session = request.getSession();
		MovieService movieDAO=MovieDAO.getInstance();
		ReplyService replyDAO=MovieDAO.getInstance();
		ReplyVO replyVO=new ReplyVO();
		PagingVO pagingVO=new PagingVO();

		int m_id=Integer.parseInt(request.getParameter("m_id"));
		String m_re_nickname=(String)session.getAttribute("naver_nickname");
		String pageNum_temp = request.getParameter("pageNum");
		
		replyVO.setM_id(m_id);
		replyVO.setM_re_nickname(m_re_nickname);
		
		MovieVO movieVO=movieDAO.detailMovie(m_id);

		int reply_search_total=replyDAO.selectMovieReplySearchCount(replyVO);
		int reply_total=replyDAO.selectMovieReplyCount(replyVO);
		pagingVO.setPageNum_temp(pageNum_temp);//페이지번호
		pagingVO.setRowNum(5);//페이지 row수
		pagingVO.setTotal(reply_total);//게시물 수
		pagingVO=Paging.setPagingInfo(pagingVO);
		ArrayList<ReplyVO> reply_list=replyDAO.selectMovieReply(replyVO, pagingVO);
		
		int starAvg=replyDAO.selectMovieReplyStarAvg(m_id);
		
		String search=contextPath+"/movie/detail.do?m_id="+m_id+"&pageNum=";

		request.setAttribute("movieVO", movieVO);
		request.setAttribute("reply_search_total", reply_search_total);
		request.setAttribute("reply_total", reply_total);
		request.setAttribute("starAvg", starAvg);
		request.setAttribute("reply_list", reply_list);
		request.setAttribute("search", search);
		request.setAttribute("pageNum", pagingVO.getPageNum());
		request.setAttribute("pageBlock", pagingVO.getPageBlock());
		request.setAttribute("pageCount", pagingVO.getPageCount());
		request.setAttribute("endPage", pagingVO.getEndPage());
		request.setAttribute("startPage", pagingVO.getStartPage());
		request.setAttribute("url", request.getRequestURL().toString()+"?m_id="+m_id); 
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/movie/detailMovie.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}
}
