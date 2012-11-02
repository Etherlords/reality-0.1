package ui 
{
	import core.view.skin.Skin;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import silin.zod.materials.TextureMaterial;
	import silin.zod.primitives.Cube;
	
	/**
	 * ...
	 * @author 
	 */
	public class FloorShape extends Skin 
	{
		[Embed(source = "../../../lib/phoca_thumb_l_grass 3d-freedom 3.jpg")]
		private var source1:Class;
		
		private var texture1:BitmapData = new source1().bitmapData;
		
		[Embed(source = "../../../lib/phoca_thumb_l_grass 3d-freedom 31.jpg")]
		private var source2:Class;
		
		private var texture2:BitmapData = new source2().bitmapData;
		public var cube:Cube;
	
		public function FloorShape() 
		{
			graphics.lineStyle(1, 0xFFFFFF);
			graphics.moveTo(0, 0);
			graphics.lineTo(50, 0);
			return;
			cube = new Cube(new TextureMaterial(texture1, false, 0.5), 50);
			cube.tintDepth = 0.3
			cube.y += 25;
			//cube.scaleX = 5
			
			//cube.autoSorting = true;
			
			//cube.rotationY = 150;
			addChild(cube);
			return
			
			var texture2Height:Number;
			var m:Matrix;
			m = new Matrix();
			m.scale(150 / texture1.width, 200 / texture1.height);
			
			graphics.beginBitmapFill(texture1, m, false, false);
			graphics.drawRect(0, 0, 75, 100);
			
			m = new Matrix();
			texture2Height = 25
			m.scale(75 / texture2.width, (100+texture2Height) / texture2.height);
			
			graphics.beginBitmapFill(texture1, m, false, false);
			graphics.drawRect(0, texture2Height, 75, 100);
			
			m = new Matrix();
			texture2Height = 15 + Math.random() * 5
			m.scale(150 / texture2.width, 200 / texture2.height);
			
			graphics.beginBitmapFill(texture2, m, false, false);
			graphics.drawRect(0, 0, 75, texture2Height);
			
	
			
		}
		
		override public function get rotation():Number 
		{
			return super.rotation;
		}
		
		override public function set rotation(value:Number):void 
		{
			super.rotation = value
			//cube.rotation = value;
			//cube.rotationY = 90;
			//cube.rotationX = 90;
		}
		
	}

}