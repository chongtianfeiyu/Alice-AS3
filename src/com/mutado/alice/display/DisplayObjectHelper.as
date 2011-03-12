package com.mutado.alice.display
{
	import com.mutado.alice.error.Exception;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.geom.Size;
	import com.mutado.alice.interfaces.IDisplayObjectHelper;
	import com.mutado.alice.util.Notificator;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class DisplayObjectHelper extends Notificator implements IDisplayObjectHelper
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _view : DisplayObject;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function DisplayObjectHelper( view : DisplayObject )
		{
			super();
			_view = view;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function show() : void
		{
			view.visible = true;
		}
		
		public function hide() : void
		{
			view.visible = false;
		}
		
		public function move( x : Number = NaN, y : Number = NaN ) : void
		{
			if ( !isNaN( x ) ) view.x = x;
			if ( !isNaN( y ) ) view.y = y;
		}
		
		public function resize( width : Number = NaN, height : Number = NaN ) : void
		{
			if ( !isNaN( width ) ) view.width = width;
			if ( !isNaN( height ) ) view.height = height;
		}
		
		public function rotate( deg : Number ) : void
		{
			view.rotation = deg;
		}
		
		public function scale( s : Number ) : void
		{
			view.scaleX = view.scaleY = s;
		}
		
		public function resolveUI( pointer : String ) : DisplayObject
		{
			var doc : DisplayObject;
			try {
				var docContainer : DisplayObjectContainer = DisplayObjectContainer( view );
				var docTemp: DisplayObject = DisplayObjectContainer( view );
				var keys : Array = pointer.split( "." );
				for each ( var value : String in keys ) {
					docTemp = DisplayObject( docContainer.getChildByName( value ) );
					if ( docTemp is DisplayObjectContainer ) { 
						docContainer = DisplayObjectContainer( docTemp );
					}
				}
				doc = docTemp;
			} catch ( e : Error ) { }
			if ( doc == null ) {
				throw new NullPointerException( "Cannot resolve UI '" + pointer + "'" );
			}
			return doc;			
		}
		
		public function removeFromSuperview() : void
		{
			if ( view.parent != null ) {
				view.parent.removeChild( view );
			}
		}
		
		public function get position() : Point
		{
			return new Point( view.x, view.y );
		}
		
		public function get size() : Size
		{
			return new Size( view.width, view.height );
		}
		
		public function get rect() : Rectangle
		{
			return view.getRect( view.stage );
		}
		
		public function get view() : DisplayObject
		{
			return _view;
		}
		
	}
}