package boxoffice.movie.model;

import java.sql.Timestamp;

public class ReplyVO {
	private int m_re_id;
	private String m_re_nickname;
	private String m_re_email;
	private String m_re_star;
	private String m_re_contents;
	private Timestamp m_re_reg_date;
	private int m_id;
	private int m_re_total;
	public int getM_re_id() {
		return m_re_id;
	}
	public void setM_re_id(int m_re_id) {
		this.m_re_id = m_re_id;
	}
	public String getM_re_nickname() {
		return m_re_nickname;
	}
	public void setM_re_nickname(String m_re_nickname) {
		this.m_re_nickname = m_re_nickname;
	}
	public String getM_re_email() {
		return m_re_email;
	}
	public void setM_re_email(String m_re_email) {
		this.m_re_email = m_re_email;
	}
	public String getM_re_star() {
		return m_re_star;
	}
	public void setM_re_star(String m_re_star) {
		this.m_re_star = m_re_star;
	}
	public String getM_re_contents() {
		return m_re_contents;
	}
	public void setM_re_contents(String m_re_contents) {
		this.m_re_contents = m_re_contents;
	}
	public Timestamp getM_re_reg_date() {
		return m_re_reg_date;
	}
	public void setM_re_reg_date(Timestamp m_re_reg_date) {
		this.m_re_reg_date = m_re_reg_date;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public int getM_re_total() {
		return m_re_total;
	}
	public void setM_re_total(int m_re_total) {
		this.m_re_total = m_re_total;
	}
	
}
