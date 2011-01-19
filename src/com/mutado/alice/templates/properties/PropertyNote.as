package com.mutado.alice.templates.properties
{
	import com.mutado.alice.core.types.NoteType;

	public class PropertyNote extends NoteType
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		public static const CHANGED : PropertyNote		= new PropertyNote( "changed" );
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function PropertyNote( name : String )
		{
			super( name );
		}
		
	}
}