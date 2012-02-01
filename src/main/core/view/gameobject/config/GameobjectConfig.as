package core.view.gameobject.config 
{
import core.view.skin.Skin;

/**
	 * ...
	 * @author 
	 */
	public class GameobjectConfig 
	{
		
		private var _isUsePhisicWorld:Boolean;
		
		private var _physicConfiguration:PhysicConfiguration;

        public var skinClass:Class = Skin;

		public function GameobjectConfig(isUsePhisicWorld:Boolean = false) 
		{
			_isUsePhisicWorld = isUsePhisicWorld;
			initilize();
		}
		
		private function initilize():void 
		{
			if(isUsePhisicWorld)
				_physicConfiguration = new PhysicConfiguration();
		}
		
		public function get physicConfiguration():PhysicConfiguration 
		{
			return _physicConfiguration;
		}
		
		public function set physicConfiguration(value:PhysicConfiguration):void 
		{
			_physicConfiguration = value;
		}
		
		public function get isUsePhisicWorld():Boolean 
		{
			return _isUsePhisicWorld;
		}
		
		public function set isUsePhisicWorld(value:Boolean):void 
		{
			_isUsePhisicWorld = value;
		}
		
	}

}