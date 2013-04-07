package core.collections 
{
	/**
	 * ...
	 * @author 
	 */
	public class SimpleMap 
	{
		private var _length:int = 0;
		private var map:Object;
		
		public function SimpleMap() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			map = { };
		}
		
		public function getItem(key:String):*
		{
			return map[key];
		}
		
		public function addItem(key:String, item:*):void
		{
			map[key] = item;
			_length++;
		}
		
		public function removeItem(key:String):void
		{
			if (!(key in map))
				return;
				
			delete map[key];
			_length--;
		}
		
		public function get length():int 
		{
			return _length;
		}
		
	}

}