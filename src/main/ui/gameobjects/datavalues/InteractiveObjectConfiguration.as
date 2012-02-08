package ui.gameobjects.datavalues 
{
	import patterns.strategy.Strategy;
	/**
	 * ...
	 * @author 
	 */
	public class InteractiveObjectConfiguration 
	{
		private var _type:String
		
		private var _destructionAlgorithm:Strategy;
		private var _creationAlgorithm:Strategy;

		
		public function InteractiveObjectConfiguration(type:String = '', destructionAlgoritmh:Strategy = null, creationAlgorithm:Strategy = null) 
		{
			_type = type;
			_destructionAlgorithm = destructionAlgoritmh;
			_creationAlgorithm = creationAlgorithm;
		}
		
		public function get destructionAlgorithm():Strategy 
		{
			return _destructionAlgorithm;
		}
		
		public function set destructionAlgorithm(value:Strategy):void 
		{
			_destructionAlgorithm = value;
		}
		
		public function get creationAlgorithm():Strategy 
		{
			return _creationAlgorithm;
		}
		
		public function set creationAlgorithm(value:Strategy):void 
		{
			_creationAlgorithm = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
	}

}