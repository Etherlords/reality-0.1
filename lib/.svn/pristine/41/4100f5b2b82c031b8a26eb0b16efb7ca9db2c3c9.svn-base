package	help
{
	import example.model.MovieListModel;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author 
	 */
	public class MoviesModelsEditorTest 
	{
		
		public function MoviesModelsEditorTest() 
		{
			super();
		}
		
		private var moviesListEditor:MoviesModelsEditor;
		
		
		[Before]
		[Test]
		public function creationTest():void
		{
			var model:MovieListModel = new MovieListModel();
			
			moviesListEditor = new MoviesModelsEditor(model);
		}
		
		[Test(ui)]
		public function someUiTests():void
		{
			
			
			for (var i:int = 0; i < moviesListEditor.moviesList.listElements.length; i++)
			{
				assertThat('in list element: ' + i, moviesListEditor.moviesList.listElements[i].editable, equalTo(true));
			}
		}
		
	}

}