package patterns 
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Moderator extends EventDispatcher
	{
		protected var fieldsChanged:Object;
		
		public function Moderator() 
		{
			initilize();
		}
		
		protected function initilize():void 
		{
			cleanFields();
		}
		
		public function cleanFields():void
		{
			fieldsChanged = { };
		}
		
		public function getFieldsList():Object
		{
			return fieldsChanged
		}
		
		public function moderateField(str:String):void
		{
			fieldsChanged[str] = new int();
		}
		
	}

}