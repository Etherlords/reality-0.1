package core.view.gameobject.body 
{

	import flash.geom.Point;


	public class EmptyBody implements IBodyPresentation 
	{
		
		public function get x():Number {
			return 0;
		}

		public function set x(value:Number):void {
		}

		public function get y():Number {
			return 0;
		}

		public function set y(value:Number):void {
		}

		public function get position():Point {
			return new Point();
		}

		public function set position(value:Point):void {
		}

		public function get width():Number {
			return 0;
		}

		public function set width(value:Number):void {
		}

		public function get height():Number {
			return 0;
		}

		public function set height(value:Number):void {
		}

		public function render():void {
		}

		public function preRender():void {
		}

		public function destroy():void {
		}
}

}