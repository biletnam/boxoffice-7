package boxoffice.notice.model;

import java.sql.Timestamp;

public class NoticeVO {
	private int n_id;
	private String n_title;
	private String n_contents; 
	private String n_file;
	private Timestamp n_reg_date;
	
	public int getN_id() {
		return n_id;
	}
	public void setN_id(int n_id) {
		this.n_id = n_id;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_contents() {
		return n_contents;
	}
	public void setN_contents(String n_contents) {
		this.n_contents = n_contents;
	}
	public String getN_file() {
		return n_file;
	}
	public void setN_file(String n_file) {
		this.n_file = n_file;
	}
	public Timestamp getN_reg_date() {
		return n_reg_date;
	}
	public void setN_reg_date(Timestamp n_reg_date) {
		this.n_reg_date = n_reg_date;
	}

}
