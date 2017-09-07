package boxoffice.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import boxoffice.admin.model.AdminDAO;
import boxoffice.admin.model.AdminService;
import boxoffice.admin.model.AdminVO;

@WebServlet(urlPatterns = "/admin/insert.do")
public class InsertAdminController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminService adminDAO=AdminDAO.getInstance();
		AdminVO adminVO=new AdminVO();
		String contextPath=request.getContextPath();

		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
		adminVO.setId(id);
		adminVO.setPw(pw);
		
		boolean flags=adminDAO.insertAdmin(adminVO);
		if(flags==true){
			logger.info("[info]"+flags);
			response.sendRedirect(contextPath+"/admin/select.do?insertmsg=true&id="+id);
		}else{
			logger.info("[info]"+flags);
			response.sendRedirect(contextPath+"/admin/select.do?insertmsg=false&id="+id);
		}
	}	
}
