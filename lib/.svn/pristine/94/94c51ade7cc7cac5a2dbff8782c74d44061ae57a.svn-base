package 
{
	import example.Button;
	import example.controller.MovieListController;
	import flash.events.MouseEvent;
	import help.MoviesModelsEditor;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var movieList:MovieListController;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			/*var tf:TextField = new TextField();
			tf.text = 'Hello mojo!';
			
			addChild(tf);
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = (stage.stageWidth - tf.width) / 2;
			tf.y = (stage.stageHeight - tf.height) / 2;*/
			
			movieList = new MovieListController(this);
			movieList.showList();
			
			movieList.setFakeMovieLister();
			
			movieList.fillMoviesList();
			
			
			var editor:MoviesModelsEditor = new MoviesModelsEditor(movieList.model)
			addChild(editor);
			
			editor.x = 500;
			
			var buttonSetFakeMovies:Button = new Button("Set Fakes Movies");
			var buttonSetMoviesFromLib:Button = new Button("Set Lib Movies");
			
			addChild(buttonSetFakeMovies);
			addChild(buttonSetMoviesFromLib);
			
			buttonSetFakeMovies.y = 500;
			buttonSetMoviesFromLib.y = 500;
			buttonSetMoviesFromLib.x = buttonSetFakeMovies.x + buttonSetFakeMovies.width + 10;
			
			buttonSetFakeMovies.addEventListener(MouseEvent.CLICK, setFake);
			buttonSetMoviesFromLib.addEventListener(MouseEvent.CLICK, setLib);
			
		}
		
		private function setLib(e:MouseEvent):void 
		{
			movieList.setStandartMovieLister();
			movieList.fillMoviesList();
		}
		
		private function setFake(e:MouseEvent):void 
		{
			movieList.setFakeMovieLister();
			movieList.fillMoviesList();
		}
		
	}
	
}