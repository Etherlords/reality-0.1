package example.moviefinders 
{
	import example.Library;
	import example.model.Movie;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author 
	 */
	public class StandartMovieFinderTest 
	{
		
		public function StandartMovieFinderTest() 
		{
			super();
		}
		
		[DataPoint]
		public static var movieFinder:StandartMovieFinder = new StandartMovieFinder();
		
		[Test]
		public function testGetMovies():void
		{
			var list:Vector.<Movie> = movieFinder.getMovies();
			
			assertThat('the FakeMovieFinder should provide 10 elements on getMovies', list.length , equalTo(6));
			
			for (var i:int = 0; i < list.length; i++)
			{
				assertThat(list[i].movieDescription, equalTo(Library.library.movie[i].toString()));
				assertThat(list[i].movieName, equalTo(Library.library.movie[i].@movieName));
			}
		}
		

		
	}

}