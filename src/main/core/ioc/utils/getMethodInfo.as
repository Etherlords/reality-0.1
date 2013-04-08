package core.ioc.utils 
{
	import core.ioc.cashe.MetaArg;
	import core.ioc.cashe.MethodInfo;
	
	public function getMethodInfo(methodInfo:Object):MethodInfo
	{
		var name:String = methodInfo.@name;
		var type:String = methodInfo.@type;
		var metadata:XML = methodInfo..metadata[0];
		
		//var metaargs:XMLList = methodInfo..metadata;
		
		var args:Object = { };
		var arg:MetaArg;
		var argsInfo:XMLList = metadata..arg;
		var l:int = argsInfo.length();
		for (var i:int = 0; i < l; ++i)
		{
			args[argsInfo[i].@key] = new MetaArg(argsInfo[i].@key, argsInfo[i].@value);
		}
		
		//var metaArgs:Array = 
		
		var method:MethodInfo = new MethodInfo(name, type, metadata.@name, args);
		
		return method;
	}


}