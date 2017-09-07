package boxoffice.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import boxoffice.notice.model.NoticeDAO;
import boxoffice.notice.model.NoticeService;
import boxoffice.notice.model.NoticeVO;

@WebServlet(urlPatterns = "/notice/update.do")
public class UpdateNoticeController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());
	NoticeService noticeDAO = NoticeDAO.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		int n_id=Integer.parseInt(request.getParameter("n_id"));
		NoticeVO noticeVO=noticeDAO.detailNotice(n_id);
		
		String n_contents=noticeVO.getN_contents();
		n_contents=n_contents.replace("<br>","\r\n");//수정할 때는 다시 원상복구
		noticeVO.setN_contents(n_contents);
		
		request.setAttribute("noticeVO", noticeVO);
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("/view/notice/updateNoticeForm.jsp");
		dispatcher.forward(request, response);
		logger.info("[Info]");		
	}	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NoticeVO noticeVO=new NoticeVO();
		String contextPath=request.getContextPath();

		String realFolder="";//파일을 저장할 절대경로
		String oldFileName="";//전송전 원래이름
		String fileName="";//중복될 경우 파일이름
		String newFileName="";//새로 바꾼 파일이름
		String saveFolder="/saveFile";//파일이 업로드되는 폴더
		String encType="utf-8";
		int maxSize=5*1024*1024;//최대 5Mb

		//파일 경로 구하기
		ServletContext context=getServletContext();
		realFolder=context.getRealPath(saveFolder);
		
		MultipartRequest imageUp=new MultipartRequest(request, realFolder,maxSize,encType,new DefaultFileRenamePolicy());
					
		//현재시간
		String now = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date()); 
		
		//전송한 파일 정보를 가져와 출력
		Enumeration<?>files=imageUp.getFileNames();

		//파일정보가 있으면
		while(files.hasMoreElements()){
			String name=(String)files.nextElement();//input타입이 file인 name의 값
			oldFileName=imageUp.getOriginalFileName(name);//원래 파일이름
			fileName=imageUp.getFilesystemName(name);//중복될 경우 파일이름
			//fileName = imageUp.getFilesystemName("n_file");
			
			if(oldFileName!=null){
				newFileName=now+"_"+oldFileName;//새로 바꾼 파일이름(현재시간+파일이름.확장자)
				
				File oldFile = new File(realFolder + File.separator + oldFileName);
				File sourceFile = new File(realFolder + File.separator + fileName);
				File targetFile = new File(realFolder + File.separator + newFileName);

				logger.info("inputFile의 name값:"+name);
				logger.info("저장경로:"+realFolder);
				logger.info("저장경로와 원래 파일이름 :"+oldFile);
				logger.info("저장경로와 중복될 경우 파일이름 :"+sourceFile);
				logger.info("저장경로와 새로 바뀐 파일이름:"+targetFile);
				logger.info("원래 파일 이름:"+oldFileName);
				logger.info("중복될 경우 파일 이름:"+fileName);
				logger.info("바뀐 파일 이름:"+newFileName);
				
				oldFile.renameTo(targetFile);//새로 지정한 파일로 바꿈
				fileName=newFileName;
				
				//oldFile.delete();//원래파일 삭제
				//sourceFile.delete();//중복될 경우 파일 삭제
				
				logger.info("파일삭제후:");
				logger.info("저장경로와 원래 파일이름 :"+oldFile);
				logger.info("저장경로와 중복될 경우 파일이름 :"+sourceFile);
				logger.info("저장경로와 새로 바뀐 파일이름:"+targetFile);
				
				/*
				long fileSize=imageUp.getFile(name).length();//파일 사이즈
				String fileType=imageUp.getContentType(name).split("/")[1];//파일 타입
				logger.info("수정파일사이즈:"+fileSize);
				logger.info("수정파일타입:"+fileType);*/
			}else{
				fileName=imageUp.getParameter("n_file2");
			}
			
		}
		int n_id=Integer.parseInt(imageUp.getParameter("n_id"));
		String n_title=imageUp.getParameter("n_title");
		String n_contents=imageUp.getParameter("n_contents");
		n_contents=n_contents.replace("\r\n","<br>");//엔터는 \r\n로 인식되므로 <br>태그로 변경해서 저장
		noticeVO.setN_id(n_id);
		noticeVO.setN_title(n_title);
		noticeVO.setN_contents(n_contents);
		noticeVO.setN_file(fileName);
		boolean flags=noticeDAO.updateNotice(noticeVO);
		response.sendRedirect(contextPath+"/notice/select.do");			
		logger.info("[Info]"+flags);
	}
}
