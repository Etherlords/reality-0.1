package  example.movieLister
{
	import example.model.Movie;
	import example.model.MovieListModel;
	import example.moviefinders.IMovieFinder;

	/**
	 * ...
	 * @author 
	 */
	public class MovieLister 
	{	
		private var movieFinder:IMovieFinder;
		
		public function MovieLister() 
		{
			
		}
		
		public function injectMovieFinder(movieFinder:IMovieFinder):void
		{
			this.movieFinder = movieFinder;
		}
		
		public function getMoviesList(filter:Function = null):Vector.<Movie>
		{
			var list:Vector.<Movie> = movieFinder.getMovies();
			
			//if(filter != null)
			//	list = list.filter(filter);
				
			return list;
		}
		
		private function sortMovies():void
		{
			
		}
		
	}

}