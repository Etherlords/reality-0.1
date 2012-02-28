/**
 * Created by IntelliJ IDEA.
 * User: DES
 * Date: 31.01.12
 * Time: 8:23
 * To change this template use File | Settings | File Templates.
 */
package core.body.constructor {

import core.body.IBodyPresentation;
import core.view.skin.Skin;

public interface IBodyConstructor {

    function make(skin:Skin):IBodyPresentation;

}
}
