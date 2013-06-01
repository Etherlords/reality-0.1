package  
{
	import core.ioc.Context;

	public function addToContext(object:Object, ident:String = ''):void
	{
		Context.instance.addObjectToContext(object, ident);
	}


}