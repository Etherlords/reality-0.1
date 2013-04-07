package core.ioc.utils 
{

	import core.ioc.cashe.ClassInfo;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	public function getClassInfo(object:Object):ClassInfo
	{
		var name:String = getQualifiedClassName(object);
		var info:XML = describeType(object);
		
		var classInfo:ClassInfo = new ClassInfo(name, info);
		
		return classInfo;
	}
}