package core.ui 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import patterns.strategy.StrategyController;
	/**
	 * ...
	 * @author 
	 */
	public class KeyBoardController 
	{
		
		public static const UP_KEY_SIGNATURE:String = 'UP';
		
		private var passedKeys:Object
		
		private var keyboardStrategyController:StrategyController;
		private var stage:Stage;
		
		public function KeyBoardController(stage:Stage) 
		{
			this.stage = stage;
			initilize();
		}
		
		public function isKeyDown(code:uint):Boolean
		{
			return passedKeys[code.toString()] != null;
		}
		
		private function initilize():void 
		{
			passedKeys = { };
			keyboardStrategyController = new StrategyController();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function destroy():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			var code:String = e.keyCode.toString();
			
			delete passedKeys[code];
			
			
			keyboardStrategyController.execute(code + UP_KEY_SIGNATURE);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			var code:String = e.keyCode.toString();

			if (passedKeys[code])
				return
			else
			{
				passedKeys[code] = 1;
				keyboardStrategyController.execute(code);
			}
		}
		
		public function registerKeyDownReaction(key:uint, reaction:Function):void
		{
			keyboardStrategyController.crateNewStrategy(key.toString(), reaction);
		}
		
		public function registerKeyUpReaction(key:uint, reaction:Function):void
		{
			keyboardStrategyController.crateNewStrategy(key.toString() + UP_KEY_SIGNATURE, reaction);
		}
		
	}

}