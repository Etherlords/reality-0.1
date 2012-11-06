package pingPong.settings 
{
	import core.locators.ServicesLocator;
	import core.scene.AbstractSceneController;
	import core.ui.KeyBoardController;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import pingPong.SharedObjectService;
	import starling.display.DisplayObjectContainer;
	import utils.GlobalUIContext;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class PingPongSettingsController extends AbstractSceneController 
	{
		private var sceneView:SettingsView;
		private var shared:SharedObjectService;
		private var settingsModel:PingPongSettingsModel;
		private var keyContoller:KeyBoardController;
		
		public function PingPongSettingsController() 
		{
			super();
			
		}
		
		override protected function initilize():void 
		{
			super.initilize();
			
			shared = ServicesLocator.instance.getServiceByClass(SharedObjectService) as SharedObjectService;
			settingsModel = shared.settings;
		}
		
		override protected function createUI():void 
		{
			super.createUI();
			
			
		}
		
		override public function deactivate():void 
		{
			shared.uploadSettings();
			keyContoller.destroy();
			GlobalUIContext.vectorUIContainer.removeChild(sceneView);
			
			isActivated = false;
		}
		
		override public function activate(instance:DisplayObjectContainer):void 
		{
			if (isActivated)
				return;
				
			sceneView = new SettingsView(settingsModel);
			
			keyContoller = new KeyBoardController(GlobalUIContext.vectorStage);
			keyContoller.registerKeyDownReaction(Keyboard.SPACE, onExit);
			
			currentViewContainer = instance;
			isActivated = true;
			GlobalUIContext.vectorUIContainer.addChild(sceneView);
			sceneView.visible = true;
			
			postInitilize();
		}
		
		private function postInitilize():void 
		{
			sceneView.addEventListener('exit', onExit);
		}
		
		private function onExit(e:* = null):void 
		{
			exit();
		}
		
	}

}