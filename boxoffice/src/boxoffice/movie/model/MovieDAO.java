package boxoffice.movie.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import boxoffice.common.util.DBCP;
import boxoffice.common.util.PagingVO;

public class MovieDAO implements MovieService, ReplyService{
	private Logger logger = Logger.getLogger(getClass());
	private static MovieDAO movieDAO;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	
	// 외부에서 객체생성 금지
	private MovieDAO(){}
	
	// 싱글톤 방식
	public static MovieDAO getInstance(){
		if(movieDAO == null){
			movieDAO = new MovieDAO();
		}
		return movieDAO;
	}

	@Override
	// select
	public ArrayList<MovieVO> selectMovie(MovieVO movieVO){
		ArrayList<MovieVO> list = null;
		try {
			conn = DBCP.getConnection();
			sql = "select m.*,(select count(*) from movie_reply where m_id=m.m_id) as m_re_total,"
					+ " (select round(avg(m_re_star)) from movie_reply where m_id=m.m_id) as m_re_star"
					+ " from movie m order by m_count desc limit 0, 4"; 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			list=new ArrayList<MovieVO>();
			while (rs.next()) {
				movieVO=new MovieVO();
				movieVO.setM_id(rs.getInt(1));
				movieVO.setM_title(rs.getString(2));
				movieVO.setM_kind(rs.getString(3));
				movieVO.setM_grade(rs.getString(4));
				movieVO.setM_date(rs.getString(5));
				movieVO.setM_youtube(rs.getString(6));
				movieVO.setM_file(rs.getString(7));
				movieVO.setM_count(rs.getInt(8));
				movieVO.setM_contents(rs.getString(9));
				movieVO.setM_reg_date(rs.getTimestamp(10));
				movieVO.setM_re_total(rs.getInt(11));
				movieVO.setM_re_star(rs.getInt(12));
				list.add(movieVO);
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return list;
	}

	@Override
	public ArrayList<MovieVO> selectMovie(MovieVO movieVO, PagingVO pagingVO){
		ArrayList<MovieVO> list = null;
		try {
			conn = DBCP.getConnection();
			sql = "select m.*,(select count(*) from movie_reply where m_id=m.m_id) as m_re_total,"
					+ " (select round(avg(m_re_star)) from movie_reply where m_id=m.m_id) as m_re_star"
					+ " from movie m where " 
					+ pagingVO.getKeyWord() +" like ? order by m_count desc limit "
					+ ((pagingVO.getPageNum()-1) * pagingVO.getRowNum()) +", " +pagingVO.getRowNum() + ""; 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + pagingVO.getKeyValue() + "%");
			rs = pstmt.executeQuery();
			list=new ArrayList<MovieVO>();
			while (rs.next()) {
				movieVO=new MovieVO();
				movieVO.setM_id(rs.getInt(1));
				movieVO.setM_title(rs.getString(2));
				movieVO.setM_kind(rs.getString(3));
				movieVO.setM_grade(rs.getString(4));
				movieVO.setM_date(rs.getString(5));
				movieVO.setM_youtube(rs.getString(6));
				movieVO.setM_file(rs.getString(7));
				movieVO.setM_count(rs.getInt(8));
				movieVO.setM_contents(rs.getString(9));
				movieVO.setM_reg_date(rs.getTimestamp(10));
				movieVO.setM_re_total(rs.getInt(11));
				movieVO.setM_re_star(rs.getInt(12));
				list.add(movieVO);
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return list;
	}

	@Override
	public MovieVO detailMovie(int m_id){
		MovieVO movieVO=null;
		try {
			conn = DBCP.getConnection();
			sql = "select m.*,(select count(*) from movie_reply where m_id=m.m_id) as m_re_total from movie m where m.m_id=?"; 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				movieVO=new MovieVO();
				movieVO.setM_id(rs.getInt(1));
				movieVO.setM_title(rs.getString(2));
				movieVO.setM_kind(rs.getString(3));
				movieVO.setM_grade(rs.getString(4));
				movieVO.setM_date(rs.getString(5));
				movieVO.setM_youtube(rs.getString(6));
				movieVO.setM_file(rs.getString(7));
				movieVO.setM_count(rs.getInt(8));
				movieVO.setM_contents(rs.getString(9));
				movieVO.setM_reg_date(rs.getTimestamp(10));
				movieVO.setM_re_total(rs.getInt(11));
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return movieVO;
	}

	@Override
	// select count
	public int selectMovieCount(PagingVO pagingVO){
		int total = 0;
		try {
			conn = DBCP.getConnection();
			sql = "select count(*) from movie where " + pagingVO.getKeyWord() + " like ?";
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
	// insert
	public boolean insertMovie(MovieVO movieVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
			sql="insert into movie(m_title, m_kind, m_grade, m_date, m_youtube, m_file ,m_count, m_contents, m_reg_date) values(?,?,?,?,?,?,?,?,now())";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieVO.getM_title());
			pstmt.setString(2, movieVO.getM_kind());
			pstmt.setString(3, movieVO.getM_grade());
			pstmt.setString(4, movieVO.getM_date());
			pstmt.setString(5, movieVO.getM_youtube());
			pstmt.setString(6, movieVO.getM_file());
			pstmt.setInt(7, movieVO.getM_count());
			pstmt.setString(8, movieVO.getM_contents());
			count=pstmt.executeUpdate();
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

	@Override
	public boolean deleteMovie(int m_id){
		boolean flags=false;
		try{
			conn = DBCP.getConnection();
			sql = "delete from movie where m_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_id);
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

	@Override
	public boolean updateMovie(MovieVO movieVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
			sql="update movie set m_title=?, m_kind=?, m_grade=?, m_date=?, m_youtube=?, m_file=?, m_count=?, m_contents=? where m_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieVO.getM_title());
			pstmt.setString(2, movieVO.getM_kind());
			pstmt.setString(3, movieVO.getM_grade());
			pstmt.setString(4, movieVO.getM_date());
			pstmt.setString(5, movieVO.getM_youtube());
			pstmt.setString(6, movieVO.getM_file());
			pstmt.setInt(7, movieVO.getM_count());
			pstmt.setString(8, movieVO.getM_contents());
			pstmt.setInt(9, movieVO.getM_id());
			count=pstmt.executeUpdate();
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
	
	@Override
	public ArrayList<ReplyVO> selectMovieReply(ReplyVO replyVO, PagingVO pagingVO){
		ArrayList<ReplyVO> list = null;
		try {
			conn = DBCP.getConnection();
			sql = "select * from movie_reply where m_id=? order by m_re_id desc limit " 
					+ ((pagingVO.getPageNum()-1) * pagingVO.getRowNum()) +", " +pagingVO.getRowNum() + ""; 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyVO.getM_id());
			rs = pstmt.executeQuery();
			list=new ArrayList<ReplyVO>();
			while (rs.next()) {
				replyVO=new ReplyVO();
				replyVO.setM_re_id(rs.getInt(1));
				replyVO.setM_re_nickname(rs.getString(2));
				replyVO.setM_re_email(rs.getString(3));
				replyVO.setM_re_star(rs.getString(4));
				replyVO.setM_re_contents(rs.getString(5));
				replyVO.setM_re_reg_date(rs.getTimestamp(6));
				replyVO.setM_id(rs.getInt(7));
				list.add(replyVO);
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return list;
	}
	
	@Override
	public int selectMovieReplyCount(ReplyVO replyVO){
		int total = 0;
		try {
			conn = DBCP.getConnection();
			sql = "select count(*) from movie_reply where m_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyVO.getM_id());
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
	public int selectMovieReplyStarAvg(int m_id){
		int total = 0;
		try {
			conn = DBCP.getConnection();
			sql = "select round(avg(m_re_star)) from movie_reply where m_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_id);
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
	public int selectMovieReplySearchCount(ReplyVO replyVO){
		int total = 0;
		try {
			conn = DBCP.getConnection();
			sql = "select count(*) from movie_reply where m_re_nickname=? and m_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, replyVO.getM_re_nickname());
			pstmt.setInt(2, replyVO.getM_id());
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
	public boolean insertMovieReply(ReplyVO replyVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
			sql="insert into movie_reply (m_re_nickname, m_re_email, m_re_star, m_re_contents, m_re_reg_date, m_id)values(?,?,?,?,now(),?)";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, replyVO.getM_re_nickname());
			pstmt.setString(2, replyVO.getM_re_email());
			pstmt.setString(3, replyVO.getM_re_star());
			pstmt.setString(4, replyVO.getM_re_contents());
			pstmt.setInt(5, replyVO.getM_id());
			count=pstmt.executeUpdate();
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

	@Override
	public boolean deleteMovieReply(int m_re_id){
		boolean flags=false;
		try{
			
			conn = DBCP.getConnection();
			sql = "delete from movie_reply where m_re_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, m_re_id);
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

	@Override
	public boolean updateMovieReply(ReplyVO replyVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
			sql="update movie_reply set m_re_star=?, m_re_contents=?, m_re_reg_date=now() where m_re_id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, replyVO.getM_re_star());
			pstmt.setString(2, replyVO.getM_re_contents());
			pstmt.setInt(3, replyVO.getM_re_id());
			System.out.println("star"+replyVO.getM_re_star());
			System.out.println("contents"+replyVO.getM_re_contents());
			count=pstmt.executeUpdate();
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
