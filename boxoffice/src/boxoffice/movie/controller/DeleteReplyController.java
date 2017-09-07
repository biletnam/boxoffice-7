package boxoffice.movie.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import boxoffice.movie.model.MovieDAO;
import boxoffice.movie.model.ReplyService;

@WebServlet(urlPatterns = "/movie/deleteReply.do")
public class DeleteReplyController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReplyService replyDAO=MovieDAO.getInstance();
		HttpSession session = request.getSession();
		String contextPath=request.getContextPath();

		int m_id=Integer.parseInt(request.getParameter("m_id"));
		int m_re_id=Integer.parseInt(request.getParameter("m_re_id"));
		String m_re_nickname=request.getParameter("m_re_nickname");

		logger.info("[Info]댓글자:"+m_re_nickname+"로그인"+session.getAttribute("naver_nickname"));
		if(session.getAttribute("naver_nickname")!=null && session.getAttribute("naver_nickname").equals(m_re_nickname)){
			boolean flags=replyDAO.deleteMovieReply(m_re_id);
			if(flags==true){
				response.sendRedirect(contextPath+"/movie/detail.do?m_id="+m_id);
			}else{
				response.sendRedirect(contextPath+"/movie/detail.do?m_id="+m_id);
			}
			logger.info("[Info]"+flags);
		}else{
			logger.info("[Info]");
			response.sendRedirect(contextPath+"/error/403code.html");
		}	
	}	
}
