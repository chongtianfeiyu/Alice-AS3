package com.mutado.alice.io
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.InvalidFormatException;
	
	import flash.utils.ByteArray;
	
	public class BinaryLoader extends FileLoader
	{
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function BinaryLoader( type : ObjectType = null )
		{
			super( FileLoader.BINARY, type );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get binary() : ByteArray
		{
			try {
				return ByteArray( data );	
			} catch ( e : Error ) {
				throw new InvalidFormatException( "Unable to convert data to ByteArray" );
			}
			return null;
		}
		
	}
}