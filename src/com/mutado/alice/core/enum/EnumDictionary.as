package com.mutado.alice.core.enum
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.error.InvalidEnumerationException;
	
	import flash.utils.Dictionary;
				
	dynamic public final class EnumDictionary extends Dictionary
	{				
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function EnumDictionary()
		{
			super()
		}
		
		// ==================================================================================
		// PUBLIC 
		// ==================================================================================
		
		public function contains( e : Enum ) : Boolean
		{
			if ( get( e.name ) ) {
				return true;
			}
			if ( e.value == -1 ) {
				return false;
			}
			for ( var item : Object in this ) {
				var es : Enum = Enum( this[ item ] );
				if ( es.value == e.value ) {
					return true;
				}
			}
			return false;
		}
		
		public function add( e : Enum ) : void
		{
			if ( contains( e ) ) {
				throw new InvalidEnumerationException( "Enum of type [" + e + "::" + e.name + "::" + e.value + "] already exists!" );
				return;
			}
			this[ e.name ] = e;
		}
		
		public function get( name : String ) : Enum
		{
			return Enum( this[ name ] );
		}
		
		public function list() : Array
		{
			var a : Array = new Array();
			for ( var item : Object in this ) {
				a.push( this[ item ] );
			}
			return a;
		}
		
		public function toString() : String
		{
			return ClassReference.getReference( this );
		}
		
	}
	
}