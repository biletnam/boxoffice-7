package boxoffice.common.util;

import java.sql.*;
import javax.sql.*;

import javax.naming.*;

public class DBCP {

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Context context = new InitialContext();
			DataSource source = (DataSource) context.lookup("java:comp/env/jdbc/basicjsp");
			conn = source.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	// select 후 사용객체 닫기
	public static void close(Connection conn, PreparedStatement pstmt){
		if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
		if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
	}
	
	// insert, update, delete 후 사용객체 닫기
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs){
		if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
		if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
		if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
	}
}
