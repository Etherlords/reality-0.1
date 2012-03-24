/**
 * author: chaos-encoder
 * Date: 17.03.12 Time: 22:29
 */
package ragevagon.scene.gameInteractionScene {
import flash.display.MovieClip;
import flash.display.Sprite;

public class RageVagonGameSceneView extends Sprite {

    private var _vagon:MovieClip;
    public var _weaponSwitcher:WeaponSwitcherSymbol; //todo to private

    public function RageVagonGameSceneView() {
        _vagon = new Vagon();
        _vagon.y = 600 - _vagon.height;
        addChild(_vagon);

        _weaponSwitcher = new WeaponSwitcherSymbol();
        //_weaponSwitcher.addEventListener("switchWeaponRequest", switchWeaponRequestHandler);
        addChild(_weaponSwitcher);
    }



    public function render():void {

    }

    public function get gameObjectsInstance():Sprite {
        return this;
    }
}
}
