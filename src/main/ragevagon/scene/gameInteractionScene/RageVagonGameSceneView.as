/**
 * author: chaos-encoder
 * Date: 17.03.12 Time: 22:29
 */
package ragevagon.scene.gameInteractionScene {
import flash.display.Sprite;
import flash.text.TextField;

public class RageVagonGameSceneView extends Sprite {

    private var _label:TextField;

    public function RageVagonGameSceneView() {
        _label = new TextField();
        _label.text = "rage vagon background";
        _label.textColor = 0xffffff;
        addChild(_label);
    }

    public function render():void {

    }

    public function get gameObjectsInstance():Sprite {
        return this;
    }
}
}
