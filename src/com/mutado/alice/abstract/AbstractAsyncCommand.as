package com.mutado.alice.abstract
{
	import com.mutado.alice.core.alice_ns;
	import com.mutado.alice.interfaces.IAsyncCommand;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.util.DeferredAction;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class AbstractAsyncCommand extends Abstract implements IAsyncCommand
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _callback : Function;
		private var _note : INotification;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractAsyncCommand()
		{
			super( AbstractCommand );
		}

		// ==================================================================================
		// CORE INTERNAL
		// ==================================================================================
		
		alice_ns function execute( notification : INotification ) : void
		{
			_note = notification;
			DeferredAction.execute( 1, alice_ns::async );
		}
		
		alice_ns function async() : void
		{
			execute( _note );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function execute( notification : INotification ) : void
		{
			Logger.INFO( this + ".execute() method is not implemented" );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get callback() : Function
		{
			return _callback;
		}
		
		public function set callback( selector : Function ) : void
		{
			_callback = selector;
		}
		
	}
}