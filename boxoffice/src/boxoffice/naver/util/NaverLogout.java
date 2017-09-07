package boxoffice.naver.util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

@WebServlet(urlPatterns = "/naverLogout.do")
public class NaverLogout extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession();
		String contextPath=request.getContextPath();
		
		//session.invalidate();
		session.removeAttribute("naver_email");
		session.removeAttribute("naver_nickname");
		
		response.sendRedirect(contextPath+"/main.do");
		logger.info("[Info]");
	}
}