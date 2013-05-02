package  
{
	import core.ioc.Context;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class TestMain extends Sprite 
	{
		
		public function TestMain() 
		{
			super();
			
			var context:Context = Context.instance;
			var o:TestObject = new TestObject;
			context.addObjectToContext(o);
			
			inject(o);
			
		}
		
	}

}