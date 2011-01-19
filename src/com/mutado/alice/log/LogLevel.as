package com.mutado.alice.log
{
	import com.mutado.alice.core.enum.Enum;
			
	public final class LogLevel extends Enum
	{
		// ==================================================================================
		// ENUMS
		// ==================================================================================
		
		public static const ALL 	: LogLevel					= new LogLevel( "ALL", 		1,	Locked );
		public static const LOG 	: LogLevel					= new LogLevel( "LOG", 		2,	Locked );
		public static const DEBUG 	: LogLevel					= new LogLevel( "DEBUG",	3,	Locked );
		public static const INFO 	: LogLevel					= new LogLevel( "INFO",		4,	Locked );
		public static const WARN 	: LogLevel					= new LogLevel( "WARN",		5,	Locked );
		public static const ERROR 	: LogLevel					= new LogLevel( "ERROR",	6,	Locked );
		public static const FATAL 	: LogLevel					= new LogLevel( "FATAL",	7,	Locked );
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function LogLevel( name : String , value : int, safe : Class = null )
		{
			super( name, value, safe, Locked );
		}
		
	}
}

internal class Locked { }