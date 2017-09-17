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

import boxoffice.common.util.Paging;
import boxoffice.common.util.PagingVO;
import boxoffice.movie.model.MovieDAO;
import boxoffice.movie.model.MovieService;
import boxoffice.movie.model.MovieVO;

@WebServlet(urlPatterns = "/movie/select.do")
public class SelectMovieController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String contextPath=request.getContextPath();		
		MovieService movieDAO=MovieDAO.getInstance();
		MovieVO movieVO=new MovieVO();
		PagingVO pagingVO=new PagingVO();
			
		String keyWord = request.getParameter("keyWord");
		String keyValue = request.getParameter("keyValue");
		String pageNum_temp = request.getParameter("pageNum");
		
		if (keyWord == null || keyWord == "") {
			keyWord = "m_id";
		}
		if (keyValue == null || keyValue == "") {
			keyValue = "";
		}
		
		pagingVO.setKeyWord(keyWord);
		pagingVO.setKeyValue(keyValue);
		
		int total=movieDAO.selectMovieCount(pagingVO);
		
		pagingVO.setPageNum_temp(pageNum_temp);
		pagingVO.setTotal(total);
		pagingVO=Paging.setPagingInfo(pagingVO);
		
		ArrayList<MovieVO> list=movieDAO.selectMovie(movieVO, pagingVO);

		String search=contextPath+"/movie/select.do?keyWord="+keyWord+"&keyValue="+keyValue+"&pageNum=";
		request.setAttribute("total", total);
		request.setAttribute("list", list);
		request.setAttribute("search", search);
		request.setAttribute("pagingVO", pagingVO);
		request.setAttribute("url", request.getRequestURL().toString()); 
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/movie/selectMovie.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}	
}
