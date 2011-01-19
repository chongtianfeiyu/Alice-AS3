package com.mutado.alice.abstract
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.interfaces.ILoggerDriver;
	import com.mutado.alice.log.LogLevel;

	public class AbstractLoggerDriver extends Abstract implements ILoggerDriver
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _level : LogLevel;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractLoggerDriver( level : LogLevel )
		{
			super( AbstractLoggerDriver );
			_level = level;
			publish( LogLevel.LOG, this + " Initialized @ " + new Date() );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function isAllowed( level : LogLevel ) : Boolean
		{
			if ( level >= _level ) {
				return true;
			}
			return false;
		}

		public function publish( level : LogLevel, msg : Object):void
		{
			trace( this + ".publish() method is not implemented!" );
		}
		
	}
}