package core.ioc.analyzator
{
	import core.ioc.cashe.ClassCashe;
	import core.ioc.cashe.ClassInfo;
	import core.ioc.cashe.DescribeCashe;
	import core.ioc.cashe.MethodInfo;
	import core.ioc.Context;
	import core.ioc.metacommands.AbstractMetacommand;
	import core.ioc.utils.getClassInfo;
	import core.ioc.utils.getMethodInfo;
	import flash.utils.describeType;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class MetatagProcessor
	{
		private var context:Context;
		private var cashe:DescribeCashe = new DescribeCashe();
		
		public function MetatagProcessor(context:Context)
		{
			this.context = context;
		}
		
		public function process(object:Object):void
		{
			var t:Number = getTimer();
			var len:int = Metatags.PROCESSED_TAGS.length;
			var nodesLength:int = 0;
			
			var tag:String;
			
			var commandClass:Class
			var metoCommand:AbstractMetacommand;
			
			var processedNodes:Object;
			var currentNode:Object;
			
			var classInfo:ClassInfo = getClassInfo(object);
			var info:XML = classInfo.classDescribeInfo;
			var classCashe:ClassCashe = new ClassCashe(classInfo);
			
			var processedMethod:MethodInfo;
			
			for (var i:int = 0; i < len; ++i)
			{
				commandClass = Metatags.PROCESSED_TAGS[i]
				tag = Metatags.PROCESSED_TAGS[i].toString().split('[class ').join('').split(']').join('');
				
				processedNodes = info..variable.metadata.(@name == tag);
				metoCommand = new commandClass();
				
				nodesLength = processedNodes.length();
				
				for (var j:int = 0; j < nodesLength; ++j)
				{
					currentNode = processedNodes[j].parent();
					processedMethod = getMethodInfo(currentNode);
					classCashe.addMethod(processedMethod);
					metoCommand.executeMethod(processedMethod, object, context);
				}
			}
			
			trace(classCashe);
			
		}
	
	}

}