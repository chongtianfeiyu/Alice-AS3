package com.mutado.alice.abstract
{
	import com.mutado.alice.interfaces.IBatchCommand;
	import com.mutado.alice.interfaces.ICommand;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.log.Logger;
	
	import flash.utils.Dictionary;

	import com.mutado.alice.core.alice_ns;
	
	public class AbstractBatchCommand extends Abstract implements IBatchCommand
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _callback : Function;
		private var _batchCommand : Array;
		private var _deferDictionary : Dictionary;
		private var _index : uint;
		private var _note : INotification;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractBatchCommand()
		{
			super( AbstractBatchCommand );
		}	
		
		// ==================================================================================
		// CORE INTERNAL
		// ==================================================================================
		
		alice_ns function execute( notification : INotification ) : void
		{
			execute( notification );
			_index = 0;
			_note = notification;
			next();
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function appendCommand( command : Class, defer : Boolean = false ) : void
		{
			if ( _batchCommand == null ) _batchCommand = new Array();
			if ( defer ) {
				if ( _deferDictionary == null ) _deferDictionary = new Dictionary();
				_deferDictionary[ command ] = defer;
			}
			_batchCommand.push( command );
		}
		
		protected function next() : void
		{
			if ( !( _index < _batchCommand.length ) ) {
				Logger.INFO( "	BATCH > complete" );
				if ( callback != null ) {
					callback();
				}
				return;
			}
			var commandClass : Class = Class( _batchCommand[ _index ] );
			var command : ICommand = new commandClass();
			Logger.INFO( "	BATCH[" + _index + "] > Executing Command: " + command );
			_index++;
			command.callback = next;
			command.alice_ns::execute( _note );
			if ( _deferDictionary == null || _deferDictionary[ commandClass ] == null ) {
				next();
			}
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