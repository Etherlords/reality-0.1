package features 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.GameObject;
	import flash.geom.Point;
	import ui.rabbit.FlapTriggerGameObject;
	import ui.rabbit.Rabbit;
	import utils.DimensionalMath;
	/**
	 * ...
	 * @author 
	 */
	public class CollectFeature 
	{
		private var rabbit:Rabbit;
		private var worldController:Box2DWorldController;
		
		public function CollectFeature(worldController:Box2DWorldController, rabbit:Rabbit) 
		{
			this.worldController = worldController;
			this.rabbit = rabbit;
			
		}
		
		public function doAction():void
		{
			var list:Vector.<GameObject> = worldController.getGameObjectsInRadius(rabbit.body.position, 300, null);
			var dir:Point = new Point();
			
			trace(list);
			for (var i:int = 0; i < list.length; i++)
			{
				if (!(list[i] is Rabbit) && !(list[i] is FlapTriggerGameObject))
				{
					var ang:Number = DimensionalMath.angle(rabbit.body.position, list[i].body.position);
					
					var intensity:Number = 100;
					var currVel:Point = list[i].physicalProperties.linearVelocity;

					dir.x = currVel.x + intensity * Math.cos(ang);
					dir.y = currVel.y + intensity * Math.sin(ang);
					
					

					list[i].physicalProperties.applyForce (dir.x, dir.y);
				}
			}
		}
		


	}

}