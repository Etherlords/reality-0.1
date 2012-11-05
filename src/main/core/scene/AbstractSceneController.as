package core.scene 
{
	import core.states.events.StateEvents;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class AbstractSceneController extends EventDispatcher
	{
		protected var view:DisplayObjectContainer;
		protected var currentViewContainer:DisplayObjectContainer;
		
		protected var isActivated:Boolean = false;
		
		
		public function AbstractSceneController() 
		{
			initilize();
		}
		
		protected function setViewComponent(view:DisplayObjectContainer):void
		{
			this.view = view;
		}
		
		protected function initilize():void 
		{
			createUI();
		}
		
		/**
		 * Создаем уи при инициализации
		 * однако его скорее всгео лучше создавать
		 * после activate
		 */
		protected function createUI():void
		{
			
		}
		
		protected function exit():void
		{
			dispatchEvent(new StateEvents(StateEvents.STATE_OUT, true));
		}
		
		/**
		 * Сцена стала активной
		 * Тут мы должны иметь вью и добавить его на инстанс сцены
		 * чтобы визибл компоненты сцены соответственно были видимыми
		 */
		public function activate(instance:DisplayObjectContainer):void
		{		
			
			if (!view)
				throw new Error("View component should be define");
			
			currentViewContainer = instance;
			isActivated = true;
			currentViewContainer.addChild(view);
			view.visible = true;
		}
		
		/**
		 * Деактивируем сцену т.е она пропадает из видимости становится не активной
		 * Тут мы убираем вью из дисплей листа и обнуляем ненужные более параметры
		 */
		public function deactivate():void
		{
			isActivated = false;
			currentViewContainer.removeChild(view);
			currentViewContainer = null;
		}
		
	}

}