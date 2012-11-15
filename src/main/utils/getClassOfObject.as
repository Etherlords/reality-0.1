package utils 
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Nikro
	 */
	public function getClassOfObject(obj:Object):Class 
	{
		
		return getDefinitionByName(getQualifiedClassName(obj)) as Class;
	}

}