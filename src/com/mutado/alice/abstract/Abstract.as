package com.mutado.alice.abstract
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.error.IllegalAccessException;
	
	public class Abstract
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Abstract( abstract : Class = null )
		{
			if ( ClassReference.compare( this, abstract ) || ClassReference.compare( this, Abstract ) ) {
				throw new IllegalAccessException( "You cannot instantiate an abstract class!" );
			}
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function toString() : String
		{
			return ClassReference.getReference( this );
		}

	}
}