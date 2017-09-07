package boxoffice.banner.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import boxoffice.common.util.DBCP;

public class BannerDAO implements BannerService {
	private Logger logger = Logger.getLogger(getClass());
	private static BannerDAO bannerDAO;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	
	// 외부에서 객체생성 금지
	private BannerDAO(){}
	
	// 싱글톤 방식
	public static BannerDAO getInstance(){
		if(bannerDAO == null){
			bannerDAO = new BannerDAO();
		}
		return bannerDAO;
	}

	@Override
	public boolean insertBanner(BannerVO BannerVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
	
			sql = "insert into banner(banner_name, banner_file) values(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, BannerVO.getBanner_name());
			pstmt.setString(2, BannerVO.getBanner_file());
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
	public ArrayList<BannerVO> selectBanner(){
		ArrayList<BannerVO> list = null;
		try {
			conn = DBCP.getConnection();
			list=new ArrayList<BannerVO>();

			sql = "select * from banner order by banner_id desc"; 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BannerVO bannerVO=new BannerVO();
				bannerVO.setBanner_id(rs.getInt(1));
				bannerVO.setBanner_name(rs.getString(2));
				bannerVO.setBanner_file(rs.getString(3));
				list.add(bannerVO);
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return list;
	}

	@Override
	public void deleteBanner(String id) {
		try{
			conn = DBCP.getConnection();
	
			sql = "delete from banner where banner_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt);
		}		
	}	
}
