package com.mutado.alice.log.driver
{		
	import com.mutado.alice.abstract.AbstractLoggerDriver;
	import com.mutado.alice.log.*;
	
	import flash.display.AVM1Movie;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.MorphShape;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.StatusEvent;
	import flash.media.Video;
	import flash.net.LocalConnection;
	import flash.text.StaticText;
	import flash.text.TextField;
	
	public class LuminicDriver extends AbstractLoggerDriver
	{
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		private static var MAX_DEPTH : uint						= 4;	
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function LuminicDriver( level : LogLevel )
		{
			super( level );
		}
			
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _pack( level : LogLevel, msg : Object ) : Object
		{
			var pack : Object = new Object();
			pack.loggerId 	= 1;
			pack.time 		= new Date();
			pack.levelName 	= level.name;
			pack.argument 	= _serialize( msg , 1 );
			return pack;
		}
		
		private function _serialize( o : Object, depth : uint ) : Object
		{
			var type : Object = _recognize( o );
			var serial : Object = new Object();
			if( !type.inspectable ) {
				serial.value = o;
			} else if ( type.stringify ) {
				serial.value = o + "";
			} else {
				if ( depth <= MAX_DEPTH ) {
					if ( type.name == "movieclip" || type.name == "loader" || type.name == "sprite" || type.name == "stage" || type.name == "displayobjectcontainer" || type.name == "simplebutton" || type.name == "textfield" || type.name == "avm1movie" || type.name == "bitmap" || type.name == "interactiveobject" || type.name == "morphshape" || type.name == "shape" || type.name == "statictext" || type.name == "video" || type.name == "displayobject" ) {
						serial.id = o + "";	
					}
					var items : Array = new Array();
					if ( o is Array ) {
						for ( var pos : Number = 0; pos < o.length; pos++ ) {
							items.push( { property: pos, value: _serialize( o[ pos ], ( depth + 1 ) ) } );
						}
					} else {
						for ( var prop : String in o ) {
							items.push( { property: prop, value: _serialize( o[ prop ], ( depth + 1) ) } );
						}
					}
					serial.value = items;
				} else {
					serial.reachLimit = true;
				}
			}
			serial.type = type.name;
			return serial;
		}
		
		private function _recognize( o : Object ) : Object 
		{
			var typeOf : String = typeof( o );
			var type : Object = new Object();
			type.inspectable = true;
			type.name = typeOf;
			if ( typeOf == "boolean" || typeOf == "function" || typeOf == "number" || typeOf == "string" || typeOf == "undefined" ) {
				type.inspectable = false;
			} else if ( o is Array ) {
				// ARRAY
				type.name = "array";
			} else if ( o is Date ) {
				// DATE
				type.inspectable = false;
				type.name = "date";
			// --  DISPLAYOBJECT RELATED
			} else if ( o is MovieClip ) {
				// MOVIECLIP
				type.name = "movieclip";
			} else if ( o is Loader ) {
				// LOADER
				type.name = "loader";
			} else if ( o is Sprite ) {
				// SPRITE
				type.name = "sprite";
			} else if ( o is Stage ) {
				// STAGE
				type.name = "stage";
			} else if ( o is DisplayObjectContainer ) {
				// DISPLAYOBJECTCONTAINER
				type.name = "displayobjectcontainer";
			} else if ( o is SimpleButton ) {
				// SIMPLEBUTTON
				type.name = "simplebutton";
			} else if ( o is TextField ) {
				// TEXTFIELD
				type.name = "textfield";
			} else if ( o is AVM1Movie ) {
				// AVM1MOVIE
				type.name = "avm1movie";
			} else if ( o is Bitmap ) {
				// BITMAP
				type.name = "bitmap";
			} else if ( o is InteractiveObject ) {
				// INTERACTIVEOBJECT
				type.name = "interactiveobject";
			} else if ( o is MorphShape ) {
				// MORPHSHAPE
				type.name = "morphshape";
			} else if ( o is Shape ) {
				// SHAPE
				type.name = "shape";
			} else if ( o is StaticText ) {
				// STATICTEXT
				type.name = "statictext";
			} else if ( o is Video ) {
				// VIDEO
				type.name = "video";
			} else if ( o is DisplayObject ) {
				// DISPLAYOBJECT
				type.name = "displayobject";
			// XML RELATED
			} else if ( o is XMLList ) {
				// XMLLIST
				type.name = "xmllist"
				type.stringify = true;
			} else if ( o is XML ) {
				// XML
				type.name = "xml";
				type.stringify = true;
			}
			return type;
		}
		
		// ==================================================================================
		// EVENTS HANDLER
		// ==================================================================================
		
		private function _onStatus( e : StatusEvent ):void
		{
			if ( e.level == "error" ) {
				trace( "=========================================\nLocalConnection.send() failed\nMake sure the FlashInspector is running\n" );
			}	
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		override public function publish( level : LogLevel, msg : Object ) : void
		{
			var lc : LocalConnection = new LocalConnection();
			lc.addEventListener( StatusEvent.STATUS, _onStatus );
			lc.send( "_luminicbox_log_console", "log", _pack( level, msg ) );
		}
		
	}
}