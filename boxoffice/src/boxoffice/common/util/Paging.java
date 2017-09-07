package boxoffice.common.util;

import org.apache.log4j.Logger;

public class Paging {
	static Logger logger = Logger.getLogger(Paging.class);
	
	public static PagingVO setPagingInfo(PagingVO pagingVO){
		
		String pageNum_temp = pagingVO.getPageNum_temp();		
				
		if (pageNum_temp == null)
			pageNum_temp = "1"; //만약 값이 NULL값이면 초기값을 1페이지로 세팅 
		int pageNum = Integer.parseInt(pageNum_temp); //그 값을 pageNum에 대입 
		int pageCount = (pagingVO.getTotal() / pagingVO.getRowNum()) + (pagingVO.getTotal() % pagingVO.getRowNum() == 0 ? 0 : 1); //페이징 개수 전체 카운트 
		int startPage = (pagingVO.getPageBlock() * ((pageNum - 1) / pagingVO.getPageBlock())) + 1; //시작페이지 
		int endPage = startPage + (pagingVO.getPageBlock() - 1); //끝페이지 
		
		pagingVO.setPageNum(pageNum);
		pagingVO.setPageCount(pageCount);
		pagingVO.setStartPage(startPage);
		pagingVO.setEndPage(endPage);
		
		logger.info("[Info] 게시물 전체 수:"+pagingVO.getTotal());
		logger.info("[Info] 페이지 전체 수:"+pageCount);
		logger.info("[Info] 페이지 블럭 수:"+pagingVO.getPageBlock());
		logger.info("[Info] 현재페이지:"+pageNum);
		logger.info("[Info] 시작페이지:"+startPage);
		logger.info("[Info] 끝페이지:"+endPage);
		logger.info("[Info] 페이지당 게시물 수:"+pagingVO.getRowNum());
		return pagingVO;
	}
}
