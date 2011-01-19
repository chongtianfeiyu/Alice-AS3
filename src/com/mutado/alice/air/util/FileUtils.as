package com.mutado.alice.air.util
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class FileUtils
	{
		
		public static function writeXMLFile( destination : File, data : String ) : void
		{
			data = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" + data;
			data.replace( /\n/g, File.lineEnding );
			writeUTF8File( destination, data );
		}
		
		public static function readXMLFile( source : File ) : XML
		{
			return new XML( readUTF8File( source ) );
		}
		
		public static function writeUTF8File( destination : File, data : String ) : void
		{
			var stream : FileStream = new FileStream();
			stream.open( destination, FileMode.WRITE );
			stream.writeUTFBytes( data );
			stream.close();
		}
		
		public static function appendUTF8File( destination : File, data : String ) : void
		{
			var stream : FileStream = new FileStream();
			stream.open( destination, FileMode.APPEND );
			stream.writeUTFBytes( data );
			stream.close();
		}
		
		public static function readUTF8File( source : File ) : String
		{
			var stream : FileStream = new FileStream();
			stream.open( source, FileMode.READ );
			var result : String = stream.readUTFBytes( stream.bytesAvailable );
			stream.close();
			return result;
		}
		
		public static function writeBinaryFile( destination : File, data : ByteArray, endian : String = null ) : void
		{
			var stream : FileStream = new FileStream();
			if ( endian != null ) {
				stream.endian = endian;
			}
			stream.open( destination, FileMode.WRITE );
			stream.writeBytes( data );
			stream.close();
		}
		
		public static function readBinaryFile( source : File, endian : String = null ) : ByteArray
		{
			var stream : FileStream = new FileStream();
			if ( endian != null ) {
				stream.endian = endian;
			}
			stream.open( source, FileMode.READ );
			var result : ByteArray = new ByteArray();
			stream.readBytes( result );
			stream.close();
			return result;
		}

	}
}