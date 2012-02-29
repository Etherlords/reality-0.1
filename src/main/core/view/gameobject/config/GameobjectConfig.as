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
		
		public var type:uint

        public var skinClass:Class = Skin;

		public function GameobjectConfig(isUsePhisicWorld:Boolean = false) 
		{
			_isUsePhisicWorld = isUsePhisicWorld;
			initilize();
		}
		
		private function initilize():void 
		{
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