package core.ioc.cashe 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Nikro
	 */
	public class DescribeCashe 
	{
		private var cashe:Object = { };
		
		public function DescribeCashe() 
		{
			
		}
		
		public function addCashe(obj:Object, info:XML):void
		{
			var key:String = getQualifiedClassName(obj);
			cashe[key] = info;
		}
		
		public function getCashe(obj:Object):XML
		{
			var key:String = getQualifiedClassName(obj);
			return cashe[key];
		}
	}

}