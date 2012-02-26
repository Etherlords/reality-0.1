/**
 * author: chaos-encoder
 * Date: 26.02.12 Time: 10:08
 */
package ui.services.kongreate {
import ui.services.scores.store.AbstractScoresStorageService;

public class KongreateScoresStorage extends AbstractScoresStorageService {

    private var _kongregate:*;
    
    public function KongreateScoresStorage(kongregate:*) {
        this._kongregate = kongregate;
    }

    override public function saveScores(scores:Number):void {
        super.saveScores(scores);
        _kongregate.stats.submit("scores",scores);
    }
}
}
