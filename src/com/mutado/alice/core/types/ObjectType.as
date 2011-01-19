package com.mutado.alice.core.types
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.enum.Enum;
	import com.mutado.alice.error.IllegalAccessException;

	public class ObjectType extends Enum
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function ObjectType( name : String )
		{
			super( name );
			if ( ClassReference.compare( this, ObjectType ) ) {
				throw new IllegalAccessException( "You cannot instantiate ObjectType. Please use inheritance" );
			}
		}
		
	}
}