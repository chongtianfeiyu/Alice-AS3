package com.mutado.alice.air.util
{
	import com.mutado.alice.error.InvalidFormatException;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.templates.types.Note;
	import com.mutado.alice.util.DeferredAction;
	import com.mutado.alice.util.Notificator;
	import com.mutado.alice.util.Queue;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	public class FilesChunkBundle extends Notificator
	{
	
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _entries : *;
				
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function FilesChunkBundle()
		{
			registerClassAlias( "com.mutado.alice.air.util.FileChunk", FileChunk );
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function recurseFolder( tree : Queue, folder : File, baseFolder : File ) : Queue
		{
			var list : Array = folder.getDirectoryListing();
			for ( var i : uint = 0; i < list.length; i++ ) {
				var ref : File = File( list[ i ] );
				if ( ref.isDirectory ) {
					recurseFolder( tree, ref, baseFolder );
				} else {
					var ci : ChunkInfo = new ChunkInfo();
					ci.key = baseFolder.getRelativePath( ref );
					ci.file = ref;
					tree.add( ci );
				}
			}
			return tree;
		}
		
		protected function pack( folder : File, destination : File, compress : Boolean = true, signature : ByteArray = null ) : void
		{
			if ( !folder.isDirectory ) {
				sendNotification( Note.FAILED );
				throw new InvalidFormatException( "Cannot bundle a single file. Use directory instead!" );
			}
			
			useCompression = compress;
			queue = recurseFolder( new Queue(), folder, folder );
			
			// open file stream
			fs = new FileStream();
			fs.openAsync( destination, FileMode.WRITE );
			if ( signature != null ) {
				// write signature
				fs.writeBytes( signature );
			}
			
			// start queue	
			packNext();
		}
		
		protected function packNext() : void
		{
			var ci : ChunkInfo = ChunkInfo( queue.pull() );
			var fc : FileChunk = new FileChunk();
			fc.key = ci.key;
			fc.content = FileUtils.readBinaryFile( ci.file );
			
			if ( useCompression ) {
				ByteArray( fc.content ).compress();	
			}
			
			fs.writeObject( fc );
			
			if ( queue.isEmpty() ) {
				packComplete();
				return;
			}
			
			DeferredAction.execute( 1, packNext );
			//packNext();
		}
		
		protected function packComplete() : void
		{
			fs.close();
			sendNotification( Note.COMPLETED, this );
		}
		
		protected function unpack( bundle : File, destination : File, compress : Boolean = true, signature : ByteArray = null ) : void
		{
			if ( !destination.isDirectory ) {
				throw new InvalidFormatException( "Cannot extract bundle to a single file. Use directory instead!" );
			}
			
			fs = new FileStream();
			fs.open( bundle, FileMode.READ );
			if ( signature != null ) {
				fs.position = signature.length;
			}
			
			useCompression = compress;
			unpackDestination = destination;
			
			readNext();
		}
		
		protected function readNext() : void
		{
			if ( fs.bytesAvailable == 0 ) {
				unpackComplete();
				return;
			}
			var fc : FileChunk = FileChunk( fs.readObject() );
			var fileEntry : File = unpackDestination.resolvePath( fc.key );
			FileUtils.writeBinaryFile( fileEntry, fc.content );
			
			DeferredAction.execute( 1, readNext );
		}
		
		protected function unpackComplete() : void
		{
			fs.close();
			sendNotification( Note.COMPLETED, this );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var fs : FileStream;
		protected var useCompression : Boolean;
		protected var unpackDestination : File;
		protected var queue : Queue;		
		
		
		public function get entries() : *
		{
			return _entries;
		}	
		
		public function set entries( value : * ) : void
		{
			_entries = value;
		}
		
		// ==================================================================================
		// PUBLIC API
		// ==================================================================================
		
		public static function pack( folder : File, destination : File, complete : Function, fail : Function, compress : Boolean = true, signature : ByteArray = null ) : void
		{
			var chunkBundle : FilesChunkBundle = new FilesChunkBundle();
			chunkBundle.registerListener( Note.COMPLETED, complete );
			chunkBundle.registerListener( Note.FAILED, fail );	
			chunkBundle.pack( folder, destination, compress, signature );
		}
		
		public static function unpack( bundle : File, destination : File, complete : Function, fail : Function, compress : Boolean = true, signature : ByteArray = null ) : void
		{
			var chunkBundle : FilesChunkBundle = new FilesChunkBundle();
			chunkBundle.registerListener( Note.COMPLETED, complete );
			chunkBundle.registerListener( Note.FAILED, fail );
			chunkBundle.unpack( bundle, destination, compress, signature );
		}
		
	}
}
	

// Internal ChunkInfo util class

internal class ChunkInfo {

	function ChunkInfo() {
		
	}
	
	public var key : String;
	public var file : flash.filesystem.File;

}