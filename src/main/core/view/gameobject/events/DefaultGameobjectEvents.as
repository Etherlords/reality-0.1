package core.view.gameobject.events 
{
	import patterns.strategy.Strategy;
	/**
	 * Объект служаший для инкапсуляции логики связаной с определенными эвентами гейм обжекта
	 * а так же для того чтобы сделать гейм обжект более гибким объектом
	 * 
	 * Theory:
		 * Гейм обжект имеет N число базовых ивентов collide, destroy, registred, initilized, итд..
		 * Если нам нужно сделать несоклько гейм обжектов с разной логикой на эти события то нужно создать множество обработчиков а для этого нужно создать множество
		 * контроллеров для каждого гейм обжекта свой. Либо создать наследник для каждого конкретного гейм обжекта, понятно что это неудобно и грамоздко
		 * Поэтому мы поступим хитро и используем стратегию
		 * 
		 * Для конкретного гейм обжекта существует билдер(или динамический билдер) который будет задавать на нужный эвент нужню стратегию объекта
		 * Для стратегии при вызове будет предоставлятся нужный ей для исполнения контекст + она будет юзать нужные ей сервисы для обработки той или иной ситуации
		 * в итоге создав набор алгоритмов мы получем гибкую систему создания различных объектов на основе гейм обжекта с разным поведением нужным нам
		 * 
		 * Создать, поменять, или удалить какой то алгоритм поведения достатачно легко поэтомуэто не плохой вриант, кроме того объект будет диспатчить ивент
		 * дублирующий вызов стратегии на случай необходимости внешней обработки события
		 * 
		 * Имея такую систему мы моежм создавать просто сеты из алгоритмов которые будут реализовать различное аи или просто различные реакции
	 * 
	 * @author Nikro
	 */
	public class DefaultGameobjectEvents implements IGameObjectEvents 
	{
		private var _collide:Strategy;
		
		private var _destroy:Strategy;
		
		private var _creation:Strategy;
		
		public function DefaultGameobjectEvents() 
		{
			
		}
		
		public function get creation():Strategy 
		{
			return _creation;
		}
		
		public function set creation(value:Strategy):void 
		{
			_creation = value;
		}
		
		public function get destroy():Strategy 
		{
			return _destroy;
		}
		
		public function set destroy(value:Strategy):void 
		{
			_destroy = value;
		}
		
		public function get collide():Strategy 
		{
			return _collide;
		}
		
		public function set collide(value:Strategy):void 
		{
			_collide = value;
		}
		
		
		
	}

}