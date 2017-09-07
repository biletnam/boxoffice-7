package boxoffice.admin.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import boxoffice.common.util.DBCP;

public class AdminDAO implements AdminService{
	private Logger logger = Logger.getLogger(getClass());
	private static AdminDAO adminDAO;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;

	// 외부에서 객체생성 금지
	private AdminDAO(){}
	
	// 싱글톤 방식
	public static AdminDAO getInstance(){
		if(adminDAO == null){
			adminDAO = new AdminDAO();
		}
		return adminDAO;
	}
		
	@Override
	public int loginAdmin(AdminVO adminVO){
		int count=0;
		try{
			conn=DBCP.getConnection();
			sql="select count(*) as cnt from admin where id=? and pw=?";
			logger.info("[info]"+sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, adminVO.getId());
			pstmt.setString(2, adminVO.getPw());
			rs=pstmt.executeQuery();
			rs.next();
			count=rs.getInt("cnt");
		}catch(SQLException e){
			logger.error("[Error]", e);
		}finally{
			DBCP.close(conn, pstmt, rs);
		}
		return count;
	}

	@Override
	public ArrayList<AdminVO> selectAdmin(){
		ArrayList<AdminVO> list = null;
		try {
			conn = DBCP.getConnection();
			list=new ArrayList<AdminVO>();

			sql = "select * from admin order by reg_date"; 
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AdminVO adminVO=new AdminVO();
				adminVO.setId(rs.getString(1));
				adminVO.setPw(rs.getString(2));
				adminVO.setReg_date(rs.getTimestamp(3));
				list.add(adminVO);
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return list;
	}

	@Override
	public int selectAdminCount(){
		int total = 0;
		try {
			conn = DBCP.getConnection();
			sql = "select count(*) from admin";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
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
	public boolean insertAdmin(AdminVO adminVO){
		boolean flags=false;
		int count=0;
		try{
			conn = DBCP.getConnection();
			
			sql="select count(*) as cnt from admin where id=?";
			logger.info("[Info]"+sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adminVO.getId());
			rs = pstmt.executeQuery();
			rs.next();
			count=rs.getInt("cnt");
			
			if(count==1){
				flags=false;
			}else{
				sql = "insert into admin values(?,?,now())";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, adminVO.getId());
				pstmt.setString(2, adminVO.getPw());
				count=pstmt.executeUpdate();
				
				if(count==1){
					flags=true;
				}
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt, rs);
		}
		return flags;
	}

	@Override
	public boolean deleteAdmin(String id){
		boolean flags=false;
		try{
			if(!id.equals("admin")){
				conn = DBCP.getConnection();
				sql = "delete from admin where id=?";
				logger.info("[Info]"+sql);
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				int count=pstmt.executeUpdate();
				
				if(count==1){
					flags=true;
				}
			}else{
				flags=false;
			}
		} catch (SQLException e) {
			logger.error("[Error]", e);
		} finally {
			DBCP.close(conn, pstmt);
		}
		return flags;
	}	
}
