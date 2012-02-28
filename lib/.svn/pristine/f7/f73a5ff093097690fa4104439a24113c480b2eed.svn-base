package example.model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class Movie extends EventDispatcher 
	{
		
		private var _movieName:String;
		private var _movieDescription:String;
		
		public function Movie(target:IEventDispatcher=null) 
		{
			super(target);
			
		}
		
		public function change():void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get movieDescription():String 
		{
			return _movieDescription;
		}
		
		public function set movieDescription(value:String):void 
		{
			_movieDescription = value;
		}
		
		public function get movieName():String 
		{
			return _movieName;
		}
		
		public function set movieName(value:String):void 
		{
			_movieName = value;
			
		}
		
	}

}