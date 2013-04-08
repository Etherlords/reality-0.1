package core.ioc.metacommands 
{
	import core.ioc.cashe.MethodInfo;
	import core.ioc.Context;
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractMetacommand extends Object
	{
		
		public function AbstractMetacommand() 
		{
			
		}
		
		public function executeMethod(methodInfo:MethodInfo, object:Object, context:Context):void
		{
			
		}
		
		public function getTag():String
		{
			return this['toString']().split('[object ').join('').split(']').join('');
		}
		
	}

}