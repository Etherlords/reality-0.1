/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 9:41
 */
package ui.rabbit 
{
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.lifetimeobject.LifeTimeGameObject;
	
	
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;


	public class FlapTriggerGameObject extends LifeTimeGameObject
	{

		private var _isAbleToFlap:Boolean;

		public function FlapTriggerGameObject(config:GameobjectConfig, skinHolderInstance:Sprite, eventFlowTarget:IEventDispatcher = null) {
			super(config, skinHolderInstance, eventFlowTarget);
		}


		override protected function initilize():void {
			super.initilize();
			_isAbleToFlap = true;
		}

		override protected function addLife(time:uint):void {
			super.addLife(time);
			if (lifeTime > 150) {
				_isAbleToFlap = true;

			}
		}

		public function flap():void {
			_isAbleToFlap = false;
			resetLifeTime();
		}

		public function isAbleToFlap():Boolean {
			return _isAbleToFlap;
		}


	}
}
