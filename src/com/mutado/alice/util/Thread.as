package com.mutado.alice.util
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Thread extends Sprite
	{
		public function Thread()
		{
			
		}
		
		// PROTECTED
		
		protected function running( e : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, running );
			selector.apply( this, args );
		}
		
		// PUBLIC
		
		public function run() : void
		{
			addEventListener( Event.ENTER_FRAME, running );
		}
		
		// PROPERTIES
		
		public var selector : Function;
		public var args : Array;
		
		// API
		
		public static function detachNewThreadSelector( selector : Function, args : Array = null ) : Thread
		{
			var th : Thread = new Thread();
			th.selector = selector;
			th.args = args;
			th.run();
			return th;
		}

	}
}