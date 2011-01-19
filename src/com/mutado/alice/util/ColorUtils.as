package com.mutado.alice.util
{
	import flash.geom.ColorTransform;
	
	public class ColorUtils
	{
		
		public static function colorize( rgb : uint = 0, amount : Number = 1.0 ) : ColorTransform
		{
			var r : Number = ( ( rgb >> 16 ) & 0xff );
			var g : Number = ( ( rgb >> 8 ) & 0xff ) ;
			var b : Number = ( rgb & 0xff );
			return new ColorTransform( 0, 0, 0, 1, r, g, b, 1 );
		}
	}
}