/**
 * author: chaos-encoder
 * Date: 21.03.12 Time: 21:10
 */
package ragevagon.scene.gameInteractionScene {
import core.scene.AbstractSceneController;

import flash.display.DisplayObjectContainer;

public class IntroGameRageVagonController extends AbstractSceneController {

    private var smbl:SomeThereInMoscowSymbol;

    public function IntroGameRageVagonController() {
    }

    override protected function createUI():void {
        smbl = new SomeThereInMoscowSymbol();

        setViewComponent(smbl);
    }

    private function introFinishedHandler(...args):void {
        if (isActivated) {
            exit();
        }
    }

    override public function activate(instance:DisplayObjectContainer):void {
        super.activate(instance);
        smbl.addEventListener("introFinished", introFinishedHandler);
    }
}
}
