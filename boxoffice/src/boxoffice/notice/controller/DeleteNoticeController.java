package boxoffice.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import boxoffice.notice.model.NoticeDAO;
import boxoffice.notice.model.NoticeService;

@WebServlet(urlPatterns = "/notice/delete.do")
public class DeleteNoticeController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NoticeService noticeDAO=NoticeDAO.getInstance();
		HttpSession session = request.getSession();
		String contextPath=request.getContextPath();

		int n_id=Integer.parseInt(request.getParameter("n_id"));
		
		if(session.getAttribute("sessionID").equals("admin")){
			boolean flags=noticeDAO.deleteNotice(n_id);
			if(flags==true){
				response.sendRedirect(contextPath+"/notice/select.do");
			}else{
				response.sendRedirect(contextPath+"/main.do");
			}
			logger.info("[Info]"+flags);
		}else{
			response.sendRedirect(contextPath+"/error/403code.html");
		}
	}	
}
