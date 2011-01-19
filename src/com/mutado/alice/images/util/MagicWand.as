package com.mutado.alice.images.util
{
	import com.mutado.alice.templates.types.Note;
	import com.mutado.alice.util.Notificator;
	import com.mutado.alice.util.Thread;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class MagicWand extends Notificator
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		private static const MAX_THREAD_RECURSION : uint				= 1200;
		private static const ARGB_SCALE : uint							= 255;
		private static const SMOOTH_AMOUNT : Number						= 0.40;
		private static const SMOOTH_NEAREST : Number					= 0.05;
		
		
		// ==================================================================================
		// VARS
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function MagicWand( bd : BitmapData, x : uint = 0, y : uint = 0, tolerance : Number = 0, smooth : Boolean = false, fill : Boolean = false )
		{
			bitmapData = bd;
			this.x = x;
			this.y = y;
			this.tolerance = tolerance;
			this.smooth = smooth;
			this.fill = fill;
			reset();
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function getContiguousPixels( px : uint, py : uint ) : Array
		{
			var p1 : Point = px > 0 && py > 0 ? new Point( px - 1, py - 1 ) : null;
			var p2 : Point = py > 0 ? new Point( px, py - 1 ) : null;
			var p3 : Point = px < bitmapData.width && py > 0 ? new Point( px + 1, py - 1 ) : null;
			var p4 : Point = px > 0 ? new Point( px - 1, py ) : null;
			var p5 : Point = px < bitmapData.width ? new Point( px + 1, py ) : null;
			var p6 : Point = px > 0 && py < bitmapData.height ? new Point( px - 1, py + 1 ) : null;
			var p7 : Point = py < bitmapData.height ? new Point( px, py + 1 ) : null;
			var p8 : Point = px < bitmapData.width && py < bitmapData.height ? new Point( px + 1, py + 1 ) : null;
			var a : Array = new Array();
			validatePixel( p1 ) ? a.push( p1 ) : null;
			validatePixel( p2 ) ? a.push( p2 ) : null;
			validatePixel( p3 ) ? a.push( p3 ) : null;
			validatePixel( p4 ) ? a.push( p4 ) : null;
			validatePixel( p5 ) ? a.push( p5 ) : null;
			validatePixel( p6 ) ? a.push( p6 ) : null;
			validatePixel( p7 ) ? a.push( p7 ) : null;
			validatePixel( p8 ) ? a.push( p8 ) : null;
			return a;
		}
		
		protected function validateTolerance( p : Point ) : Boolean
		{
			var pixelColor : Object = toRGB( bitmapData.getPixel( p.x, p.y ) );
			var dr : uint = Math.abs( r - pixelColor.r );
			var dg : uint = Math.abs( g - pixelColor.g );
			var db : uint = Math.abs( b - pixelColor.b );
			if ( dr <= tolerance && dg <= tolerance && db <= tolerance ) {
				return true;
			}
			return false;
		}
		
		protected function hasPixel( p : Point ) : Boolean
		{
			try {
				return matrix[ p.x ][ p.y ] == ARGB_SCALE;
			} catch ( e : Error ) {}
			return false;
		}
		
		protected function hasSmoothPixel( p : Point ) : Boolean
		{
			try {
				return matrixSmooth[ p.x ][ p.y ] != null;
			} catch ( e : Error ) {}
			return false;
		}
		
		protected function validatePixel( p : Point ) : Boolean
		{
			if ( p == null ) {
				return false;
			}
			return validateTolerance( p ) && !hasPixel( p );
		}
		
		protected function analyze( p : Point, loops : uint = 0 ) : void
		{
			if ( smooth ) {
				smoothPixel( p );
			} else {
				appendPixel( p );	
			}
			var contiguous : Array = getContiguousPixels( p.x, p.y );
			var tp : Point;
			for ( var i : uint = 0; i < contiguous.length; i++ ) {
				tp = Point( contiguous[ i ] ); 
				if ( smooth ) {
					smoothPixel( tp );
				} else {
					appendPixel( tp );	
				}
			}
			for ( var j : uint = 0; j < contiguous.length; j++ ) { 				
				tp = Point( contiguous[ j ] );
				pending++;
				if ( loops < MAX_THREAD_RECURSION ) {
					analyze( tp, loops + 1 );	
				} else {
					Thread.detachNewThreadSelector( analyze, [ tp ] );	
				}
			}
			loops = 0;
			pending--;
			checkCompleted();
		}
		
		protected function appendPixel( p : Point , alpha : Number = 1 ) : void
		{
			if ( hasPixel( p ) ) {
				return;
			}
			if ( matrix[ p.x ] == null ) {
				matrix[ p.x ] = new Array();
			}
			var val : Number = matrix[ p.x ][ p.y ];
			if ( !isNaN( val ) ) {
				if ( val < ARGB_SCALE ) {
					val += Math.ceil( alpha * ARGB_SCALE );
					if ( val > ARGB_SCALE ) {
						val = ARGB_SCALE;
					}
				}
			} else {
				 val = Math.ceil( alpha * ARGB_SCALE );
			}
			matrix[ p.x ][ p.y ] = val; 
			// check boundaries
			compareBoundsPoint( p );
		}
		
		protected function appendSmoothPixel( p : Point , alpha : Number = 1 ) : void
		{
			if ( matrixSmooth[ p.x ] == null ) {
				matrixSmooth[ p.x ] = new Array();
			}
			var val : Number = matrixSmooth[ p.x ][ p.y ];
			if ( !isNaN( val ) ) {
				if ( val < ARGB_SCALE ) {
					val += Math.ceil( alpha * ARGB_SCALE );
					if ( val > ARGB_SCALE ) {
						val = ARGB_SCALE;
					}
				}
			} else {
				 val = Math.ceil( alpha * ARGB_SCALE );
			}
			matrixSmooth[ p.x ][ p.y ] = val;
			compareBoundsPoint( p ); 
		}
		
		protected function compareBoundsPoint( p : Point ) : void
		{
			pMin.x = Math.min( pMin.x, p.x );
			pMin.y = Math.min( pMin.y, p.y );
			pMax.x = Math.max( pMax.x, p.x );
			pMax.y = Math.max( pMax.y, p.y ); 
		}
		
		protected function smoothPixel( p : Point ) : void
		{
			var p0 : Point = p;
			var p1 : Point = p.clone();
			var p2 : Point = p.clone();
			var p3 : Point = p.clone();
			var p4 : Point = p.clone();
			var p5 : Point = p.clone();
			var p6 : Point = p.clone();
			var p7 : Point = p.clone();
			var p8 : Point = p.clone();
			p1.offset( 0, -1 );
			p2.offset( 0, 1 );
			p3.offset( 1, 0 );
			p4.offset( -1, 0 );
			p5.offset( -1, -1 );
			p6.offset( -1, 1 );
			p7.offset( 1, 1 );
			p8.offset( 1, -1 );
			appendPixel( p0, 1 - SMOOTH_AMOUNT );
			appendSmoothPixel( p1, SMOOTH_NEAREST ); 
			appendSmoothPixel( p1, SMOOTH_NEAREST );
			appendSmoothPixel( p2, SMOOTH_NEAREST );
			appendSmoothPixel( p3, SMOOTH_NEAREST );
			appendSmoothPixel( p4, SMOOTH_NEAREST );
			appendSmoothPixel( p5, SMOOTH_NEAREST );
			appendSmoothPixel( p6, SMOOTH_NEAREST );
			appendSmoothPixel( p7, SMOOTH_NEAREST );
			appendSmoothPixel( p8, SMOOTH_NEAREST );
		}
		
		protected function toRGB( color : uint ) : Object
		{
			return {
				r : ( color >> 16 ) & 0xff,
				g : ( color >> 8 ) & 0xff,
				b : color & 0xff
			}
		}
		
		protected function toHEX( r : int, g : int, b : int, a : int = ARGB_SCALE ) : int
		{
    		return a << 24 | r << 16 | g << 8 | b;
		}
		
		protected function checkCompleted() : void
		{
			if ( pending == 0 ) {
				if ( !fill ) {
					running = false;
					sendNotification( Note.COMPLETED );
					return;
				}
				fillMatrix();
			}
		}
		
		protected function fillMatrix() : void
		{
			var i : int = pMax.x;
			while( i >= pMin.x ) {
				var col : Array = matrix[ i ] as Array;
				if ( col != null ) {
					for ( var j : int = pMin.y; j < pMax.y; j++ ) {
						var p : Point = new Point( i, j );
						if ( !hasPixel( p ) ) {
							if ( scanPoint( p ) ) {
								appendPixel( p );
							}
						} 
					}
				}
				i--;
			}
			running = false;
			sendNotification( Note.COMPLETED );
		}
		
		protected function scanLeft( p : Point ) : Boolean
		{
			for ( var i : int = p.x - 1; i > pMin.x; i-- ) {
				if ( matrix[ i ][ p.y ] ) {
					return true;
				}
			}
			return false;
		}
		
		protected function scanRight( p : Point ) : Boolean
		{
			for ( var i : int = p.x + 1; i < pMax.x; i++ ) {
				if ( matrix[ i ][ p.y ] ) {
					return true;
				}
			}
			return false;
		}
		
		protected function scanTop( p : Point ) : Boolean
		{
			var col : Array = matrix[ p.x ] as Array;
			for ( var i : int = p.y - 1; i > pMin.y; i-- ) {
				if ( col[ i ] ) {
					return true;
				}
			}
			return false;
		}
		
		protected function scanBottom( p : Point ) : Boolean
		{
			var col : Array = matrix[ p.x ] as Array;
			for ( var i : int = p.y + 1; i < pMax.y; i++ ) {
				if ( col[ i ] ) {
					return true;
				}
			}
			return false;
		}
		
		protected function scanPoint( p : Point ) : Boolean 
		{
			if ( !scanTop( p ) ) {
				return false;
			}	
			if ( !scanRight( p ) ) {
				return false;
			}
			if ( !scanBottom( p ) ) {
				return false;
			} 
			if ( !scanLeft( p ) ) {
				return false;
			}
			return true;
		}	
		
		protected function findPath() : void
		{
			var i : int = pMax.x;
			while( i >= pMin.x ) {
				var col : Array = matrix[ i ] as Array;
				if ( col != null ) {
					for ( var j : int = pMin.y; j < pMax.y; j++ ) {
						var p : Point = new Point( i, j );
						var px : uint = p.x;
						var py : uint = p.y;
						if ( hasPixel( p ) ) {
							var p1 : Point = px > 0 && py > 0 ? new Point( px - 1, py - 1 ) : null;
							var p2 : Point = py > 0 ? new Point( px, py - 1 ) : null;
							var p3 : Point = px < bitmapData.width && py > 0 ? new Point( px + 1, py - 1 ) : null;
							var p4 : Point = px > 0 ? new Point( px - 1, py ) : null;
							var p5 : Point = px < bitmapData.width ? new Point( px + 1, py ) : null;
							var p6 : Point = px > 0 && py < bitmapData.height ? new Point( px - 1, py + 1 ) : null;
							var p7 : Point = py < bitmapData.height ? new Point( px, py + 1 ) : null;
							var p8 : Point = px < bitmapData.width && py < bitmapData.height ? new Point( px + 1, py + 1 ) : null;
							if ( 	!hasPixel( p1 ) ||
									!hasPixel( p2 ) ||
									!hasPixel( p3 ) ||
									!hasPixel( p4 ) ||
									!hasPixel( p5 ) ||
									!hasPixel( p6 ) ||
									!hasPixel( p7 ) ||
									!hasPixel( p8 ) ) {
										appendPath( p );
									}
									
						} 
					}
				}
				i--;
			}
		}
		
		protected function appendPath( p : Point ) : void
		{
			path.push( p );
		}
		
		protected function drawSmooth() : void
		{
			var i : int = pMax.x;
			while( i >= pMin.x ) {
				var col : Array = matrixSmooth[ i ] as Array;
				if ( col != null ) {
					for ( var j : int = pMin.y; j < pMax.y; j++ ) {
						var p : Point = new Point( i, j );
						if ( hasSmoothPixel( p ) ) {
							var a : int = col[ j ];
							bitmapData.setPixel32( i, j, toHEX( 255, 255, 255, a ) ); 
						}  
					}
				}
				i--;
			}
		}	
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function start() : void
		{
			running = true;
			reset();
			pending++;
			Thread.detachNewThreadSelector( analyze, [ new Point( x, y ) ] );
		}
		
		public function reset() : void
		{
			path = new Array();
			matrix = new Array();
			matrixSmooth = new Array();
			var rgb : Object = toRGB( bitmapData.getPixel( x, y ) );
			r = rgb.r;
			g = rgb.g;
			b = rgb.b;
			pending = 0;
			boundaries = null;
			pMin = new Point( x, y );
			pMax = new Point( x, y );
		}
		
		public function draw() : void
		{
			if ( smooth ) {
				drawSmooth();
			}
			var i : int = pMax.x;
			while( i >= pMin.x ) {
				var col : Array = matrix[ i ] as Array;
				if ( col != null ) {
					for ( var j : int = pMin.y; j < pMax.y; j++ ) {
						var p : Point = new Point( i, j );
						if ( hasPixel( p ) ) {
							var a : int = col[ j ];
							bitmapData.setPixel32( i, j, toHEX( 255, 255, 255, a ) ); 
						} 
					}
				}
				i--;
			}
		}
		
		public function convertToPath() : Array
		{
			if ( path.length == 0 ) {
				findPath();
			}
			return path.concat(); // return clone 
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var r : uint;
		protected var g : uint;
		protected var b : uint;
		protected var pending : uint;
		protected var running : Boolean;
		protected var matrixSmooth : Array;
		protected var matrix : Array;
		protected var path : Array;
		protected var bitmapData : BitmapData;
		protected var pMin : Point;
		protected var pMax : Point;
		protected var boundaries : Rectangle;
		
		public var x : uint;
		public var y : uint;
		public var tolerance : Number;
		public var smooth : Boolean;
		public var fill : Boolean;
		
		public function get bounds() : Rectangle
		{
			if ( boundaries == null ) {
				var d : Point = pMax.subtract( pMin );
				boundaries = new Rectangle( pMin.x, pMin.y, d.x, d.y ); 
			}
			return boundaries;
		}
		
	}
}