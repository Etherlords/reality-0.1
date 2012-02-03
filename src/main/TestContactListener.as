package  
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	/**
	 * ...
	 * @author 
	 */
	public class TestContactListener extends b2ContactListener 
	{
		
		public function TestContactListener() 
		{
			
		}
		
		override public function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			trace("BeginContact", contact.GetFixtureA().GetBody());
		}
		
	}

}