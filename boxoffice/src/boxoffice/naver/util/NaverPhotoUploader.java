package boxoffice.naver.util;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

@WebServlet(urlPatterns = "/photo_uploader.do")
public class NaverPhotoUploader extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher dispatcher=request.getRequestDispatcher("/smart_editor/photo_uploader/popup/photo_uploader.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}
}