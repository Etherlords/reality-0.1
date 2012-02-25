/**
 * author: chaos-encoder
 * Date: 25.02.12 Time: 22:40
 */
package ui.services {
import core.services.AbstractService;

public class ScoresService extends AbstractService {

    private var _scores:Number = 0;
    public var scoresSubstractor:Number = 0;
    private var _currentPlayerMaxScope:Number = 0;

    public function ScoresService() {
    }


    override protected function initilize():void
    {
        super.initilize();
    }

    public function get currentPlayerMaxScope():Number {
        return _currentPlayerMaxScope;
    }

    public function get scores():Number {
        return _scores;
    }

    public function set scores(value:Number):void {
        _scores = value;
    }

    public function set currentPlayerMaxScope(currentPlayerMaxScope:Number):void {
        _currentPlayerMaxScope = currentPlayerMaxScope;
    }
}
}
