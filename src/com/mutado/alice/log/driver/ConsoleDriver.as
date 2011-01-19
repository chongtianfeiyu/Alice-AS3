package com.mutado.alice.log.driver
{	
	import com.mutado.alice.abstract.AbstractLoggerDriver;
	import com.mutado.alice.log.*;
	
	public class ConsoleDriver extends AbstractLoggerDriver
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function ConsoleDriver( level : LogLevel )
		{
			super( level );
		}

		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		override public function publish( level : LogLevel, msg : Object ) : void
		{
			trace ( "[" + level.name + "]	" + msg );
		}
		
	}
}