/**
 * author: chaos-encoder
 * Date: 17.03.12 Time: 22:29
 */
package ragevagon.scene.gameInteractionScene {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

public class RageVagonGameSceneView extends Sprite {

    private var _label:TextField;
    private var _vagon:MovieClip;

    public function RageVagonGameSceneView() {
        _label = new TextField();
        _label.text = "rage vagon background";
        _label.textColor = 0xffffff;
        _vagon = new Vagon();
        _vagon.y = 600 - _vagon.height;
        addChild(_label);
        addChild(_vagon);
    }

    public function render():void {

    }

    public function get gameObjectsInstance():Sprite {
        return this;
    }
}
}
