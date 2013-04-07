package core.ioc.cashe 
{
	import core.collections.SimpleMap;

	/**
	 * ...
	 * @author Nikro
	 */
	public class ClassCashe 
	{
		private var _classInfo:ClassInfo;
		
		private var _methods:SimpleMap = new SimpleMap()
		private var _functions:SimpleMap = new SimpleMap()
		
		public function ClassCashe(classInfo:ClassInfo) 
		{
			_classInfo = classInfo;
		}
		
		public function addFunction(cashe:Object):void
		{
			
		}
		
		public function addMethod(cashe:MethodInfo):void
		{
			_methods.addItem(cashe.methodName, cashe);
		}
		
		public function get classInfo():ClassInfo 
		{
			return _classInfo;
		}
		
		public function get methods():SimpleMap 
		{
			return _methods;
		}
		
		public function get functions():SimpleMap 
		{
			return _functions;
		}
		
		public function toString():String
		{
			return '[ClassCashe (className = ' + _classInfo.className + ', methodsLength = ' + _methods.length + ', functionsLength = ' + _functions.length + ')]';
		}
		
	}

}