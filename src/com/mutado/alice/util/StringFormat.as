package com.mutado.alice.util
{
	import com.mutado.alice.log.Logger;
	
	public final class StringFormat
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		private var _format : String;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function StringFormat( format : String )
		{
			_format = format;
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _parseTailored( tokens : Array ) : String
		{
			var count : uint = 0;
			var parsed : String = format;
			var regexp_t : RegExp = new RegExp( "\\%@" );
			while ( count < tokens.length ) {
				var token : String = String( tokens[ count ] );
				parsed = parsed.replace( regexp_t, token );
				count++;
			}
			return parsed;
		}
		
		private function _parseIndexed( tokens : Object ) : String
		{
			var parsed : String = format;
			for ( var item : String in tokens ) {
				var token : String = String( tokens[ item ] );
				var regexp_i : RegExp = new RegExp( "\\%" + item, "sg" );
				parsed = parsed.replace( regexp_i, token );
			}
			return parsed;
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function parse( tokens : Array ) : String
		{
			if ( typeof( tokens[ 0 ] ) == "object" ) {
				return _parseIndexed( tokens[ 0 ] );
			}
			return _parseTailored( tokens as Array );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function encode( ...tokens ) : String
		{
			return parse( tokens ); 
		}
		
		public function toString() : String
		{
			return format;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get format() : String
		{
			return _format;
		}
		
		// ==================================================================================
		// INTERNAL FACTORY
		// ==================================================================================
		
		public static function create( format : String, ...tokens ) : String
		{
			var sf : StringFormat = new StringFormat( format );
			return sf.parse( tokens );
		}

	}
}