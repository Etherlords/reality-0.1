package features 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.GameObject;
	import flash.geom.Point;
	import ui.gameobjects.BaseInteractiveGameObject;
	import ui.rabbit.FlapTriggerGameObject;
	import ui.rabbit.Rabbit;
	import utils.DimensionalMath;
	/**
	 * ...
	 * @author 
	 */
	public class MagnetField 
	{
	
		private var worldController:Box2DWorldController;
		private var applicationPoint:Point;
		
		public function MagnetField(worldController:Box2DWorldController, applicationPoint:Point) 
		{
			this.applicationPoint = applicationPoint;
			this.worldController = worldController;
		}
		
		public function doAction(force:Number, radius:Number, polarity:Boolean, filter:Function = null):void
		{
			var polarityForce:Number = 0;
			if (polarity)
				polarityForce = 1;
			else
				polarityForce = -1;
			
			var list:Vector.<GameObject> = worldController.gameObjectRegistryController.getObjectsInRadius(applicationPoint, radius, filter);
			var dir:Point = new Point();
			
			for (var i:int = 0; i < list.length; i++)
			{
				//if ()
				//{
					
					var center:Point = list[i].body.position;
					center.x += list[i].body.width / 2;
					center.y += list[i].body.height / 2;
					
					var ang:Number = DimensionalMath.angle(applicationPoint, center);
					
					var distance:Number = DimensionalMath.distance(applicationPoint, center);
					//trace(applicationPoint.y, center.y);
					var forceUsage:Number = 1 - distance / radius;
					
					var intensity:Number = force * polarityForce * forceUsage;
					
					var currVel:Point = list[i].physicalProperties.physicModel.linearVelocity;

					dir.x = currVel.x + intensity * Math.cos(ang);
					dir.y = currVel.y + intensity * Math.sin(ang);
					
					//trace(dir.x, dir.y);

					list[i].physicalProperties.applyForce (dir.x, dir.y);
				//}
			}
		}
		


	}

}