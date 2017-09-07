package boxoffice.common.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

// .do의 요청에 대해서 EncodingFilter를 경유하도록 설정
@WebFilter("*.do")
public class EncodingFilter implements Filter {
	private String charset="utf-8";
	
	// 필터가 load될 때 자동호출되는 코드
	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("인코딩 필터 작동");
	}

	// 요청이 있을 때 선처리되는 코드
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("인코딩 필터 실행");
		request.setCharacterEncoding(charset);
		//사용자가 요청한 페이지 처리
		chain.doFilter(request, response);
	}

	// 웹서버가 stop될 때 자동 호출
	public void destroy() {
		System.out.println("인코딩 필터 멈춤");
	}
}
