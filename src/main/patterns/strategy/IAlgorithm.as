package patterns.strategy 
{
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IAlgorithm 
	{
		function get length () : int

		function apply (scope:Object = null, args:Array = null):*
	}
	
}