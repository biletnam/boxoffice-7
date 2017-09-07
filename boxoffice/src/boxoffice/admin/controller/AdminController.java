package boxoffice.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String command = request.getRequestURI();
		String context = request.getContextPath();
		
		command = command.substring(command.lastIndexOf("/")+1);
		
		if(command.equals("select.do")){
			response.sendRedirect(context+"/admin/select.do");
		}else if(command.equals("insert.do")){
			response.sendRedirect(context+"/admin/insert.do");
		}else{
			response.sendRedirect(context+"/error/500code.html");
		}
		JSONObject jsonObj=new JSONObject();
		
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}
}
