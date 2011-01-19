package com.mutado.alice.images
{
	import com.mutado.alice.images.pixelbender.BicubicResample;
	import com.mutado.alice.images.pixelbender.BilinearResample;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	public final class ImageResize
	{
		
		// CONSTANTS
		
		private static const BICUBIC_MULTIPASS_STEP : Number					= 0.5;
		private static const BICUBIC_MULTIPASS_LIMIT : Number					= 1.5;
		
		
		// BICUBIC ALGORITHM RESAMPLE API
		
		public static function resampleBitmapBicubicMultipass( 
			input : BitmapData, 
			desiredWidth : int, 
			desiredHeight : int, 
			constrainRatio : Boolean = true,
			cleanup : Boolean = true ) : BitmapData
		{
			var multipassWidth : Number = input.width - Math.ceil( ( input.width - desiredWidth ) * BICUBIC_MULTIPASS_STEP );
			var multipassHeight : Number = input.height - Math.ceil( ( input.height - desiredHeight ) * BICUBIC_MULTIPASS_STEP );
            var multipassData : BitmapData = null;
            if ( multipassWidth > multipassWidth * BICUBIC_MULTIPASS_LIMIT ) {
            	multipassData = resampleBitmapBicubic( input, multipassWidth, multipassHeight, constrainRatio, cleanup );
            	return resampleBitmapBicubicMultipass( multipassData, desiredWidth, desiredHeight, constrainRatio, cleanup );
            }
            multipassData = resampleBitmapBicubic( input, multipassWidth, multipassHeight, constrainRatio, cleanup );
            return resampleBitmapBicubic( multipassData, desiredWidth, desiredHeight, constrainRatio, cleanup );
		}
		
		public static function resampleBitmapBicubic( 
			input : BitmapData, 
			desiredWidth : int, 
			desiredHeight : int,
			constrainRatio : Boolean = true, 
			cleanup : Boolean = true ) : BitmapData
		{
			return BicubicResample.getInstance().resampleBitmap( input, desiredWidth, desiredHeight, constrainRatio, cleanup );
		}
		
		public static function resampleDisplayObjectBicubic( 
			input : DisplayObject, 
			desiredWidth : int,
			desiredHeight : int,
			constrainRatio : Boolean = true ) : BitmapData
		{
			return BicubicResample.getInstance().resampleDisplayObject( input, desiredWidth, desiredHeight, constrainRatio );	
		}
		
		// BILINEAR ALGORITHM RESAMPLE API
		
		public static function resampleBitmapBilinear( 
			input : BitmapData, 
			desiredWidth : int, 
			desiredHeight : int,
			constrainRatio : Boolean = true, 
			cleanup : Boolean = true ) : BitmapData
		{
			return BilinearResample.getInstance().resampleBitmap( input, desiredWidth, desiredHeight, constrainRatio, cleanup );	
		}
		
		public static function resampleDisplayObjectBilinear( 
			input : DisplayObject, 
			desiredWidth : int, 
			desiredHeight : int,
			constrainRatio : Boolean = true ) : BitmapData
		{
			return BilinearResample.getInstance().resampleDisplayObject( input, desiredWidth, desiredHeight, constrainRatio );	
		}
		
	}
}