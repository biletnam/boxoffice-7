package boxoffice.notice.model;

import java.util.ArrayList;

import boxoffice.common.util.PagingVO;

public interface NoticeService {

	// select
	public ArrayList<NoticeVO> selectNotice(PagingVO pagingVO);
	
	// select count
	public int selectNoticeCount(PagingVO pagingVO);
	
	// select detail
	public NoticeVO detailNotice(int n_id);

	// insert
	public boolean insertNotice(NoticeVO noticeVO);
	
	// update
	public boolean updateNotice(NoticeVO noticeVO);
	
	// delete
	public boolean deleteNotice(int n_id);

}
