package com.mutado.alice.io
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.InvalidFormatException;
	
	public class TextLoader extends FileLoader
	{
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function TextLoader( type : ObjectType = null )
		{
			super( FileLoader.TEXT, type );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get text() : String
		{
			try {
				return String( data );	
			} catch ( e : Error ) {
				throw new InvalidFormatException( "Unable to convert data to String" );
			}
			return null;
		}
		
	}
}