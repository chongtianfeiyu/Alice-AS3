package com.mutado.alice.abstract
{
	import com.mutado.alice.core.alice_ns;
	import com.mutado.alice.interfaces.ICommand;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.log.Logger;
	
	public class AbstractCommand extends Abstract implements ICommand
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _callback : Function;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractCommand()
		{
			super( AbstractCommand );
		}

		// ==================================================================================
		// CORE INTERNAL
		// ==================================================================================
		
		alice_ns function execute( notification : INotification ) : void
		{
			execute( notification );
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