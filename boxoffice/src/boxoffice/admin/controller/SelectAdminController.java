package boxoffice.admin.controller;

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

import boxoffice.admin.model.AdminDAO;
import boxoffice.admin.model.AdminService;
import boxoffice.admin.model.AdminVO;

@WebServlet("/admin/select.do")
public class SelectAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminService adminDAO=AdminDAO.getInstance();
		HttpSession session=request.getSession();
		String contextPath=request.getContextPath();

		//관리자수
		int total=adminDAO.selectAdminCount();
		
		//관리자목록
		ArrayList<AdminVO> list=adminDAO.selectAdmin();
		
		request.setAttribute("total", total);
		request.setAttribute("list", list);
		
		if(session.getAttribute("sessionID")==null){
			response.sendRedirect(contextPath+"/error/403code.html");
		}else{
			RequestDispatcher dispatcher=request.getRequestDispatcher("/view/admin/selectAdmin.jsp");
			dispatcher.forward(request, response);
		}
		logger.info("[Info]");
	}
}
