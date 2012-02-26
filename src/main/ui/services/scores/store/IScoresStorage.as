/**
 * author: chaos-encoder
 * Date: 26.02.12 Time: 9:11
 */
package ui.services.scores.store {
public interface IScoresStorage {
    function saveScores(scores:Number):void;

    function getCurrentUserMaxScores():Number;
}
}
