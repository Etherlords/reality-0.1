package pingPong.settings 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import pingPong.settings.model.UILables;
	import ui.components.Switch;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class SettingsView extends Sprite 
	{
		private var settingsModel:PingPongSettingsModel;
		private var format:TextFormat;
		private var componentCreationStrategy:Object;
		
		private var componentPlacement:Point = new Point(50, 100);
		private var header:TextField;
		
		public function SettingsView(settingsModel:PingPongSettingsModel) 
		{
			super();
			
			this.settingsModel = settingsModel
			
			initilzie();
		}
		
		private function initilzie():void 
		{
			
			componentCreationStrategy = { 'Boolean':createSwitchComponent };
			
			format = new TextFormat('Verdana', 15, 0xCCCCCC, true);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			crateSettingsUI();
		}
		
		private function createText(text:String):TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = text;
			tf.selectable = false;
			addChild(tf);
			
			return tf;
		}
		
		private function alignTextField(tf:TextField, component:Sprite):void
		{
			component.x = tf.x + tf.width + 5;
			component.y = tf.y + (component.height - tf.height)/2;
		}
		
		private function crateSettingsUI():void 
		{
			
			header = createText('МЕНЮ НАСТРОЕК');
			header.x = (stage.stageWidth - header.width) / 2;
			
			componentPlacement.y = header.y + header.height + 5;
			
			addChild(header);
			
			createComponent('isUseBollParticles');
			createComponent('isUseSoftwareBliting');
			createComponent('isShowSettingsOnStart');
			
			var hint:TextField = createText(UILables.GENERAL_HINT);
			addChild(hint);
			
			hint.x = (stage.stageWidth - hint.width) / 2;
			hint.y = componentPlacement.y + 5;
			componentPlacement.y += hint.height + 5;
			
			var bt:Sprite = new Sprite()
			bt.addChild(createText('NEXT'));
			bt.graphics.beginFill(0x0, 0);
			bt.graphics.drawRect(0, 0, bt.width, bt.height);
			addChild(bt);
			bt.x = (stage.stageWidth - bt.width) / 2;
			bt.y = componentPlacement.y + 10//stage.stageHeight - bt.height - 5;
			bt.addEventListener(MouseEvent.MOUSE_DOWN, goToNext);
		}
		
		private function goToNext(e:MouseEvent):void 
		{
			dispatchEvent(new Event('exit'));
		}
		
		private function createComponent(fieldname:String):void
		{
			var field:Object = settingsModel[fieldname];
			
			componentCreationStrategy[getQualifiedClassName(field)](fieldname);
		}
		
		private function createSwitchComponent(fieldName:String):void 
		{
			var switchComponent:Switch = new Switch(settingsModel[fieldName]);
			
			addChild(switchComponent);
			
			var hint:TextField = createText(fieldName);
			hint.x = componentPlacement.x;
			hint.y = componentPlacement.y;
			setHintText(hint, fieldName);
			
			
			alignTextField(hint, switchComponent);
			
			componentPlacement.y += switchComponent.height + 5;
			
			switchComponent.addEventListener(MouseEvent.MOUSE_DOWN, Delegate.create(switchProperty, hint, fieldName))
		}
		
		private function setHintText(hint:TextField, fieldName:String):void
		{
			hint.text = UILables.getSwitchText(fieldName, settingsModel[fieldName]);
		}
		
		private function switchProperty(e:MouseEvent, hint:TextField, fieldName:String):void 
		{
			(e.target as Switch).switchBur();
			settingsModel[fieldName] = !settingsModel[fieldName]
			trace(settingsModel[fieldName]);
			setHintText(hint, fieldName);
			//alignTextField(hint, (e.target as Switch));
		}
	}

}