package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.enum.Enum;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.error.InvalidEnumerationException;
	import com.mutado.alice.error.NullPointerException;
	
	public final class Enumerator extends Enum
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Enumerator()
		{
			super( null );
			if ( ClassReference.compare( this, Enumerator ) ) {
				throw new IllegalAccessException( "Can't instantiate native Enumerator." );
			}
		}
		
		// ==================================================================================
		// STATIC METHODS
		// ==================================================================================
		
		public static function parse( enum : Class, name : String ) : Enum
		{
			try {
				var e : Enum = Enum.read( enum ).get( name );
				if ( e == null ) {
					throw new InvalidEnumerationException( "Can't parse current name as (" + ClassReference.getReference(enum) + ")!" );
				}
				return e;	
			} catch ( e : Error ) {
				throw new NullPointerException( "Impossible to Enumerate!" );
			}
			return null;
		}
		
		public static function enumerate( enum : Class ) : Array
		{
			try {
				return Enum.read( enum ).list();
			} catch ( e : Error ) {
				throw new NullPointerException( "Impossible to Enumerate!" );
			}
			return null;
		}

	}
}