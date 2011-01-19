package com.mutado.alice.air.images
{
	import com.mutado.alice.geom.Size;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class JPG
	{
		public static function getSize( source : File, endian : String = null ) : Size
		{
			var stream : FileStream = new FileStream();
			if ( endian != null ) {
				stream.endian = endian;
			}
			stream.open( source, FileMode.READ );
			var size : Size = new Size();
			var app0 : Boolean = false;
			var thumb : Boolean = false;
			while ( true ) {
				if ( stream.readUnsignedByte() == 0xFF ) {
					var marker : int = stream.readUnsignedByte();
					if ( marker == 0xE0 ) {
						// JFIF
						if ( app0 == true ) {
							thumb = true;
						}
						app0 = true;
					}
					if ( ( marker == 0xC0 || marker == 0xC2 ) && !thumb ) {
						// SOF0 marker
						stream.readUnsignedByte(); // 0x00
						stream.readUnsignedByte(); // 0x17
						stream.readUnsignedByte(); // 0x08
						size.height = stream.readUnsignedShort();
						size.width = stream.readUnsignedShort();
						break;
					}
					if ( marker == 0xD9 && thumb == true ) {
						thumb = false;
					}  
				}
			}
			stream.close();
			return size;
		}
	}
}