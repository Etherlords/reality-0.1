package example.controller 
{
	
	import example.model.Movie;
	import example.model.MovieListModel;
	import example.moviefinders.FakeMovieFinder;
	import example.moviefinders.StandartMovieFinder;
	import example.movieLister.MovieLister;
	
	import example.view.MovieList;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author 
	 */
	public class MovieListController 
	{
		public var model:MovieListModel;
		public var view:MovieList;
		private var instance:DisplayObjectContainer;
		
		private var moviesListService:MovieLister;
		
		public function MovieListController(instance:DisplayObjectContainer) 
		{
			this.instance = instance;
			initilize();
		}
		
		private function initilize():void 
		{
			moviesListService = new MovieLister();
			
			model = new MovieListModel();
			view = new MovieList(model);
		}
		
		public function showList():void
		{
			instance.addChild(view);
		}
		
		public function setStandartMovieLister():void
		{
			var finder:StandartMovieFinder = new StandartMovieFinder();
			moviesListService.injectMovieFinder(finder);
		}
		
		public function setFakeMovieLister():void
		{
			var finder:FakeMovieFinder = new FakeMovieFinder();
			moviesListService.injectMovieFinder(finder);
		}
		
		public function fillMoviesList():void
		{
			var listOfMovies:Vector.<Movie>  = moviesListService.getMoviesList(model.filter);
			
			model.listOfMovies = listOfMovies;
		}
		
	}

}