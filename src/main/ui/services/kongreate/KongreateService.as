/**
 * author: chaos-encoder
 * Date: 26.02.12 Time: 9:32
 */
package ui.services.kongreate {
import core.locators.ServicesLocator;
import core.services.AbstractService;

import flash.display.DisplayObject;

import flash.events.Event;

import flash.events.EventDispatcher;

import flash.events.IEventDispatcher;

import ui.services.scores.store.AbstractScoresStorageService;


public class KongreateService extends AbstractService implements IEventDispatcher {

    private var dispather:EventDispatcher;
    private var _root:DisplayObject;

    public function KongreateService() {
        super();
        dispather = new EventDispatcher(this);
    }

    public function connect(root:DisplayObject):void {
        _root = root;
        dispatchEvent(new Event(Event.CONNECT));
    }


    override public function registered(servicesLocator:ServicesLocator):void {
        super.registered(servicesLocator);
        servicesLocator.addServiceAs(new KongreateScoresStorage(), AbstractScoresStorageService);
    }

    override protected function initilize():void {
        super.initilize();
    }

    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
        dispather.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
        dispather.removeEventListener(type, listener, useCapture);
    }

    public function dispatchEvent(event:Event):Boolean {
        return dispather.dispatchEvent(event);
    }

    public function hasEventListener(type:String):Boolean {
        return dispather.hasEventListener(type);
    }

    public function willTrigger(type:String):Boolean {
        return dispather.willTrigger(type);
    }
}
}


