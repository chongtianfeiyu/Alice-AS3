package com.mutado.alice.air.util
{
	import com.mutado.alice.error.InvalidFormatException;
	import com.mutado.alice.util.Bundle;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class FilesBundle extends Bundle
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function FilesBundle()
		{
			super();
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function recurseFolder( tree : Dictionary, folder : File, baseFolder : File ) : Dictionary
		{
			var list : Array = folder.getDirectoryListing();
			for ( var i : uint = 0; i < list.length; i++ ) {
				var ref : File = File( list[ i ] );
				if ( ref.isDirectory ) {
					recurseFolder( tree, ref, baseFolder );
				} else {
					var stream : FileStream = new FileStream();
					stream.open( ref, FileMode.READ );
					var data : ByteArray = new ByteArray();
					var name : String = baseFolder.getRelativePath( ref ); 
					stream.readBytes( data );
					tree[ name ] = data;
					stream.close();
					data = null;
				}
			}
			return tree;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function append( folder : File, compress : Boolean = true ) : void
		{
			if ( !folder.isDirectory ) {
				throw new InvalidFormatException( "Cannot bundle a single file. Use directory instead!" );
			}	
			var dict : Dictionary = new Dictionary();
			write( recurseFolder( dict , folder, folder ), compress );
			// clear objects
			for ( var item : * in dict ) {
				dict[ item ] = null;
				delete dict[ item ];
			}
			dict = null;
		}
		
		public function save( destination : File ) : void
		{
			var stream : FileStream = new FileStream();
			stream.open( destination, FileMode.WRITE );
			stream.writeBytes( bytes );
			stream.close();
		}
		
		public function load( bundle : File, compress : Boolean = true ) : void
		{
			var stream : FileStream = new FileStream();
			stream.open( bundle, FileMode.READ );
			var result : ByteArray = new ByteArray();
			stream.readBytes( result );
			stream.close();
			read( result, compress );
		}
		
		public function extract( folder : File ) : void
		{
			if ( !folder.isDirectory ) {
				throw new InvalidFormatException( "Cannot extract bundle to a single file. Use directory instead!" );
			}
			var files : Dictionary = Dictionary( entries );
			for ( var path : String in files ) {
				var fileEntry : File = folder.resolvePath( path );
				if( !fileEntry.isDirectory ) {
					var entry : FileStream = new FileStream();
					entry.open( fileEntry , FileMode.WRITE);
					entry.writeBytes( files[ path ] );
					entry.close();
					// cleanup
				 	files[ path ] = null;
				 	delete files[ path ];
				}
			}
			files = null;
		}
		
		// ==================================================================================
		// PUBLIC API
		// ==================================================================================
		
		public static function pack( folder : File, destination : File, compress : Boolean = true ) : void
		{
			var filesBundle : FilesBundle = new FilesBundle();
			filesBundle.append( folder, compress );
			filesBundle.save( destination );
			filesBundle.dismiss();
			filesBundle = null;
		}
		
		public static function unpack( bundle : File, destination : File, compress : Boolean = true ) : void
		{
			var filesBundle : FilesBundle = new FilesBundle();
			filesBundle.load( bundle, compress );
			filesBundle.extract( destination );
			filesBundle.dismiss();
			filesBundle = null;
		}

	}
}