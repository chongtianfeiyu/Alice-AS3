package com.mutado.alice.interfaces
{
	import com.mutado.alice.geom.Size;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public interface IDisplayObjectHelper extends INotificator
	{
		function show() : void;
		function hide() : void;
		function move( x : Number = NaN, y : Number = NaN ) : void;
		function resize( width : Number = NaN, height : Number = NaN ) : void;
		function rotate( deg : Number ) : void;
		function scale( s : Number ) : void;
		function resolveUI( pointer : String ) : DisplayObject;
		function get position() : Point;
		function get size() : Size;
		function get rect() : Rectangle;
		function get view() : DisplayObject;
	}
}