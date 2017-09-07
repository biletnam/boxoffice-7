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

import boxoffice.admin.model.AdminDAO;
import boxoffice.admin.model.AdminService;
import boxoffice.admin.model.AdminVO;

@WebServlet("/admin/login.do")//관리자 로그인 처리
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/admin/loginForm.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminService adminDAO=AdminDAO.getInstance();
		AdminVO adminVO=new AdminVO();
		HttpSession session=request.getSession();
		String contextPath=request.getContextPath();
		
		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
		adminVO.setId(id);
		adminVO.setPw(pw);
		
		int count=adminDAO.loginAdmin(adminVO);
		if(count==1){
			session.setAttribute("sessionID", id);
			//session.setAttribute("sessionPW", pw);
			response.sendRedirect(contextPath+"/admin/select.do");
			logger.info("[info]"+count);
		}else{
			String msg="잘못입력하셨습니다.";
			request.setAttribute("msg", msg);
			RequestDispatcher dispatcher=request.getRequestDispatcher("/view/admin/loginForm.jsp");
			dispatcher.forward(request, response);	
			logger.info("[info]");
		}
	}
}
