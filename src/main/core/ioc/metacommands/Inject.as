package core.ioc.metacommands 
{
	import core.ioc.Context;
	import core.ioc.cashe.MethodInfo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Inject extends AbstractMetacommand
	{

		public function Inject() 
		{
			
		}
		
		override public function executeMethod(methodInfo:MethodInfo, object:Object, context:Context):void 
		{
			var injectObject:Object = context.getObjectByType(methodInfo.methodType);
			object[methodInfo.methodName] = injectObject;
			
			trace('do injection', injectObject, 'to', methodInfo.methodName, 'of', object);
		}
		
	}

}