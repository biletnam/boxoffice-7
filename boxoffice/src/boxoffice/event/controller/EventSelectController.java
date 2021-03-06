package boxoffice.event.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

@WebServlet(urlPatterns = "/event/select.do")
public class EventSelectController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setAttribute("url", request.getRequestURL().toString()); 
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/event/selectEvent.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}
}
