package core.ioc.utils 
{
	import core.ioc.cashe.MethodInfo;
	
	public function getMethodInfo(methodInfo:Object):MethodInfo
	{
		var name:String = methodInfo.@name;
		var type:String = methodInfo.@type;
		//var metaArgs:Array = methodInfo..metadata[0].arg
		
		var method:MethodInfo = new MethodInfo(name, type);
		
		return method;
	}


}