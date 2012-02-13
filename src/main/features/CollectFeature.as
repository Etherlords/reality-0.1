package features 
{
	import core.Box2D.utils.Box2DWorldController;
	import core.view.gameobject.GameObject;
	import ui.rabbit.FlapTriggerGameObject;
	import ui.rabbit.Rabbit;
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
			
			for (var i:int = 0; i < list.length; i++)
			{
				if (!(list[i] is Rabbit) && !(list[i] is FlapTriggerGameObject))
				{
					trace(list[i] is Rabbit);
					list[i].physicalProperties.applyImpulse(0, 15);
				}
			}
		}
		
	}

}