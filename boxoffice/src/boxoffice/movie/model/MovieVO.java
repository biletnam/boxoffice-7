package boxoffice.movie.model;

import java.sql.Timestamp;

public class MovieVO {
	private int m_id;
	private String m_title;
	private String m_kind;
	private String m_grade;
	private String m_date;
	private String m_youtube;
	private String m_file;
	private int m_count;
	private String m_contents;
	private Timestamp m_reg_date;
	private int m_re_total;
	private int m_re_star;
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public String getM_title() {
		return m_title;
	}
	public void setM_title(String m_title) {
		this.m_title = m_title;
	}
	public String getM_kind() {
		return m_kind;
	}
	public void setM_kind(String m_kind) {
		this.m_kind = m_kind;
	}
	public String getM_grade() {
		return m_grade;
	}
	public void setM_grade(String m_grade) {
		this.m_grade = m_grade;
	}
	public String getM_date() {
		return m_date;
	}
	public void setM_date(String m_date) {
		this.m_date = m_date;
	}
	public String getM_youtube() {
		return m_youtube;
	}
	public void setM_youtube(String m_youtube) {
		this.m_youtube = m_youtube;
	}
	public String getM_file() {
		return m_file;
	}
	public void setM_file(String m_file) {
		this.m_file = m_file;
	}
	public int getM_count() {
		return m_count;
	}
	public void setM_count(int m_count) {
		this.m_count = m_count;
	}
	public String getM_contents() {
		return m_contents;
	}
	public void setM_contents(String m_contents) {
		this.m_contents = m_contents;
	}
	public Timestamp getM_reg_date() {
		return m_reg_date;
	}
	public void setM_reg_date(Timestamp m_reg_date) {
		this.m_reg_date = m_reg_date;
	}
	public int getM_re_total() {
		return m_re_total;
	}
	public void setM_re_total(int m_re_total) {
		this.m_re_total = m_re_total;
	}
	public int getM_re_star() {
		return m_re_star;
	}
	public void setM_re_star(int m_re_star) {
		this.m_re_star = m_re_star;
	}
	
	
}
