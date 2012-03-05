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
			
			var object:GameObject;
			for each(object in objectsList)
			{
				if(DimensionalMath.inRadius(radius, applicationPoint, object.body.position))
					list.push(object);
			}
			
			return list;
		}
		
	}

}