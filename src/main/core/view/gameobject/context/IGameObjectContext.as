package core.view.gameobject.context 
{
	import patterns.strategy.Strategy;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IGameObjectContext 
	{
		
		function get creation():Strategy;
		
		function get destroy():Strategy;
		
		function get collide():Strategy;
	}
	
}