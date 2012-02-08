package gameactions 
{
	import patterns.strategy.Strategy;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleInteractiveObjectCreationAction extends Strategy 
	{
		
		public function SimpleInteractiveObjectCreationAction() 
		{
			super('SimpleInteractiveObjectCreationAction', doAction);
			
		}
		
		public function doAction():void 
		{
			//trace(key);
		}
		
	}

}