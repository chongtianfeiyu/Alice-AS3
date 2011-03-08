package com.mutado.alice.io
{
	import com.mutado.alice.core.types.NoteType;
	
	public class LoaderStatus extends NoteType
	{
		
		// ==================================================================================
		// TYPES
		// ==================================================================================
		
		public static const NEXT 		: LoaderStatus			= new LoaderStatus( "next" );
		public static const START 		: LoaderStatus			= new LoaderStatus( "start" );
		public static const PROGRESS 	: LoaderStatus			= new LoaderStatus( "progress" );
		public static const COMPLETE 	: LoaderStatus			= new LoaderStatus( "complete" );
		public static const ERROR 		: LoaderStatus			= new LoaderStatus( "error" );
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function LoaderStatus( name : String )
		{
			super( name );
		}
		
	}
}