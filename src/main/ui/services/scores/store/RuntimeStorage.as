/**
 * author: chaos-encoder
 * Date: 26.02.12 Time: 9:16
 */
package ui.services.scores.store {
public class RuntimeStorage implements IScoresStorage {

    private var _currentPlayerMaxScope:Number;

    public function RuntimeStorage() {
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
