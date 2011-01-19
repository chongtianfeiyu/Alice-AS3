package com.mutado.alice.images {
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class TGAEncoder {
		
		public static const TGA32 : uint 		= 32;
		public static const TGA24 : uint 		= 24;
		
		public static function encode( bitmap : BitmapData, bit : uint = TGA32 ) : ByteArray
		{
			var w : uint = bitmap.width;
			var h : uint = bitmap.height;
			var ba : ByteArray = new ByteArray();
			ba.position = 0;
			ba.endian = Endian.LITTLE_ENDIAN;
			ba.writeByte( 0 );
			ba.writeByte( 0 );
			ba.writeByte( 2 );
			ba.writeShort( 0 );
			ba.writeShort( 0 );
			ba.writeByte( 0 );
			ba.writeShort( 0 );
			ba.writeShort( 0 );
			ba.writeShort( w );
			ba.writeShort( h );
			ba.writeByte( bit );
			switch ( bit ) {
				case TGA32:
					ba.writeByte( 8 );
				break;
						
				case TGA24:
					ba.writeByte( 0 );
				break;	
			}
			var y : int = h - 1;
			while ( y >= 0 ) {
				for ( var x : int = 0; x <=  ( w - 1 ); x++ ) {
					var pix : uint;
					switch ( bit ) {
						case TGA32:
							pix = bitmap.getPixel32( x, y );
							ba.writeInt( pix );
						break;
						
						case TGA24:
							pix = bitmap.getPixel( x, y );
							var r : uint = pix >> 16 & 0xff;
							var g : uint = pix >> 8 & 0xff;
							var b : uint = pix & 0xff;
							ba.writeByte( b );
							ba.writeByte( g );
							ba.writeByte( r );
						break;
					}
					
				}
				y--;
			}
			return ba;
		}
		
	}
}