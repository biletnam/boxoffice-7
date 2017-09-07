package boxoffice.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import boxoffice.admin.model.AdminDAO;
import boxoffice.admin.model.AdminService;

@WebServlet(urlPatterns = "/admin/delete.do")
public class DeleteAdminController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminService adminDAO=AdminDAO.getInstance();
		HttpSession session = request.getSession();
		String contextPath=request.getContextPath();
		String id=request.getParameter("id");
		
		if(session.getAttribute("sessionID").equals("admin")){
			boolean flags=adminDAO.deleteAdmin(id);
			if(flags==true){
				response.sendRedirect(contextPath+"/admin/select.do?deletemsg=true&id="+id);
			}else{
				response.sendRedirect(contextPath+"/admin/select.do?deletemsg=false&id="+id);
			}
			logger.info("[info]"+flags);
		}else{
			logger.info("[info]");
			response.sendRedirect(contextPath+"/error/403code.html");
		}
	}	
}
