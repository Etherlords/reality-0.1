package core.view.gameobject 
{
	import core.body.IBodyPresentation;
	import core.body.PhysicBodyPresentation;
	import core.Box2D.utils.PhysicBodyConstructor;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.skin.Skin;
	import flash.display.Sprite;
	
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

	public class GameObject 
	{
		
		protected var skin:Skin;
		protected var _body:IBodyPresentation
		
		private var config:GameobjectConfig;
		private var instance:Sprite;
		private var _physicalProperties:PhysicalProperties;
		
		/**
		 * Задаем конфи и инстанс объекта, возможно инстанс лучше задавать как то иначе, но не факт. 
		 * Для одного и того зже мира по сути должны быть соответственные(по координатами, скейлу и пр) инстансы
		 * Но все же могут быть разными
		 * 
		 * @param	config
		 * @param	instance
		 */
		public function GameObject(config:GameobjectConfig, instance:Sprite) 
		{
			this.instance = instance;
			this.config = config;
			
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
			body.preRender();
		}
		
		public function destroy():void
		{
			instance.removeChild(skin);
			body.destroy();
			
			this.skin = null;
			this.instance = null;
			this.config = null;
			this._body = null;
		}
		
		protected function initilize():void 
		{
			createBody();
			
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
			
			//Просто для теста установил координаты 100х100
			body.x = 100;
			body.y = 100;
			
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
	}

}