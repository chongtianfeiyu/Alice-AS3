package com.mutado.alice.geom
{
	public class Size
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _width : Number;
		private var _height : Number;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Size( w : Number = 0, h : Number = 0 )
		{
			_width = w;
			_height = h;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function constrain( w : Number, h : Number ) : Size
		{
			var scaleW : Number = w / width;
			var scaleH : Number = h / height;
			var ratio : Number = Math.min( scaleW, scaleH );
			return new Size( width * ratio, height * ratio ); 
		}
		
		public function toString() : String
		{
			return "Size( " + width + " , " + height + " )" ;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get width() : Number
		{
			return _width;
		}
		
		public function set width( n : Number ) : void
		{
			_width = n;
		}
		
		public function get height() : Number
		{
			return _height;
		}
		
		public function set height( n : Number ) : void
		{
			_height = n;
		}
		
		// ==================================================================================
		// STATIC API
		// ==================================================================================
		
		public static function measure( target : * ) : Size
		{
			try {
				return new Size( target.width, target.height );
			} catch ( e : Error ) { }
			return null;
		}

	}
}