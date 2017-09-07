package boxoffice.banner.model;

public class BannerVO {
	private int banner_id;
	private String banner_name;
	private String banner_file;
	public int getBanner_id() {
		return banner_id;
	}
	public void setBanner_id(int banner_id) {
		this.banner_id = banner_id;
	}
	public String getBanner_name() {
		return banner_name;
	}
	public void setBanner_name(String banner_name) {
		this.banner_name = banner_name;
	}
	public String getBanner_file() {
		return banner_file;
	}
	public void setBanner_file(String banner_file) {
		this.banner_file = banner_file;
	}
}
