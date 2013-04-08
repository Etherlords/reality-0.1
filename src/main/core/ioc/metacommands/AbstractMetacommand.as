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
		protected var tag:String;
		
		public function AbstractMetacommand() 
		{
			tag = this['toString']().split('[object ').join('').split(']').join('')
		}
		
		public function executeMethod(methodInfo:MethodInfo, object:Object, context:Context):void
		{
			
		}
		
		public function getTag():String
		{
			return tag;
		}
		
	}

}