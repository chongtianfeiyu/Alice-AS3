package com.mutado.alice.util
{
	public class StringUtils
	{
		
		public static function trim( original : String, count : uint, delimiter : String = "" ) : String
		{
			if ( original.length > count ) {
				return original.substr( 0, count ) + delimiter;
			}	
			return original;
		}

	}
}