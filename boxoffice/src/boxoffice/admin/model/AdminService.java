package boxoffice.admin.model;

import java.util.ArrayList;

//구현해야할 기능 목록 정의
public interface AdminService {

	//admin login
	public int loginAdmin(AdminVO adminVO);
	
	//admin select
	public ArrayList<AdminVO> selectAdmin();
	
	//admin select count
	public int selectAdminCount();
	
	//admin insert
	public boolean insertAdmin(AdminVO adminVO);
	
	//admin delete
	public boolean deleteAdmin(String id);
}
