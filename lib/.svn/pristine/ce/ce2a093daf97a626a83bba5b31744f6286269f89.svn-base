package example.moviefinders 
{
	import example.model.Movie;
	/**
	 * ...
	 * @author 
	 */
	public class MockMovieFinder implements IMovieFinder 
	{
		
		private var _isFail:Boolean = false;
		
		public function MockMovieFinder() 
		{
			
		}
		
		/* INTERFACE example.moviefinders.IMovieFinder */
		
		public function getMovies():Vector.<Movie> 
		{
			
			if (_isFail)
				return null;
			
			var movie1:Movie = new Movie();
			var movie2:Movie = new Movie();
			var movie3:Movie = new Movie();
			
			movie1.movieName = 'movie1';
			movie1.movieDescription = 'moviedecription1';
			
			movie1.movieName = 'movie2';
			movie1.movieDescription = 'moviedecription2';
			
			movie1.movieName = 'movie3';
			movie1.movieDescription = 'moviedecription3';
			
			return new <Movie>[movie1, movie2, movie3];
		}
		
		public function get isFail():Boolean 
		{
			return _isFail;
		}
		
		public function set isFail(value:Boolean):void 
		{
			_isFail = value;
		}
		
	}

}