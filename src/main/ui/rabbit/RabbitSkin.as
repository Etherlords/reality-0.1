/**
 * author: chaos-encoder
 * Date: 01.02.12 Time: 7:47
 */
package ui.rabbit {
import core.view.skin.Skin;

public class RabbitSkin extends Skin {
    public function RabbitSkin() {
		super();
        addChild(new DragonWalkLeft());
    }


}
}
