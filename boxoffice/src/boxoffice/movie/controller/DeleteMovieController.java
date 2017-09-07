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
import boxoffice.movie.model.MovieService;

@WebServlet(urlPatterns = "/movie/delete.do")
public class DeleteMovieController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieService movieDAO=MovieDAO.getInstance();
		HttpSession session = request.getSession();
		String contextPath=request.getContextPath();

		int m_id=Integer.parseInt(request.getParameter("m_id"));
		
		if(session.getAttribute("sessionID")!=null){
			boolean flags=movieDAO.deleteMovie(m_id);
			if(flags==true){
				response.sendRedirect(contextPath+"/movie/select.do?msg=true");
			}else{
				response.sendRedirect(contextPath+"/movie/select.do?msg=false");
			}
			logger.info("[Info]");
		}else{
			logger.info("[Info]");
			response.sendRedirect(contextPath+"/error/403code.html");
		}
	}	
}
