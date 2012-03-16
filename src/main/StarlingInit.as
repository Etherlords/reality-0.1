package 
{
	import com.sociodox.theminer.TheMiner;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import starling.core.Starling;
    
    
   
    public class StarlingInit extends Sprite
    {
        private var mStarling:Starling;
        
        public function StarlingInit()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
            
            mStarling = new Starling(Main, stage);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = false;
            mStarling.start();
            
            // this event is dispatched when stage3D is set up
            stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			addChild(new TheMiner());
        }
        
        private function onContextCreated(event:Event):void
        {
            // set framerate to 30 in software mode
            
            if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
                Starling.current.nativeStage.frameRate = 30;
        }
    }
}