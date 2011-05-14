package com.mutado.alice.util
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DeferredAction
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		public function DeferredAction( delay : Number, selector : Function, args : Array = null )
		{
			this.delay = delay;
			this.selector = selector;
			this.args = args;
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function doAction( e : Event ) : void
		{
			selector.apply( this, args );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function execute() : void
		{
			var timer : Timer = new Timer( delay, 1 );
			timer.addEventListener( TimerEvent.TIMER, doAction );
			timer.start();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var delay : Number;
		protected var selector : Function;
		protected var args : Array;
		
		// ==================================================================================
		// PUBLIC API
		// ==================================================================================
		
		public static function create( delay : Number, selector : Function, args : Array = null ) : DeferredAction
		{ 
			return new DeferredAction( delay, selector, args );
		}
		
		public static function execute( delay : Number, selector : Function, ...args ) : void
		{ 
			create( delay, selector, args ).execute();
		}

	}
}