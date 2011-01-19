package com.mutado.alice.interfaces
{
	import com.mutado.alice.log.LogLevel;
	
	public interface ILoggerDriver
	{
		function isAllowed( level : LogLevel ) : Boolean;
		function publish( level : LogLevel, msg : Object ) : void;
		function toString() : String;
	}
}