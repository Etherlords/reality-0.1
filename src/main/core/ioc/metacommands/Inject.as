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
		
		public static const ID:String = 'id';
 
		public function Inject() 
		{
			
		}
		
		override public function executeMethod(methodInfo:MethodInfo, object:Object, context:Context):void 
		{
			var isIdInjection:Boolean = ID in methodInfo.tagArgs;
			var injectObject:Object 
			//var ijectType:String = 'interfaceInjection';
			
			if (isIdInjection)
			{
				injectObject = context.getObjectById(methodInfo.tagArgs[ID].value);
				//ijectType = 'idInjection';
			}
			else
			{
				injectObject = context.getObjectByInterface(methodInfo.methodType);
				
				
				if (!injectObject)
				{
					//ijectType = 'objectTypeInjection';
					injectObject = context.getObjectByType(methodInfo.methodType);
				}
			}
				
			
			
			
			
			if (!injectObject)
			{
				var s:String = "Warning: try to inject ";
				if (isIdInjection)
					s += methodInfo.tagArgs[ID].value;
				else
					s += methodInfo.methodType;
					
				s += ' to ' + object + ' but injection object was not found';
				
				trace(s);
			}
			
			object[methodInfo.methodName] = injectObject;
			//trace('do '+ijectType, injectObject, 'to', methodInfo.methodName, 'of', object);
		}
		
	}
 
}