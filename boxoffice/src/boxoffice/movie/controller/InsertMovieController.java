package boxoffice.movie.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import boxoffice.movie.model.MovieDAO;
import boxoffice.movie.model.MovieService;
import boxoffice.movie.model.MovieVO;

@WebServlet(urlPatterns = "/movie/insert.do")
public class InsertMovieController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/movie/insertMovieForm.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieService movieDAO=MovieDAO.getInstance();
		MovieVO movieVO=new MovieVO();
		String contextPath=request.getContextPath();

		String realFolder="";//절대경로
		String fileName="";//파일이름
		String newFileName="";//새로 저장되는 이름			
		String saveFolder="/saveFile";//파일이 업로드되는 폴더
		String encType="utf-8";
		int maxSize=5*1024*1024;//최대 5Mb
		
		realFolder=getServletContext().getRealPath(saveFolder);
		
		MultipartRequest imageUp=new MultipartRequest(request, realFolder,maxSize,encType,new DefaultFileRenamePolicy());
		
		String now = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date()); 
		
		//전송한 파일 정보를 가져와 출력
		Enumeration<?>files=imageUp.getFileNames();
		
		//파일정보가 있으면
		while(files.hasMoreElements()){
			//input타입이 file인 name의 값
			String name=(String)files.nextElement();
			fileName=imageUp.getOriginalFileName(name);
			if(fileName!=null){
				newFileName=now+"_"+fileName;//새로 바꾼 파일이름(현재시간+파일이름.확장자)
				File sourceFile = new File(realFolder + File.separator + fileName);
				File targetFile = new File(realFolder + File.separator + newFileName);

				sourceFile.renameTo(targetFile);//새로 지정한 파일로 바꿈
				fileName=newFileName;
				
				logger.info("파일저장경로 :"+targetFile);
			}	
		}
		
		String m_title=imageUp.getParameter("m_title");
		String[] m_kinds=imageUp.getParameterValues("m_kind");
		String m_grade=imageUp.getParameter("m_grade");
		int m_count=Integer.parseInt(imageUp.getParameter("m_count"));
		String m_date=imageUp.getParameter("m_date");
		String m_youtube=imageUp.getParameter("m_youtube");
		String m_contents=imageUp.getParameter("m_contents");

		StringBuffer sb=new StringBuffer();
		for(String list:m_kinds){
			sb.append(list+",");
		}

		String m_kind=sb.toString();
		
		movieVO.setM_title(m_title);
		movieVO.setM_kind(m_kind);
		movieVO.setM_grade(m_grade);
		movieVO.setM_count(m_count);
		movieVO.setM_date(m_date);
		movieVO.setM_youtube(m_youtube);
		movieVO.setM_file(fileName);
		movieVO.setM_contents(m_contents);
		boolean flags=movieDAO.insertMovie(movieVO);
		response.sendRedirect(contextPath+"/movie/select.do");			
		logger.info("[Info]"+flags);
	}	
}
