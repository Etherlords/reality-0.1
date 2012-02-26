/**
 * author: chaos-encoder
 * Date: 25.02.12 Time: 22:40
 */
package ui.services.scores {
import core.locators.ServicesLocator;
import core.services.AbstractService;
import ui.services.scores.store.AbstractScoresStorageService;


public class ScoresService extends AbstractService {

    private var _scores:Number = 0;
    public var scoresSubstractor:Number = 0;
    private var _storage:AbstractScoresStorageService;


    public function ScoresService() {

    }


    override public function registered(servicesLocator:ServicesLocator):void {
        super.registered(servicesLocator);
        _storage = servicesLocator.getServiceByClass(AbstractScoresStorageService) as AbstractScoresStorageService;
    }

    override protected function initilize():void
    {
        super.initilize();
    }

    public function get currentPlayerMaxScope():Number {
        return _storage.getCurrentUserMaxScores();
    }

    public function get scores():Number {
        return _scores;
    }

    public function set scores(value:Number):void {
        _scores = value;
    }

    public function resetScores():void {
        scores = 0;
    }

    public function flushScores():void {
        _storage.saveScores(scores);
    }
}
}
