package core.ioc.cashe 
{
	//import core.collections.SimpleMap;

	/**
	 * ...
	 * @author Nikro
	 */
	public class ClassCashe 
	{
		private var _classInfo:ClassInfo;
		
		private var _methods:Vector.<MethodInfo> = new Vector.<MethodInfo>()
		//private var _functions:Vector.<Object> = new Vector.<Object>()
		
		//private var _methods:SimpleMap = new SimpleMap()
		//private var _functions:SimpleMap = new SimpleMap()
		
		public function ClassCashe(classInfo:ClassInfo) 
		{
			_classInfo = classInfo;
		}
		
		/*public function addFunction(cashe:Object):void
		{
			
		}*/
		
		public function addMethod(cashe:MethodInfo):void
		{
			_methods.push(cashe);
			//_methods.addItem(cashe.methodName, cashe);
		}
		
		public function get classInfo():ClassInfo 
		{
			return _classInfo;
		}
		
		public function get methods():Vector.<MethodInfo> 
		{
			return _methods;
		}
		
		/*public function get functions():Vector.<Object> 
		{
			return _functions;
		}*/
		
		public function toString():String
		{
			return '[ClassCashe (className = ' + _classInfo.className + ', methodsLength = ' + _methods.length + ', functionsLength = ' + _functions.length + ')]';
		}
		
	}

}