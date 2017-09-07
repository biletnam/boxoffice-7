package boxoffice.banner.controller;

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

import boxoffice.banner.model.BannerDAO;
import boxoffice.banner.model.BannerService;
import boxoffice.banner.model.BannerVO;

@WebServlet("/banner/select.do")
public class BannerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());
	BannerService service=BannerDAO.getInstance();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String contextPath=request.getContextPath();

		//배너목록
		ArrayList<BannerVO> list=service.selectBanner();
		
		request.setAttribute("list", list);
		
		if(session.getAttribute("sessionID")==null){
			response.sendRedirect(contextPath+"/error/403code.html");
		}else{
			RequestDispatcher dispatcher=request.getRequestDispatcher("/view/banner/selectBanner.jsp");
			dispatcher.forward(request, response);
		}
		logger.info("[Info]");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String contextPath=request.getContextPath();
		String id=request.getParameter("banner_id");
		service.deleteBanner(id);
		response.sendRedirect(contextPath+"/banner/select.do");
	}
}
