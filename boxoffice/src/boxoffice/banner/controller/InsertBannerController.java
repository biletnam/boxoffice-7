package boxoffice.banner.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import boxoffice.banner.model.BannerDAO;
import boxoffice.banner.model.BannerService;
import boxoffice.banner.model.BannerVO;

@WebServlet(urlPatterns = "/banner/insert.do")
public class InsertBannerController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());
	BannerService bannerDAO=BannerDAO.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BannerVO bannerVO=new BannerVO();
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
		logger.info("넘어온파일정보 :"+files);
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
		
		String banner_name=imageUp.getParameter("banner_name");
		bannerVO.setBanner_name(banner_name);
		bannerVO.setBanner_file(fileName);
		boolean flags = bannerDAO.insertBanner(bannerVO);
		response.sendRedirect(contextPath+"/banner/select.do");			
		logger.info("[Info]"+flags);
	}
}
