package boxoffice.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

@WebServlet(urlPatterns = "/download.do")
public class Download extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(getClass());

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// 1. 파일명 가져오기
		String fileName = request.getParameter("filename");
		
		// 2. 경로 가져오기
		String saveDir = this.getServletContext().getRealPath("/saveFile/");
		File file = new File(saveDir + "/" + fileName);
		System.out.println("다운로드 파일명 : " + fileName);
		
		// 3. MIMETYPE 설정하기
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null){
			response.setContentType("application/octet-stream");
		}
		
		// 4. 다운로드용 파일명을 설정(한글 인코딩)
		String downName = null;
		if(request.getHeader("user-agent").indexOf("MSIE") == -1){
			downName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}else{
			downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		// 5. 링크를 클릭했을 때 다운로드 저장 화면이 출력
		response.setHeader("Content-Disposition","attachment;filename=\"" + downName + "\";");
		
		// 6. 요청된 파일을 읽어서 클라이언트쪽으로 저장한다.
		FileInputStream fis = new FileInputStream(file);
		ServletOutputStream sos = response.getOutputStream();
		
		byte b [] = new byte[1024];
		int data = 0;
		
		while((data=(fis.read(b, 0, b.length))) != -1){
			sos.write(b, 0, data);
		}
		
		sos.flush();
		
		// 7. 사용한 io객체를 닫는다.
		sos.close();
		fis.close();
		logger.info("[Info]");
	}
}