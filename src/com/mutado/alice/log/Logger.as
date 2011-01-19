package com.mutado.alice.log
{
	import com.mutado.alice.interfaces.ILoggerDriver;
	
	public final class Logger
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		 
		private static var _drivers : Array;
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private static function _dispatch( level : LogLevel, msg : Object ) : void 
		{
			if ( _drivers == null ) {
				// default CONSOLE driver setting
				appendDriver( Drivers.CONSOLE, LogLevel.WARN );
			}
			// dispath to all registered drivers
			for ( var i : uint = 0; i < _drivers.length; i++ ) {
				var d : ILoggerDriver = ILoggerDriver( _drivers[ i ] );
				if ( d.isAllowed( level ) ) {
					d.publish( level, msg );	
				}
			}
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		 
		public static function appendDriver( driverRef : Class, level : LogLevel = null ) : void 
		{
			if ( !_drivers ) {
				_drivers = new Array();
			}
			_drivers.push( new driverRef( ( level ? level : LogLevel.ALL ) ) );
		}
		
		public static function LOG( msg : Object ) : void 
		{
			_dispatch( LogLevel.LOG, msg );
		}
		
		public static function DEBUG( msg : Object ) : void 
		{
			_dispatch( LogLevel.DEBUG, msg );
		}
		
		public static function INFO( msg : Object ) : void 
		{
			_dispatch( LogLevel.INFO, msg );
		}
		
		public static function WARN( msg : Object ) : void 
		{
			_dispatch( LogLevel.WARN, msg );
		}		
		
		public static function ERROR( msg : Object ) : void 
		{
			_dispatch( LogLevel.ERROR, msg );
		}
		
		public static function FATAL( msg : Object ) : void 
		{
			_dispatch( LogLevel.FATAL, msg );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public static var Drivers : DriverSet = new DriverSet();
		
	}
}