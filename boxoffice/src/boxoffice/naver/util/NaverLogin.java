package boxoffice.naver.util;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

@WebServlet(urlPatterns = "/naverLogin.do")
public class NaverLogin extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession();
		logger.info("[Info]주소:"+request.getHeader("referer").toString());
		String ip = request.getServerName();                      
		String port = Integer.toString(request.getServerPort());   
		String context = request.getContextPath();
		String root = "http://"+ ip +":"+ port + context;													
		
		if(request.getHeader("referer").toString().equals(root+"/callback.do")){
		logger.info("[Info]이메일:"+request.getParameter("email"));
		logger.info("[Info]닉네임:"+request.getParameter("nickname"));
		logger.info("[Info]나이:"+request.getParameter("age"));
		session.setAttribute("naver_nickname", request.getParameter("nickname"));
		session.setAttribute("naver_email", request.getParameter("email"));
//		session.setAttribute("naver_age", request.getParameter("age"));
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/naverLogin.jsp");
			 dispatcher.forward(request, response);
		}else{
			RequestDispatcher dispatcher=request.getRequestDispatcher("/view/naverLogin.jsp");
			dispatcher.forward(request, response);
		}
		logger.info("[Info]");		
	}
}
