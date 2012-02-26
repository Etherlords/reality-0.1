/**
 * author: chaos-encoder
 * Date: 26.02.12 Time: 9:32
 */
package ui.services.kongreate {
import core.locators.ServicesLocator;
import core.services.AbstractService;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.LoaderInfo;

import flash.events.Event;

import flash.events.EventDispatcher;

import flash.events.IEventDispatcher;
import flash.net.URLRequest;
import flash.system.Security;

import ui.services.scores.store.AbstractScoresStorageService;


public class KongreateService extends AbstractService implements IEventDispatcher {

    private var dispather:EventDispatcher;
    private var _root:DisplayObject;
    private var kongregate:*;
    public function KongreateService() {
        super();
        dispather = new EventDispatcher(this);
    }

    public function connect(root:DisplayObjectContainer):void {
        _root = root;

// Pull the API path from the FlashVars
        var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;

// The API path. The "shadow" API will load if testing locally.
        var apiPath:String = paramObj.kongregate_api_path ||
                "http://www.kongregate.com/flash/API_AS3_Local.swf";

// Allow the API access to this SWF
        Security.allowDomain(apiPath);

// Load the API
        var request:URLRequest = new URLRequest(apiPath);
        var loader:Loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
        loader.load(request);
        root.addChild(loader);

// Kongregate API reference


// This function is called when loading is complete
        function loadComplete(event:Event):void
        {
            // Save Kongregate API reference
            kongregate = event.target.content;

            // Connect to the back-end
            kongregate.services.connect();

            // You can now access the API via:
            // kongregate.services
            // kongregate.user
            // kongregate.scores
            // kongregate.stats


            dispatchEvent(new Event(Event.COMPLETE));
        }
    }


    override public function registered(servicesLocator:ServicesLocator):void {
        super.registered(servicesLocator);
        servicesLocator.addServiceAs(new KongreateScoresStorage(kongregate), AbstractScoresStorageService);
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


