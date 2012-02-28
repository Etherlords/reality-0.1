package example.moviefinders 
{
	import example.model.Movie;
	/**
	 * ...
	 * @author 
	 */
	public class FakeMovieFinder implements IMovieFinder 
	{
		
		public function FakeMovieFinder() 
		{
			
		}
		
		/* INTERFACE example.moviefinders.IMovieFinder */
		
		public function getMovies():Vector.<Movie> 
		{
			var list:Vector.<Movie> = new Vector.<Movie>;
			for (var i:int = 0; i < 10; i++)
			{
				var movie:Movie = new Movie();
				
				movie.movieName = 'Spacemarine legion: ' + Math.floor(Math.random() * 100);
				movie.movieDescription = 'In the future there is only war....';
				
				list.push(movie);
				
			}
			
			return list;
		}
		
	}

}