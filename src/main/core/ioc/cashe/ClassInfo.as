package core.ioc.cashe 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class ClassInfo 
	{
		private var _className:String;
		private var _classDescribeInfo:XML;
		
		public function ClassInfo(className:String, classDescribeInfo:XML) 
		{
			_className = className;
			_classDescribeInfo = classDescribeInfo;
		}
		
		public function get className():String 
		{
			return _className;
		}
		
		public function get classDescribeInfo():XML 
		{
			return _classDescribeInfo;
		}
		
	}

}