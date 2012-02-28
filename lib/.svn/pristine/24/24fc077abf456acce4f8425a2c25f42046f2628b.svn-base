package example.view 
{
	import example.model.Movie;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author 
	 */
	public class MovieListElement extends Sprite 
	{
		private var _editable:Boolean = false;
		private var movie:Movie;
		private var movieName:TextField;
		private var movieDecription:TextField;
		private var movieLable:TextField;
		private var dectiptionLable:TextField;
		
		public function MovieListElement(movie:Movie = null) 
		{
			super();
			this.movie = movie;
			
			initilize();
		}
		
		public function submitDataToModel():void
		{
			movie.movieName = movieName.text;
			movie.movieDescription = movieDecription.text;
			movie.change();
		}
		
		public function clear():void
		{
			movieName.text = '';
			movieDecription.text = '';
			movie = null;
		}
		
		public function setMovie(model:Movie):void
		{
			initModel(model);
		}
		
		private function initilize():void 
		{
			createViewComponents();
			align();
			draw();
			
			initModel(movie);
		}
		
		private function draw():void 
		{
			this.graphics.lineStyle(1, 0x0);
			this.graphics.moveTo(0, movieDecription.y + movieDecription.height);
			this.graphics.lineTo(300, movieDecription.y + movieDecription.height);
		}
		
		private function align():void 
		{
			movieName.x = movieLable.x + movieLable.width;
			movieName.y = 0;
			
			movieDecription.x = dectiptionLable.x + dectiptionLable.width;
			dectiptionLable.y = movieLable.y + movieLable.height;
			movieDecription.y = dectiptionLable.y;
		}
		
		private function initModel(model:Movie):void
		{
			if (model)
			{
				if(movie)
					if (movie.hasEventListener(Event.CHANGE))
						movie.removeEventListener(Event.CHANGE, updateView);
			}
			else
				return;
					
			movie = model;
			
			movie.addEventListener(Event.CHANGE, updateView);
			
			updateView();
		}
		
		private function createViewComponents():void 
		{
			movieName = new TextField();
			movieLable = new TextField();
			
			movieDecription = new TextField();
			dectiptionLable = new TextField();
			
			movieName.autoSize = movieDecription.autoSize = TextFieldAutoSize.LEFT;
			dectiptionLable.autoSize = movieLable.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(movieName);
			addChild(movieLable);
			addChild(movieDecription);
			addChild(dectiptionLable);
			
			movieName.text = ''
			movieLable.text = 'Название:'
			movieDecription.text = ''
			dectiptionLable.text = 'Описание:'
		}
		
		private function updateView(e:Event = null):void 
		{
			movieName.text = movie.movieName;
			movieDecription.text = movie.movieDescription;
		}
		
		public function get editable():Boolean 
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void 
		{
			_editable = value;
			
			if (_editable)
			{
				movieName.type = movieDecription.type = TextFieldType.INPUT;
			}
			else
				movieName.type = movieDecription.type = TextFieldType.DYNAMIC;
		}
		
	}

}