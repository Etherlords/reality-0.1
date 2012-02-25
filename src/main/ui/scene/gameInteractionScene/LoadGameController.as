/**
 * author: chaos-encoder
 * Date: 25.02.12 Time: 22:18
 */
package ui.scene.gameInteractionScene{
import core.locators.ServicesLocator;
import core.scene.AbstractSceneController;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.text.TextField;

import mx.controls.Text;

import ui.services.ScoresService;

public class LoadGameController extends AbstractSceneController {
    public function LoadGameController() {
    }


    override protected function createUI():void {
        var backGround:Sprite = new Sprite();
        var label:TextField = new TextField();
        label.text = "loading...";
        label.textColor = 0xbbbbbb;
        backGround.addChild(label);
        setViewComponent(backGround);
    }

    override public function activate(instance:DisplayObjectContainer):void {
        super.activate(instance);
        ServicesLocator.instance.addService(new ScoresService());
        exit();
    }
}
}
