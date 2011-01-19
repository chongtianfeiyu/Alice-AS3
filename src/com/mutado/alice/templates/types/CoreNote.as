package com.mutado.alice.templates.types
{
	import com.mutado.alice.core.types.NoteType;

	public class CoreNote extends NoteType
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		public static const STATUS 		: CoreNote				= new CoreNote( "status" );
		public static const BOOTSTRAP	: CoreNote				= new CoreNote( "bootstrap" );
		public static const INITIALIZE	: CoreNote				= new CoreNote( "initialize" );
		public static const STARTUP 	: CoreNote				= new CoreNote( "startup" );
		public static const SHUTDOWN 	: CoreNote				= new CoreNote( "shutdown" );
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function CoreNote( name : String )
		{
			super(name);
		}
		
	}
}