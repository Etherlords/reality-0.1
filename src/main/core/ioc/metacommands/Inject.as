package core.ioc.metacommands 
{
	import core.ioc.cashe.MethodInfo;
	import core.ioc.Context;
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
			var isIdInjection:Boolean = 'id' in methodInfo.tagArgs;
			var injectObject:Object 
			
			if (isIdInjection)
			{
				injectObject = context.getObjectById(methodInfo.tagArgs['id'].value);
			}
			else
				injectObject = context.getObjectByType(methodInfo.methodType);
			
			object[methodInfo.methodName] = injectObject;
			//trace('do injection', injectObject, 'to', methodInfo.methodName, 'of', object);
		}
		
	}

}