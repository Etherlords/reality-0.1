package core.net {
 
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
 
	public class Socket extends flash.net.Socket {
 
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
 
		/**
		 * @inheritDoc
		 */
		public function Socket(host:String=null, port:int=0.0) {
			super( host, port );
			super.addEventListener( Event.CLOSE,						this.handler_close, false, int.MAX_VALUE, true );
			super.addEventListener( IOErrorEvent.IO_ERROR,				this.handler_error, false, int.MAX_VALUE, true );
			super.addEventListener( SecurityErrorEvent.SECURITY_ERROR,	this.handler_error, false, int.MAX_VALUE, true );
		}
 
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
 
		/**
		 * @private
		 */
		private var _hasError:Boolean = false;
 
		//--------------------------------------------------------------------------
		//
		//  Overrided methods: Socket
		//
		//--------------------------------------------------------------------------
 
		/**
		 * @inheritDoc
		 */
		public override function connect(host:String, port:int):void {
			super.connect( host, port );
			this._hasError = false;
		}
 
		/**
		 * @inheritDoc
		 */
		public override function close():void {
			super.close();
			this._hasError = true;
		}
 
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
 
		/**
		 * @private
		 */
		private function handler_close(event:Event):void {
			this._hasError = true;
		}
 
		/**
		 * @private
		 */
		private function handler_error(event:ErrorEvent):void {
			if ( this._hasError ) {
				// ошибка уже была. поэтому блокируем остальные
				event.stopImmediatePropagation();
			} else {
				this._hasError = true;
				// надо оптисаться, что бы не мешать вызову исключения
				super.removeEventListener( event.type, this.handler_error );
				if ( !super.hasEventListener( event.type ) ) {
					// если подписчиков нету, диспатчим ошибку, что бы вывалился unhadled securityError
					super.dispatchEvent( event );
				}
				// подписываемся обратно
				super.addEventListener( event.type, this.handler_error, false, int.MAX_VALUE, true );
			}
		}
 
	}
 
}