package com.mutado.alice.io
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.InvalidFormatException;
	
	import flash.net.URLVariables;
	
	public class VarsLoader extends FileLoader
	{
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function VarsLoader( type : ObjectType = null )
		{
			super( FileLoader.VARIABLES, type );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get vars() : URLVariables
		{
			try {
				return URLVariables( data );	
			} catch ( e : Error ) {
				throw new InvalidFormatException( "Unable to convert data to URLVariables" );
			}
			return null;
		}

	}
}