package com.mutado.alice.util
{
	import flash.utils.ByteArray;
	
	public class Bundle
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _entries : *;
		private var _bytes : ByteArray;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Bundle()
		{
			
		}		
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function write( content : *, compress : Boolean = true ) : void
		{
			entries = content;
			bytes = new ByteArray();
			bytes.writeObject( entries );
			if ( compress ) {
				bytes.compress();
			}
		}
		
		public function read( bundle : ByteArray, compress : Boolean = true ) : void
		{
			bytes = bundle;
			if ( compress ) {
				bytes.uncompress();
			}
			entries = bundle.readObject();
		}
		
		public function dismiss() : void
		{
			bytes.clear();
			bytes = null;
			entries = null;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get bytes() : ByteArray
		{
			return _bytes;
		}
		
		public function set bytes( value : ByteArray ) : void
		{
			_bytes = value;
		}
		
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
		
		public static function encode( content : *, compress : Boolean = true ) : ByteArray
		{
			var bundle : Bundle = new Bundle();
			bundle.write( content, compress );
			return bundle.bytes;
		}
		
		public static function decode( bundle : ByteArray, compress : Boolean = true ) : *
		{
			var restore : Bundle = new Bundle();
			restore.read( bundle, compress );
			return restore.entries;
		}
		
	}
}