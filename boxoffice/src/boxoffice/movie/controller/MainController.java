package boxoffice.movie.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import boxoffice.banner.model.BannerDAO;
import boxoffice.banner.model.BannerService;
import boxoffice.banner.model.BannerVO;
import boxoffice.common.util.Paging;
import boxoffice.common.util.PagingVO;
import boxoffice.movie.model.MovieDAO;
import boxoffice.movie.model.MovieService;
import boxoffice.movie.model.MovieVO;
import boxoffice.notice.model.NoticeDAO;
import boxoffice.notice.model.NoticeService;
import boxoffice.notice.model.NoticeVO;

@WebServlet(urlPatterns = "/main.do")
public class MainController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		NoticeService noticeDAO = NoticeDAO.getInstance();
		MovieService movieDAO = MovieDAO.getInstance();
		BannerService bannerDAO = BannerDAO.getInstance();
		PagingVO pagingVO=new PagingVO();

		pagingVO.setKeyWord("n_id");
		pagingVO.setKeyValue("");
		
		int total=noticeDAO.selectNoticeCount(pagingVO);
		pagingVO.setRowNum(3);//페이지 row수
		pagingVO.setTotal(total);//게시물 수
		pagingVO=Paging.setPagingInfo(pagingVO);
		
		ArrayList<NoticeVO> noticeList=noticeDAO.selectNotice(pagingVO);
		ArrayList<MovieVO> movieList=movieDAO.selectMovie(new MovieVO());
		ArrayList<BannerVO> bannerList=bannerDAO.selectBanner();

		request.setAttribute("noticeList", noticeList);
		request.setAttribute("movieList", movieList);
		request.setAttribute("bannerList", bannerList);
		
		String spath = request.getServletPath();  
		String url = request.getRequestURL().toString(); 
		logger.info("[Info]"+spath);
		logger.info("[Info]"+url);
		request.setAttribute("url", url); 
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");	
	}	
}
