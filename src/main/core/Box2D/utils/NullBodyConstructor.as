
package core.Box2D.utils 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.body.IBodyPresentation;
	import core.view.skin.Skin;

	public class NullBodyConstructor implements BodyConstructor 
	{
		
		public function NullBodyConstructor() 
		{
			
		}
		
		public function make(skin:Skin):IBodyPresentation
		{
			return null 
		}

		public function get bodyModel():b2BodyDef 
		{
			return null 
		}

		public function get shape():b2Shape {
			return null;
		}

		public function get fixtureModel():b2FixtureDef {
			return null;
		}

		public function get body():b2Body {
			return null;
		}
	}
}
