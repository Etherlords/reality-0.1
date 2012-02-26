/**
 * author: chaos-encoder
 * Date: 25.02.12 Time: 22:40
 */
package ui.services.scores {
import core.services.AbstractService;

import ui.services.scores.store.IScoresStorage;

public class ScoresService extends AbstractService {

    private var _scores:Number = 0;
    public var scoresSubstractor:Number = 0;
    private var _storage:IScoresStorage;


    public function ScoresService(storage:IScoresStorage) {
        this._storage = storage;
    }


    override protected function initilize():void
    {
        super.initilize();
    }

    public function get currentPlayerMaxScope():Number {
        return _storage.getCurrentUserMaxScores();;
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
