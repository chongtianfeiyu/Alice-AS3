package com.mutado.alice.util
{
	public final class NumberUtils
	{
		
		public static function roundWithPrecision( value : Number, precision : uint ) : Number
		{
			var ratio : int = 1;
			for ( var i : uint = 0; i < precision; i++ ) {
				ratio *= 10;
			}	
			return Math.round( value * ratio ) / ratio;
		}

	}
}