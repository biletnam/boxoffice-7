package boxoffice.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import boxoffice.notice.model.NoticeDAO;
import boxoffice.notice.model.NoticeService;
import boxoffice.notice.model.NoticeVO;

@WebServlet(urlPatterns = "/notice/detail.do")
public class DetailNoticeController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NoticeService noticeDAO=NoticeDAO.getInstance();
		
		int n_id=Integer.parseInt(request.getParameter("n_id"));
		NoticeVO noticeVO=noticeDAO.detailNotice(n_id);
		
		request.setAttribute("noticeVO", noticeVO);
		request.setAttribute("url", request.getRequestURL().toString()+"?n_id="+n_id); 
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/notice/detailNotice.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}
}
