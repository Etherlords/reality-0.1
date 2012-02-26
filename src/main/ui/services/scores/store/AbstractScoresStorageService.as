/**
 * author: chaos-encoder
 * Date: 26.02.12 Time: 9:16
 */
package ui.services.scores.store {
import core.services.AbstractService;

public class AbstractScoresStorageService extends AbstractService {

    private var _currentPlayerMaxScope:Number;

    public function AbstractScoresStorageService() {
        _currentPlayerMaxScope = 0;
    }

    public function saveScores(scores:Number):void {
        if (scores > _currentPlayerMaxScope) {
            _currentPlayerMaxScope =  scores;

        }
    }

    public function getCurrentUserMaxScores():Number {
        return _currentPlayerMaxScope;
    }
}
}
