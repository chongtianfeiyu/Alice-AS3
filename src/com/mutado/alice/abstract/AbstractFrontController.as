package com.mutado.alice.abstract
{
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.interfaces.ICommand;
	import com.mutado.alice.interfaces.IFrontController;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.core.types.NoteType;
	
	import flash.utils.Dictionary;
	
	import com.mutado.alice.core.alice_ns;

	public class AbstractFrontController extends Abstract implements IFrontController
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _commandsDictionary : Dictionary;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractFrontController()
		{
			super( AbstractFrontController );
			_init();
		}
		
		private function _init() : void
		{
			_commandsDictionary = new Dictionary();	
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function registerCommand( type : NoteType, command : Class ) : void
		{ 
			_commandsDictionary[ type ] = command;
		}
		
		public function removeCommand( type : NoteType ) : void
		{
			delete _commandsDictionary[ type ];
		}
		
		public function hasCommand( type : NoteType ) : Boolean
		{
			return _commandsDictionary[ type ] != null;
		}
		
		public function executeCommand( notification : INotification ) : void
		{
			var commandClass : Class = Class( _commandsDictionary[ notification.type ] );
			if ( commandClass == null ) {
				throw new NullPointerException( "Unknow command type[" + notification.type + "]!" );
			}
			var command : ICommand = new commandClass();
			Logger.INFO( "Executing Command: " + command );
			command.alice_ns::execute( notification );
		}
		
		public function releaseCommands() : void
		{
			_init();
		}
		
	}
}