package core.view.gameobject 
{

import core.events.GameObjectPhysicEvent;
import core.view.direction.Direction;
import core.view.gameobject.body.constructor.EmptyBodyConstructor;
import core.view.gameobject.body.constructor.IBodyConstructor;
import core.view.gameobject.body.constructor.PhysicBodyConstructor;
import core.view.gameobject.body.IBodyPresentation;
import core.view.gameobject.config.GameobjectConfig;
import core.view.gameobject.context.GameobjectContext;
import core.view.gameobject.events.IGameObjectEvents;
import core.view.gameobject.physicalpropeties.constructor.EmptyPhysicalPropertiesConstructor;
import core.view.gameobject.physicalpropeties.constructor.IPhysicalPropertiesConstructor;
import core.view.gameobject.physicalpropeties.constructor.SimplePhysicalPropertiesConstructor;
import core.view.gameobject.physicalpropeties.IPhysicalProperties;
import core.view.gameobject.physicalpropeties.PhysicModel;
import core.view.skin.Skin;
import starling.display.DisplayObjectContainer;
import starling.events.EventDispatcher;
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
		
		public var skin:Skin;
		protected var _body:IBodyPresentation
		
		
		public var instance:DisplayObjectContainer;
		private var _physicalProperties:IPhysicalProperties;
		public var markToDestroy:Boolean = false;
		
		public var direction:Direction;
		
		public var context:GameobjectContext;
		
		public var events:IGameObjectEvents;
		
		/**
		 * TODO: гейм обжект должен содержать список объектов с которыми он взаимодействует в данный момент(столкнулся но не разъеденился типа встал на платформу и тд)
		 * возможно для такого рода данных нужно создать объект что то вроде "окружения" чтобы можно
		 * Как минимум это нужно будет для реализации какого то AI
		 * Но так же такая вещь необходима чтобы понимать стоим мы на платформе или взаимодействуем с каким то объектом
		 * Хотя пока как понять стоим мы на платформе или нет хз, но наверно что то вроде если есть взаимоедйствие
		 * Наверно придется для этого определять пространственно с какой стороной взаимодействуют объекты и условно понимать
		 * что мы стоим на объекте если он находится снизу
		 */
		
		//public var events:IGameObjectEvents;

		/**
		 * Создаем гейм обэект
		 * @param	config  - статичные настройки объекта итпа, создаетс ли он в физическом мире и тд, по ходу работы эти настройки не меняются и нужны только для иницилизации
		 * @param	physicModel - физическая модель объекта содержет в себе физические параметры(NOTE: пока это работает так но в будущем физик модель будет отрефакторена чтобы быть назвисимой от боди)
		 * @param	instance - дисплей контейнер в который добавляется скин текущего объекта
		 * @param	eventFlowTarget - вышестоящий в цепочки ивент флоу объект
		 */
		public function GameObject(config:GameobjectConfig, physicModel:PhysicModel, instance:DisplayObjectContainer, eventFlowTarget:IEventDispatcher = null) 
		{
			super();
			
			this.instance = instance;
		
			preInitilize(physicModel, config);
		}
		
		/**
		 * Преиницилизация гейм обжекта
		 * Тут мы создаем боди, физикал пропершис, дирекшен, конткекст
		 * Отделение preInitilize от initilize нужно для того чтобы была возможность 
		 * закомитить физические параметры объекта в box2dBody до его появления и активации на сцене
		 * вобщем для синхронизации с вьювом
		 * 
		 * @param	physicModel
		 * @param	config
		 */
		private function preInitilize(physicModel:PhysicModel, config:GameobjectConfig):void 
		{
			var context:GameobjectContext = new GameobjectContext();
			
			direction = new Direction();
			createBody(physicModel, config);
			
			//Есть сомнения на счет целесообразности такого использования контекста
			context.direction = direction;
			context.physicalProperties = _physicalProperties;
			context.body = _body;
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
		public function preRender(lastPreRenderCallDelay:uint):void
		{
			if(physicalProperties)
				direction.calcDirection();
			
			if (markToDestroy)
			{
				destructor();
				return;	
			}
			
			body.preRender();
		}
		
		/**
		 * Помечает объект для удаления, помеченый объект будет
		 * удален на следующем гейм степе на этапе пре рендера
		 */
		public function destroy():void
		{
			markToDestroy = true;
		}
		
		private function destructor():void
		{
			if(instance.contains(skin))
				instance.removeChild(skin);
				
			body.destroy();
			
			this.skin = null;
			this.instance = null;
			
			this._body = null;
			
			/**
			 * Theory:
			 * @see DefaultGameobjectEvents
			 * events.destroy(context);
			 */
			
			dispatchEvent(new GameObjectPhysicEvent(GameObjectPhysicEvent.DESTROY, true, false, this));
		}
		
		public function collideWith(collideTarget:GameObject):void
		{
			
			/**
			 * Theory:
			 * @see DefaultGameobjectEvents
			 * events.colllide(context);
			 */
			
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
		protected function createBody(physicModel:PhysicModel, config:GameobjectConfig):void 
		{
			/**
			 * TODO:
				 * нужно вынести это создание в отдельный объект, помойму использования вот этих 2х конструкторов не совсем целесообразно
				 * и body и properties создание монжо было просто вынести в отделньый объект
				 * Ну естественно создание боди и пропов должно быть сделано стратегией но инкапсулировано от этого класса
			 */
			var bodyConstructor:IBodyConstructor;
            var phsyPropConstructor:IPhysicalPropertiesConstructor;
			
			if (true) 
			{
				bodyConstructor = new PhysicBodyConstructor(config.type, config.shapeType);
                phsyPropConstructor = new SimplePhysicalPropertiesConstructor();
			}
			else
			{
                bodyConstructor = new EmptyBodyConstructor();
                phsyPropConstructor = new EmptyPhysicalPropertiesConstructor();
			}
			
			//Кажется что скин лучше кууда то еще вынести но хз
			skin = new config.skinClass;
			skin.direction = direction;
			skin.prepareSkin();
			_body = bodyConstructor.make(skin);
			
			_physicalProperties = phsyPropConstructor.make(body, physicModel);
			
			direction.trackingObject = this;
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
		
		public function get physicalProperties():IPhysicalProperties
		{
			return _physicalProperties;
		}

        /**
         *  азадиние апиранса по ключу, типа rabbit.walk
         * @param key
         */
        public function applyActionView(key:uint, additionalParam:Number = 0 ):void 
		{
            skin.doAction(key, additionalParam);
        }
	}

}