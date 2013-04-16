package core.ioc.analyzator
{
	import core.collections.SimpleMap;
	import core.ioc.cashe.ClassCashe;
	import core.ioc.cashe.ClassInfo;
	import core.ioc.cashe.MethodInfo;
	import core.ioc.Context;
	import core.ioc.metacommands.AbstractMetacommand;
	import core.ioc.utils.getClassInfo;
	import core.ioc.utils.getMethodInfo;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Nikro
	 */
	
	[Inject]
	public class MetatagProcessor
	{
		private var context:Context;
		private var cashe:SimpleMap = new SimpleMap();
	
		public function MetatagProcessor(context:Context)
		{
			if ( describeType( MetatagProcessor )..metadata.(@name == "Inject").length() == 0 )
			{
				throw new Error( "Please add -keep-as3-metadata+=Inject to flex compiler arguments!" )
			}
			
			this.context = context;
		}
		
		public function process(object:Object):void
		{
			var key:String = getQualifiedClassName(object);
			var classCashe:ClassCashe = cashe.getItem(key)
			
			if (classCashe)
			{
				processCashed(classCashe, object)
				return;
			}
			
			var len:int = context.metatags.metatags.length;
			var nodesLength:int = 0;
			
			var tag:String;
			
			var commandClass:Class
			var metaCommand:AbstractMetacommand;
			
			var processedNodes:Object;
			var currentNode:Object;
			
			var classInfo:ClassInfo = getClassInfo(object);
			var info:XML = classInfo.classDescribeInfo;
			classCashe = new ClassCashe(classInfo);
			
			var processedMethod:MethodInfo;
			
			for (var i:int = 0; i < len; ++i)
			{
				metaCommand = context.metatags.metatags[i];
				tag = metaCommand.getTag();
				
				
				processedNodes = info..variable.metadata.(@name == tag);
				
				nodesLength = processedNodes.length();
				
				for (var j:int = 0; j < nodesLength; ++j)
				{
					currentNode = processedNodes[j].parent();
					processedMethod = getMethodInfo(currentNode);
					classCashe.addMethod(processedMethod);
					metaCommand.executeMethod(processedMethod, object, context);
				}
			}
			
			cashe.addItem(classCashe.classInfo.className, classCashe);
			trace(classCashe);
		}
		
		private function processCashed(classCashe:ClassCashe, object:Object):void 
		{
			var l:int = classCashe.methods.length;
			var currentMethod:MethodInfo;
			for (var i:int = 0; i < l; ++i)
			{
				currentMethod = classCashe.methods[i]
				context.metatags.getCommand(currentMethod.metaType).executeMethod(currentMethod, object, context);
			}
		}
	
	}

}