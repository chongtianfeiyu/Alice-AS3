package com.mutado.alice.templates.types
{
	import com.mutado.alice.core.types.NoteType;

	public class Note extends NoteType
	{
		// global notes
		
		public static const INIT 		: Note					= new Note( "init" );
		public static const BEGAN 		: Note					= new Note( "began" );
		public static const PAUSED 		: Note					= new Note( "paused" );
		public static const COMPLETED 	: Note					= new Note( "completed" );
		public static const FAILED 		: Note					= new Note( "failed" );
		
		public function Note( name : String )
		{
			super( name );
		}
		
	}
}