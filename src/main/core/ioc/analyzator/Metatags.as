package core.ioc.analyzator 
{
	import core.collections.SimpleMap;
	import core.ioc.metacommands.AbstractMetacommand;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Metatags 
	{
		private var _metatags:Vector.<AbstractMetacommand> = new Vector.<AbstractMetacommand>();
		private var _metamap:SimpleMap = new SimpleMap();
		
		public function Metatags() 
		{
			super();
		}
		
		public function addTag(clazz:Class):void
		{
			var command:AbstractMetacommand = new clazz;
			
			_metamap.addItem(command.getTag(), command);
			_metatags.push(command);
		}
		
		public function getCommand(key:String):AbstractMetacommand
		{
			return _metamap.getItem(key);
		}
		
		public function get metatags():Vector.<AbstractMetacommand> 
		{
			return _metatags;
		}
		
		public function get metamap():SimpleMap 
		{
			return _metamap;
		}
		
		
	}

}