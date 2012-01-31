package core.view.gameobject 
{
	import core.body.IBodyPresentation;
	import core.Box2D.utils.PhysicBodyConstructor;
	import core.view.gameobject.config.GameobjectConfig;
	import core.view.skin.Skin;
	import flash.display.Sprite;

	public class GameObject 
	{
		
		protected var skin:Skin;
		protected var _body:IBodyPresentation
		
		private var config:GameobjectConfig;
		private var instance:Sprite;
		
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
			//body.DestroyFixture(_physicalProperties.fixture);
			//world.DestroyBody(body);
			
			//body = null;
			//world = null;
		}
		
		protected function initilize():void 
		{
			createBody();
			//_physicalProperties = new PhysicalProperties(shape, fixtureModel, body)
			//_dimensionalProperties = new DimensionalProperties(body);
		}
		
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
			
			skin = new Skin();
			_body = bodyConstructor.make(skin);
			
			body.x = 100;
			body.y = 100;
			
			instance.addChild(skin);
			
			render();
		}
		
		public function get body():IBodyPresentation 
		{
			return _body;
		}
	}

}