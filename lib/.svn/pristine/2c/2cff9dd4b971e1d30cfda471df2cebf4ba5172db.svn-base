package example.movieLister 
{
	import example.model.Movie;
	import example.moviefinders.MockMovieFinder;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author 
	 */
	public class MovieListerTest 
	{
		public function MovieListerTest() 
		{
			super();
		}
		
		[DataPoint]
		private var movieLister:MovieLister = new MovieLister();
		
		[DataPoint]
		private var movieFinder:MockMovieFinder = new MockMovieFinder();
		
		[Before]
		public function setUp():void 
		{
			movieLister.injectMovieFinder(movieFinder);
		}
		
		[Test]
		public function testMovieFinderGetMoviesList():void
		{
			var list:Vector.<Movie> = movieLister.getMoviesList();
			
			assertThat(list, not(equalTo(null)));
		}
		
		[Test]
		public function testMovieFinderGetMoviesListFail():void
		{
			movieFinder.isFail = true;
			
			var list:Vector.<Movie> = movieLister.getMoviesList();
			
			assertThat(list, equalTo(null));
			assertThat(movieFinder.isFail, equalTo(true));
		}
	}

}