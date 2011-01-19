package com.mutado.alice.air
{
	public class ApplicationDescriptorParser
	{
		private static var _descriptor : XML;
		private static var _data : Object;
		
		// ==================================================================================
		// PRIVATE STATIC
		// ==================================================================================
		
		private static function _parse() : void
		{
			_data = { };
			
			namespace ns = "http://ns.adobe.com/air/application/1.1";
            use namespace ns;
            
            for each ( var child : XML in _descriptor.children() )
            {
            	_data[ child.name().localName.toString() ] = child.toString(); 
        	}
			
		}
		
		// ==================================================================================
		// PUBLIC STATIC
		// ==================================================================================
		
		public static function parse( descriptor : XML ) : void
		{
			_descriptor = descriptor;
			_parse();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================

		public static function get name() : String
		{
			return _data.name;
		}
		
		public static function get version() : String
		{
			return _data.version;
		}
		
		public static function get copyright() : String
		{
			return _data.copyright;
		}
		
	}
}