/**
 * author: chaos-encoder
 * Date: 06.02.12 Time: 8:11
 */
package core.view.gameobject.body.constructor 
{

	import core.view.gameobject.body.EmptyBody;
	import core.view.gameobject.body.IBodyPresentation;
	import core.view.skin.Skin;


	public class EmptyBodyConstructor implements IBodyConstructor {
		public function EmptyBodyConstructor() {
		}

		public function make(skin:Skin):IBodyPresentation {
		   return new EmptyBody();
		}
	}
}

	