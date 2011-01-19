package com.mutado.alice.util
{
	public final class NumberFormat
	{
		
		public static function addLeadingZero( value : Number ) : String
		{
			if ( value < 10 && value > -1 ) {
				return "0" + value;
			}
			return String( value );
		}
		
		public static function toDecimalString( value : Number, size : uint = 3, divider : String = ".", floatDivider : String = "," ) : String
		{
			var str : String = String( value );
			var parts : Array = str.split( "." );
			var integer : String = parts[ 0 ];
			var float : String = "";
			if ( parts.length > 1 ) {
				float = parts[ 1 ];
			}
			var units : Array = integer.split("").reverse();
			var parsed : String = "";
			var i : uint = 0;
			var count : uint = 0;
			var hasDivider : Boolean = false
			while ( i < units.length ) {
				hasDivider = ( count == size );
				parsed = units[ i ] + ( hasDivider && !isNaN( units[ i ] ) ? divider : "" ) + parsed;
				count = hasDivider ? 1 : count + 1;
				i++;
			}
			return parsed + ( float.length > 0 ? ( floatDivider + float ) : "" );
		}

	}
}