package core.ioc.utils 
{
	import core.ioc.cashe.MethodInfo;
	
	public function getMethodInfo(methodInfo:Object):MethodInfo
	{
		var name:String = methodInfo.@name;
		var type:String = methodInfo.@type;
		var metadata:XML = methodInfo..metadata[0];
		
		//trace(methodInfo..metadata);
		//var metaArgs:Array = 
		
		var method:MethodInfo = new MethodInfo(name, type, metadata.@name);
		
		return method;
	}


}