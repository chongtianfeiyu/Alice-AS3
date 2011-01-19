package com.mutado.alice.log.driver
{	
	import com.mutado.alice.abstract.AbstractLoggerDriver;
	import com.mutado.alice.log.LogLevel;
	import com.mutado.alice.log.driver.libs.MonsterDebugger;
	
	public class MonsterDebuggerDriver extends AbstractLoggerDriver
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function MonsterDebuggerDriver( level : LogLevel )
		{
			super( level );
			var debugger : MonsterDebugger = new MonsterDebugger( this );
		}

		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		override public function publish( level : LogLevel, msg : Object ) : void
		{
			MonsterDebugger.trace( this, msg );
		}
		
	}
}