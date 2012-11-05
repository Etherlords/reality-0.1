package ui 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.events.TextEvent;
	import flash.text.StyleSheet;
	import starling.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class Alert extends Sprite
	{
		private var alertText:String;
		private var lable:TextField;
		private var lablesContainer:Sprite;
		
		public function Alert(alertText:String) 
		{
			this.alertText = alertText;
			initilize();
		}
		
		private function initilize():void 
		{
			
			addUI();
			alignUI();
			
			drawBG();
		}
		
		private function alignUI():void 
		{
			lablesContainer.x = lablesContainer.width / 2;
			lablesContainer.y = 0;
			//lable.width = this.width;
			//lable.height = this.height;
		}
		
		private function addUI():void 
		{
			lablesContainer = new Sprite();
			addChild(lablesContainer);
			var textFormat:TextFormat = new TextFormat('Verdana', 10, 0xCCCCCC, true);
			
			
			var lablesParts:Array = alertText.split(String.fromCharCode('10'));
			var __y:Number = 0;
			
			var style:StyleSheet = new StyleSheet();
			style.parseCSS
							(
								  "button{fontWeight:bold; fontSize:35; color:#FFFFFF;}"
								+ "header{fontWeight:bold; fontSize:20;}"
								+ "scores{fontSize:20}"
								+ "a:link { text-decoration:none; }"
								+ "a:hover{text-decoration:underline;}"
							
							);
			
			for (var i:int = 0; i < lablesParts.length; i++)
			{
				lable = new TextField(200, 20, lablesParts[i],'Verdana', 10, 0xCCCCCC, true);
				
				//lable.defaultTextFormat = textFormat;
				lable.autoScale = true;// TextFieldAutoSize.LEFT;
				
				//lable.selectable = false;
				//lable.styleSheet = style;
				
				//lable.htmlText = lablesParts[i];
				//lable.border = true;
				
				lable.x = -lable.width / 2;// (width - lable.width) / 2;
				lable.y = __y;
				
				__y = lable.y + lable.height;
				
				lablesContainer.addChild(lable);
			}
			
			this.addEventListener(TextEvent.LINK, onLink);
		}
		
		private function onLink(e:TextEvent):void 
		{
			var link:String = e.text;
			
			//dispatchEvent(new Event(link));
		}
		
		private function drawBG():void 
		{
			//this.graphics.lineStyle(0);
			//this
			//this.graphics.beginFill(0x0, 0.6);
			//this.graphics.drawRect(0, 0, this.width, this.height);
			//this.graphics.endFill();
		}
		
	}

}