package com.mutado.alice.images.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class CropTool
	{
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		private var _target : DisplayObject;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function CropTool( reference : DisplayObject )
		{
			_target = reference;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function cropArea( crop : Rectangle, scale : Number = 1.0, smooth : Boolean = false ) : BitmapData
		{
			var width : Number = Math.ceil( crop.width * scale );
			var height : Number = Math.ceil( crop.height * scale );
			var bd : BitmapData = new BitmapData( width, height, true, 0xff000000 );
			var matrix : Matrix = new Matrix();
			matrix.translate( -crop.x, -crop.y );
			matrix.scale( scale, scale );
			var rect : Rectangle = new Rectangle( 0, 0, width, height );
			bd.draw( target, matrix, null, null, rect, smooth ); 
			return bd;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get target() : DisplayObject
		{
			return _target;
		}

	}
}