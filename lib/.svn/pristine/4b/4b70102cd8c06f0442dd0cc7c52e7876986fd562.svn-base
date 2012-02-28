package example.model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class MovieListModel extends EventDispatcher 
	{
		private var _listOfMovies:Vector.<Movie>
		private var _filter:Function;
		
		public function MovieListModel(target:IEventDispatcher=null) 
		{
			super(target);
			
			initilize();
		}
		
		private function initilize():void 
		{
			_listOfMovies = new Vector.<Movie>;
		}
		
		public function get listOfMovies():Vector.<Movie> 
		{
			return _listOfMovies;
		}
		
		public function set listOfMovies(value:Vector.<Movie>):void 
		{
			_listOfMovies = value;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get filter():Function 
		{
			return _filter;
		}
		
		public function set filter(value:Function):void 
		{
			_filter = value;
		}
		
	}

}