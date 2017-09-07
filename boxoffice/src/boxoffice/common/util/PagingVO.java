package boxoffice.common.util;

public class PagingVO {
	private String keyWord; //검색 컬럼
	private String keyValue;//검색 값
	private int total;//게시물 총 갯수
	private String pageNum_temp;//현재 페이지번호(문자열)
	private int pageNum;//현재 페이지번호
	private int rowNum=5;//페이지당 보여줄 리스트 수
	private int pageBlock=5;//페이징 블럭 수
	private int pageCount;//페이징 블럭 전체 수
	private int startPage;//시작페이지
	private int endPage;//끝페이지
	
	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	public String getKeyValue() {
		return keyValue;
	}
	public void setKeyValue(String keyValue) {
		this.keyValue = keyValue;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getPageNum_temp() {
		return pageNum_temp;
	}
	public void setPageNum_temp(String pageNum_temp) {
		this.pageNum_temp = pageNum_temp;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	public int getPageBlock() {
		return pageBlock;
	}
	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

}
