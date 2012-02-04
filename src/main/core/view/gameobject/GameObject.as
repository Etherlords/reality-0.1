package core.view.gameobject 
{
	import core.body.IBodyPresentation;
	import core.body.PhysicBodyPresentation;
	import core.Box2D.utils.PhysicBodyConstructor;
	import core.events.GameObjectPhysicEvent;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.skin.Skin;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	/**
	 * [broadcast event] Диспатчится когда объект столкнулся с каким то другим объектом
	 * @eventType	core.events.GameObjectPhysicEvent.COLLIDE
	 */
	[Event(name="collide", type="core.events.GameObjectPhysicEvent")] 
	
	/**
	 * Класс нечто вроде фасада - контроллера
	 * Тут заключается создание и поддержка графики игрового объекта
	 * Тут мы создаем представление объекта нужного нам типа
	 * 
	 * Возможно следует создать несоклько объектов-интерфейсов
	 * типа "Физические свойства(апли импульс, ускорение, и т.д)"
	 * "обычные общие свойства(управление скином и тд)"
	 * 
	 * Так обращатся с объектом будет проще на мой взгляд + эти интерфейсы инкапсулируют определенную работу в себе
	 * 
	 * Фактически наследник этого объекта, или некий контроллер работающий с этим объектом будет уже реализовывать логику конкретной сущьности
	 * Если это кролик, то реализуем там логику управления его скином(анимациями), прыжки кролика и тд.
	 */

	public class GameObject extends EventDispatcher
	{
		
		protected var skin:Skin;
		protected var _body:IBodyPresentation
		
		private var config:GameobjectConfig;
		private var instance:Sprite;
		private var _physicalProperties:PhysicalProperties;
		private var markToDestroy:Boolean = false;

        //TODO comment is not actual
		/**
		 * Задаем конфи и инстанс объекта, возможно инстанс лучше задавать как то иначе, но не факт. 
		 * Для одного и того зже мира по сути должны быть соответственные(по координатами, скейлу и пр) инстансы
		 * Но все же могут быть разными
		 * 
		 * @param	config
		 * @param	instance
		 */
		public function GameObject(config:GameobjectConfig, instance:Sprite, eventFlowTarget:IEventDispatcher = null) 
		{
			super(eventFlowTarget);
			
			this.instance = instance;
			this.config = config;
			
			preInitilize();
		}
		
		private function preInitilize():void 
		{
			createBody();
		}
		
		public function registredInApplication():void
		{
			initilize();
		}
		
		/**
		 * Функция которая применяет последние изменения к представлению объекта
		 */
		public function render():void
		{
			
			
			body.render();
		}
		
		/**
		 * Функция которая коммитит последние изменения в физический мир
		 */
		public function preRender():void
		{
			if (markToDestroy)
			{
				destructor();
				return;	
			}
			
			body.preRender();
		}
		
		public function destroy():void
		{
			markToDestroy = true;
		}
		
		private function destructor():void
		{
			
			instance.removeChild(skin);
			body.destroy();
			
			this.skin = null;
			this.instance = null;
			this.config = null;
			this._body = null;
			
			dispatchEvent(new GameObjectPhysicEvent(GameObjectPhysicEvent.DESTROY, true, false, this));
		}
		
		public function collideWith(collideTarget:GameObject):void
		{
			dispatchEvent(new GameObjectPhysicEvent(GameObjectPhysicEvent.COLLIDE, true, false, collideTarget));
		}
		
		protected function initilize():void 
		{
			
			addToDisplayList();
			
			//_dimensionalProperties = new DimensionalProperties(body);
		}
		
		
		
		/**
		 * Создаем представление боди
		 * Физическое, не физическое, еще какое то
		 * Т.е фактически тут будет фабрика по созданию боди
		 * но пока для всех созадем просто физическое представление
		 * и создаем боди в физическом мире.
		 */
		protected function createBody():void 
		{
			var bodyConstructor:PhysicBodyConstructor;
			
			if (config.isUsePhisicWorld)
			{
				bodyConstructor = new PhysicBodyConstructor(config.physicConfiguration);
				
			}
			else
			{
				
			}
			
			skin = new config.skinClass;
			_body = bodyConstructor.make(skin);
			_physicalProperties = new PhysicalProperties(body as PhysicBodyPresentation)
		}
		
		private function addToDisplayList():void 
		{
			instance.addChild(skin);
			//Вызываем рендер чтобы синхронизировать представление и скин
			render();
		}
		
		public function get body():IBodyPresentation 
		{
			return _body;
		}
		
		public function get physicalProperties():PhysicalProperties 
		{
			return _physicalProperties;
		}

        /**
         *  азадиние апиранса по ключу, типа rabbit.walk
         * @param key
         */
        public function applyActionView(key:uint):void {
            skin.doAction(key);
        }
	}

}