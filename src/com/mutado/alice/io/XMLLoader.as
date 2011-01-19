package com.mutado.alice.io
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.InvalidFormatException;
		
	public class XMLLoader extends TextLoader
	{
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function XMLLoader( type : ObjectType = null )
		{
			super( type );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get xml() : XML
		{
			var result : XML = XML( data );
			if ( result.name() == null ) {
				throw new InvalidFormatException( "Unable to convert data to XML" );
			}
			return result;
		}
		
	}
}