package boxoffice.notice.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import boxoffice.common.util.DBCP;
import boxoffice.common.util.PagingVO;

public class NoticeDAO implements NoticeService{
	private Logger logger = Logger.getLogger(getClass());
	private static NoticeDAO noticeDAO;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;

	// 외부에서 객체생성 금지
	private NoticeDAO(){}
	
	// 싱글톤 방식
	public static NoticeDAO getInstance(){
		if(noticeDAO == null){
			noticeDAO = new NoticeDAO();
		}
		return noticeDAO;
	}
	
	@Override
	// select
	public ArrayList<NoticeVO> selectNotice(PagingVO pagingVO){
		ArrayList<NoticeVO> list = null;
		try {
			conn = DBCP.getConnection();
			sql = "select * from notice where " + pagingVO.getKeyWord() +" like ? order by n_id desc limit "
					+ ((pagingVO.getPageNum()-1) * pagingVO.getRowNum()) +", " +pagingVO.getRowNum(); 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + pagingVO.getKeyValue() + "%");
			rs = pstmt.executeQuery();
			list=new ArrayList<NoticeVO>();
			while (rs.next()) {
				NoticeVO noticeVO=new NoticeVO();
				noticeVO.setN_id(rs.getInt(1));
				noticeVO.setN_title(rs.getString(2));
				noticeVO.setN_contents(rs.getString(3));
				noticeVO.setN_file(rs.getString(4));
				noticeVO.setN_reg_date(rs.getTimestamp(5));
				list.add(noticeVO);
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return list;
	}

	@Override
	// select count
	public int selectNoticeCount(PagingVO pagingVO){
		int total = 0;
		try {
			conn = DBCP.getConnection();
			sql = "select count(*) from notice where " + pagingVO.getKeyWord() + " like ?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + pagingVO.getKeyValue() + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return total;
	}
	
	@Override
	// select detail
	public NoticeVO detailNotice(int n_id) {
		NoticeVO noticeVO = null;
		try {
			conn = DBCP.getConnection();
			sql = "select * from notice where n_id=?"; 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n_id);
			rs = pstmt.executeQuery();
			rs.next();
			noticeVO=new NoticeVO();
			noticeVO.setN_id(rs.getInt(1));
			noticeVO.setN_title(rs.getString(2));
			noticeVO.setN_contents(rs.getString(3));
			noticeVO.setN_file(rs.getString(4));
			noticeVO.setN_reg_date(rs.getTimestamp(5));
			
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return noticeVO;
	}

	@Override
	// insert
	public boolean insertNotice(NoticeVO noticeVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
			sql = "insert into notice(n_title,n_contents,n_file,n_reg_date) values(?,?,?,now())";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, noticeVO.getN_title());
			pstmt.setString(2, noticeVO.getN_contents());
			pstmt.setString(3, noticeVO.getN_file());
			count=pstmt.executeUpdate();
			
			if(count==1){flags=true;}
			
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt);
		}
		return flags;
	}

	@Override
	// update
	public boolean updateNotice(NoticeVO noticeVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
			sql = "update notice set n_title=?, n_contents=?, n_file=? where n_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, noticeVO.getN_title());
			pstmt.setString(2, noticeVO.getN_contents());
			pstmt.setString(3, noticeVO.getN_file());
			pstmt.setInt(4, noticeVO.getN_id());
			count=pstmt.executeUpdate();
			if(count==1){flags=true;}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt);
		}
		return flags;
	}

	@Override
	// delete
	public boolean deleteNotice(int n_id){
		boolean flags=false;
		try{
			conn = DBCP.getConnection();
			sql = "delete from notice where n_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, n_id);
			int count=pstmt.executeUpdate();
			if(count==1){
				flags=true;
			}
			
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt);
		}
		return flags;
	}
}