package core.Box2D.utils 
{
	import core.view.gameobject.GameObject;
	import flash.geom.Point;
	import utils.DimensionalMath;
	/**
	 * ...
	 * @author 
	 */
	public class GetGameobjectsInRadius 
	{
		private var registry:GameobjectsRegistry;
		
		public function GetGameobjectsInRadius(registry:GameobjectsRegistry) 
		{
			this.registry = registry;
			
		}
		
		public function execute(applicationPoint:Point, radius:Number, filter:*):Vector.<GameObject>
		{
			var list:Vector.<GameObject> = new Vector.<GameObject>
			var objectsList:Vector.<GameObject> = registry.objectsList;
			
			var isUseFilter:Boolean = filter != null;
			
			var object:GameObject;
			var len:int = objectsList.length;
			
			for (var i:int = 0; i < len; i++)
			{
				object = objectsList[i];
				
				if (DimensionalMath.inRadius(radius, applicationPoint, object.body.position))
				{
					if (isUseFilter)
					{
						if (filter(object))
							list.push(object);
					}
					else	
						list.push(object);
				}
			}
			
			return list;
		}
		
	}

}