package boxoffice.movie.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import boxoffice.movie.model.MovieDAO;
import boxoffice.movie.model.ReplyService;
import boxoffice.movie.model.ReplyVO;

@WebServlet(urlPatterns = "/movie/updateReply.do")
public class UpdateReplyController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReplyService replyDAO=MovieDAO.getInstance();
		ReplyVO replyVO=new ReplyVO();
		String contextPath=request.getContextPath();
			
		int m_id=Integer.parseInt(request.getParameter("m_id"));
		int m_re_id=Integer.parseInt(request.getParameter("m_re_id"));
		String m_re_star=request.getParameter("m_re_star");
		String m_re_contents=request.getParameter("m_re_contents");
		
		replyVO.setM_re_id(m_re_id);
		replyVO.setM_re_star(m_re_star);
		replyVO.setM_re_contents(m_re_contents);
		
		replyDAO.updateMovieReply(replyVO);
		response.sendRedirect(contextPath+"/movie/detail.do?m_id="+m_id);		
		logger.info("[Info]");	
	}	
}
