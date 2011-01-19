package com.mutado.alice.core.types
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.enum.Enum;
	import com.mutado.alice.error.IllegalAccessException;
		
	public class NoteType extends Enum
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
	
		public function NoteType( name : String )
		{
			super( name );
			if ( ClassReference.compare( this, NoteType ) ) {
				throw new IllegalAccessException( "You cannot instantiate NoteType. Please use inheritance" );
			}
		}
		
	}
}