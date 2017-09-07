package boxoffice.common.util;

import org.apache.log4j.PropertyConfigurator;

import javax.servlet.http.HttpServlet;

public class Log4jInit extends HttpServlet {
 
	private static final long serialVersionUID = 1L;

	public  void init() {
	     String prefix =  getServletContext().getRealPath("/");
	     String file = getInitParameter("log4j-init-file");
	
	     if(file != null) {
	       PropertyConfigurator.configure(prefix+file);
	     }
	}
}