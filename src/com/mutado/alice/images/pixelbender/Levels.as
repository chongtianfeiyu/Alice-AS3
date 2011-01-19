package com.mutado.alice.images.pixelbender
{
    import com.mutado.alice.error.IllegalAccessException;
    
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Shader;
    import flash.display.ShaderJob;
 
    public final class Levels
    {
    	
    	// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		private static const RGB : Array = 			[ 0.0, 1.0 ];
		private static const R : Array = 			[ 0.0, 1.0 ];
		private static const G : Array = 			[ 0.0, 1.0 ];
		private static const B : Array = 			[ 0.0, 1.0 ];
		
    	// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
        [Embed ( source="../../../../../../libs/pixelbender/Levels.pbj", mimeType="application/octet-stream" ) ]
        private var LevelsBC : Class;
 
 		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
        public function Levels()
        {
      		if ( _instance != null ) {
				throw new IllegalAccessException( "Singleton instance already exists for " + this );
			}
			_instance = this;
        }
 		
 		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
        public function applyBitmap( input : BitmapData, rgb : Array = null, r : Array = null, g : Array = null, b : Array = null, cleanup : Boolean = true ) : BitmapData
        {
        	if ( rgb == null ) 	rgb = RGB;
        	if ( r == null ) 	r = R;
        	if ( g == null ) 	g = G;
        	if ( b == null ) 	b = B;
            // b and configure a Shader object
            var shader : Shader = new Shader();
            shader.byteCode = new LevelsBC();
            shader.data.src.input = input;
            shader.data.RGB.value = rgb;
            shader.data.R.value = r;
            shader.data.G.value = g;
            shader.data.B.value = b;
 
            // create a bitmap - our shader will return its data (an image) to this bitmap
            var output : BitmapData = new BitmapData( input.width, input.height );
         
            // shader jobs are wicked cool
            var job : ShaderJob = new ShaderJob();
            job.target = output;
            job.shader = shader;
            job.start( true );
 
            if ( cleanup )
            {
                input.dispose();
            }
 
            return output;
        }
 
        public function applyDisplayObject( source : DisplayObject, rgb : Array = null, r : Array = null, g : Array = null, b : Array = null ) : BitmapData
        {
        	if ( rgb == null ) 	rgb = RGB;
        	if ( r == null ) 	r = R;
        	if ( g == null ) 	g = G;
        	if ( b == null ) 	b = B;
        	
            var input : BitmapData = new BitmapData( source.width, source.height, true );
            input.draw( source );
 
            // create and configure a Shader object
            var shader : Shader = new Shader();
            shader.byteCode = new LevelsBC();
            shader.data.src.input = input;
            shader.data.RGB.value = rgb;
            shader.data.R.value = r;
            shader.data.G.value = g;
            shader.data.B.value = b;
 
            // create a bitmap - our shader will return its data (an image) to this bitmap
            var output : BitmapData = new BitmapData( input.width, input.height );
         
            // shader jobs are wicked cool
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
		
		protected static var _instance : Levels;
		
		public static function getInstance() : Levels
		{
			if ( _instance == null ) _instance = new Levels();
			return _instance;
		}
         
    }
}