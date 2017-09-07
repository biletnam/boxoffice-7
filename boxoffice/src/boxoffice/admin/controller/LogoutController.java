package boxoffice.admin.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

@WebServlet(urlPatterns = "/admin/logout.do")
public class LogoutController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		//session.invalidate();
		session.removeAttribute("sessionID");

		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/admin/logout.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}
}
