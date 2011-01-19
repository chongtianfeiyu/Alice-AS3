package com.mutado.alice.geom
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Segment
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _point1 : Point;
		private var _point2 : Point;
		private var _measure : Number;
		private var _ratio : Number;
		private var _deltaXmin : Number;
		private var _deltaYmin : Number;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Segment( p1 : Point = null, p2 : Point = null )
		{
			_point1 = p1 != null ? p1 : new Point( 0, 0 );
			_point2 = p2 != null ? p2 : new Point( 0, 0 );
			_updateMeasure();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _updateMeasure() : void
		{
			_measure = Math.sqrt( Math.pow( deltaX, 2 ) + Math.pow( deltaY, 2 ) );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function setPoint1( x : Number, y : Number ) : void
		{
			point1 = new Point( x, y );
		}
		
		public function setPoint2( x : Number, y : Number ) : void
		{
			point2 = new Point( x, y );
		}
		
		public function absolute() : Segment
		{
			var abs1 : Point = new Point( Math.min( point1.x, point2.x ), Math.min( point1.y, point2.y ) );
			var abs2 : Point = new Point( Math.max( point1.x, point2.x ), Math.max( point1.y, point2.y ) );
			var segment : Segment = new Segment( abs1, abs2 );
			segment.ratio = ratio;
			segment.deltaXmin = deltaXmin;
			segment.deltaYmin = deltaYmin; 
			return segment;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get point1() : Point
		{
			return _point1;
		}
		
		public function set point1( value : Point ) : void
		{
			_point1 = value;
			_updateMeasure();
		}
		
		public function get point2() : Point
		{
			return _point2;
		}
		
		public function set point2( value : Point ) : void
		{
			_point2 = value;
			_updateMeasure();
		}
		
		public function get deltaX() : Number
		{
			return point2.x - point1.x;
		}
		
		public function get deltaY() : Number
		{
			return point2.y - point1.y;
		}
		
		public function get measure() : Number
		{
			return _measure;
		}
		
		public function get valid() : Boolean
		{
			return Math.abs( deltaX ) >= 1 && Math.abs( deltaY ) >= 1;
		}
		
		public function get bounds() : Rectangle
		{
			var w : Number = deltaX < deltaXmin ? deltaXmin : deltaX;
			var h : Number = deltaY < deltaYmin ? deltaYmin : deltaY;
			if ( !isNaN( ratio ) ) {
				if ( w > h ) {
					w = h / ratio;
				} else {
					h = w * ratio;
				}
			}
			return new Rectangle( point1.x, point1.y, w, h );
		}
		
		public function get ratio() : Number
		{
			return _ratio;
		}
		
		public function set ratio( value : Number )  : void
		{
			_ratio = value;
		}
		
		public function get deltaXmin() : Number
		{
			return _deltaXmin;
		}
		
		public function set deltaXmin( value : Number )  : void
		{
			_deltaXmin = value;
		}
		
		public function get deltaYmin() : Number
		{
			return _deltaYmin;
		}
		
		public function set deltaYmin( value : Number )  : void
		{
			_deltaYmin = value;
		}

	}
}