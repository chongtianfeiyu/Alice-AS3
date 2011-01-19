package com.mutado.alice.images.pixelbender
{
    import com.mutado.alice.error.IllegalAccessException;
    
    import flash.display.DisplayObject;
    import flash.display.BitmapData;
    import flash.display.Shader;
    import flash.display.ShaderJob;
 
    public final class BilinearResample
    {
    	
    	// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
        [Embed ( source="../../../../../../libs/pixelbender/BilinearResample.pbj", mimeType="application/octet-stream" ) ]
        private var BilinearResampleBC : Class;
 
 		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
        public function BilinearResample()
        {
      		if ( _instance != null ) {
				throw new IllegalAccessException( "Singleton instance already exists for " + this );
			}
			_instance = this;
        }
 		
 		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
        public function resampleBitmap( input : BitmapData, desiredWidth : int, desiredHeight : int, constrainRatio : Boolean = true, cleanup : Boolean = true ) : BitmapData
        {
            var aspectRatio : Number = input.width / input.height;
 
            var factor : Number = Math.max( input.width / desiredWidth, input.height / desiredHeight );
 
            // create and configure a Shader object
            var shader : Shader = new Shader();
            shader.byteCode = new BilinearResampleBC();
            shader.data.src.input = input;
            shader.data.scale.value = [ factor ];
 
            var outputWidth : int;
            var outputHeight : int;
 
            if ( constrainRatio ) {
 				// determine output bitmap dimensions
	            if ( input.width > input.height ) {
	                outputWidth = desiredWidth;
	                outputHeight = desiredWidth / aspectRatio;
	            } else {
	                outputWidth = desiredHeight * aspectRatio;
	                outputHeight = desiredHeight;
	            }	
 			} else {
 				outputWidth = desiredWidth;
	            outputHeight = desiredHeight;
 			}
 
            // create a bitmap - our shader will return its data (an image) to this bitmap
            var output : BitmapData = new BitmapData( outputWidth, outputHeight );
 
            // shader jobs are wicked cool
            var job : ShaderJob = new ShaderJob();
            job.target = output;
            job.shader = shader;
            job.start( true );
 
            if ( cleanup ) {
                input.dispose();
            }
 
            return output;
        }
 
        public function resampleDisplayObject( source : DisplayObject, desiredWidth : int, desiredHeight : int, constrainRatio : Boolean = true ) : BitmapData
        {
            var aspectRatio : Number = source.width / source.height;
 
            var factor : Number = Math.max( source.width / desiredWidth, source.height / desiredHeight );
 
            var input : BitmapData = new BitmapData( source.width, source.height, true );
            input.draw( source );
 
            // configure the shader
            var shader : Shader = new Shader();
            shader.byteCode = new BilinearResampleBC();
            shader.data.src.input = input;
            shader.data.scale.value = [ factor ];
 
            var outputWidth : int;
            var outputHeight : int;
 
            if ( constrainRatio ) {
 				// determine output bitmap dimensions
	            if ( input.width > input.height ) {
	                outputWidth = desiredWidth;
	                outputHeight = desiredWidth / aspectRatio;
	            } else {
	                outputWidth = desiredHeight * aspectRatio;
	                outputHeight = desiredHeight;
	            }	
 			} else {
 				outputWidth = desiredWidth;
	            outputHeight = desiredHeight;
 			}
 
            var output : BitmapData = new BitmapData( outputWidth, outputHeight );
 
            var job : ShaderJob = new ShaderJob();
            job.target = output;
            job.shader = shader;
            job.start( true );
 
            input.dispose();
 
            return output;
        }
		
		// ==================================================================================
		// SINGLETON
		// ==================================================================================
		
		protected static var _instance : BilinearResample;
		
		public static function getInstance() : BilinearResample
		{
			if ( _instance == null ) _instance = new BilinearResample();
			return _instance;
		}
         
    }
}