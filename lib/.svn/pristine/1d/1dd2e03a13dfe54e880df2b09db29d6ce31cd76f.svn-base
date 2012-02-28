package example.moviefinders 
{
	import example.Library;
	import example.model.Movie;

	
	/**
	 * ...
	 * @author 
	 */
	public class StandartMovieFinder implements IMovieFinder 
	{
		
		
		
		public function StandartMovieFinder() 
		{
			
		}
		
		/* INTERFACE example.moviefiners.IMovieFinder */
		
		public function getMovies():Vector.<Movie> 
		{
			var list:Vector.<Movie> = new Vector.<Movie>;
			
			for each(var xml:XML in Library.library.movie)
			{
				var movie:Movie = new Movie();
				movie.movieDescription = xml.toString();
				movie.movieName = xml.@movieName;
				
				list.push(movie);
			}
			
			return list;
		}
		
	}

}