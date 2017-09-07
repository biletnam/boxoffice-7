package boxoffice.banner.model;

import java.util.ArrayList;

public interface BannerService {
	
	//banner insert
	public boolean insertBanner(BannerVO BannerVO);
	
	//banner select
	public ArrayList<BannerVO> selectBanner();
	
	//banner delete
	public void deleteBanner(String id);
}
