package boxoffice.movie.model;

import java.util.ArrayList;

import boxoffice.common.util.PagingVO;

public interface MovieService {

	//select
	public ArrayList<MovieVO> selectMovie(MovieVO movieVO);
	
	//select search
	public ArrayList<MovieVO> selectMovie(MovieVO movieVO, PagingVO pagingVO);
	
	//select detail
	public MovieVO detailMovie(int m_id);
	
	//select count
	public int selectMovieCount(PagingVO pagingVO);
	
	//insert
	public boolean insertMovie(MovieVO movieVO);
	
	//delete
	public boolean deleteMovie(int m_id);
	
	//update
	public boolean updateMovie(MovieVO movieVO);
}
