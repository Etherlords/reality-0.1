package core.view.gameobject.events 
{
	import patterns.strategy.Strategy;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IGameObjectEvents 
	{
		
		function get creation():Strategy;
		
		function get destroy():Strategy;
		
		function get collide():Strategy;
	}
	
}