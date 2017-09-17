package boxoffice.notice.controller;

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
import boxoffice.notice.model.NoticeDAO;
import boxoffice.notice.model.NoticeService;
import boxoffice.notice.model.NoticeVO;

@WebServlet(urlPatterns = "/notice/select.do")
public class SelectNoticeController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String contextPath=request.getContextPath();		
		NoticeService noticeDAO = NoticeDAO.getInstance();
		PagingVO pagingVO=new PagingVO();
		try {

			String keyWord = request.getParameter("keyWord");
			String keyValue = request.getParameter("keyValue");
			String pageNum_temp = request.getParameter("pageNum");
			
			if (keyWord == null || keyWord == "") {
				keyWord = "n_id";
			}
			if (keyValue == null || keyValue == "") {
				keyValue = "";
			}
			
			pagingVO.setKeyWord(keyWord);
			pagingVO.setKeyValue(keyValue);

			int total=noticeDAO.selectNoticeCount(pagingVO);
			
			pagingVO.setPageNum_temp(pageNum_temp);//페이지번호
			//pagingVO.setRowNum(5);//페이지 row수
			//pagingVO.setPageBlock(3);//페이징 블럭 수
			pagingVO.setTotal(total);//게시물 수
			pagingVO=Paging.setPagingInfo(pagingVO);
			ArrayList<NoticeVO> list=noticeDAO.selectNotice(pagingVO);
			
			String search=contextPath+"/notice/select.do?keyWord="+keyWord+"&keyValue="+keyValue+"&pageNum=";
			request.setAttribute("total", total);
			request.setAttribute("list", list);
			request.setAttribute("search", search);
			request.setAttribute("pagingVO", pagingVO);
			request.setAttribute("url", request.getRequestURL().toString()); 
			
			RequestDispatcher dispatcher=request.getRequestDispatcher("/view/notice/selectNotice.jsp");
			dispatcher.forward(request, response);
			logger.info("[Info]");

		} catch (Exception e) {
			logger.error("[Error]", e);
		}		
	}	
}
