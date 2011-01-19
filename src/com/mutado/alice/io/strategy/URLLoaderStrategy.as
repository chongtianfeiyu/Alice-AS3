package com.mutado.alice.io.strategy
{
	import com.mutado.alice.abstract.AbstractLoadStrategy;
	import com.mutado.alice.interfaces.ILoader;
	import com.mutado.alice.io.LoaderStatus;
	import com.mutado.alice.log.Logger;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class URLLoaderStrategy extends AbstractLoadStrategy
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		public static const TEXT : String					= URLLoaderDataFormat.TEXT;
		public static const VARIABLES : String				= URLLoaderDataFormat.VARIABLES;
		public static const BINARY : String					= URLLoaderDataFormat.BINARY;
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _format : String;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function URLLoaderStrategy( owner : ILoader, format : String = TEXT )
		{
			super( owner );
			_format = format;
		}

		// ==================================================================================
		// EVENTS HANDLER
		// ==================================================================================
		
		private function _onStart( e : Event ) : void
		{
			Logger.LOG( "Loader Start " + owner + " URL: " + owner.request.url );
			owner.sendNotification( LoaderStatus.START );
		}
		
		private function _onProgres( e : ProgressEvent ) : void
		{
			loaded = e.bytesLoaded;
			total = e.bytesTotal;	
			owner.sendNotification( LoaderStatus.PROGRESS );
		}
		
		private function _onComplete( e : Event ) : void
		{
			Logger.LOG( "Loader Complete " + owner + " URL: " + owner.request.url );
			owner.data = e.target.data;
			owner.sendNotification( LoaderStatus.COMPLETE );
		}
		
		private function _onSecurityError( e : SecurityErrorEvent ) : void
		{
			Logger.ERROR( "Loader SecurityError " + owner + " URL: " + owner.request.url );
			owner.sendNotification( LoaderStatus.ERROR );
		}
		
		private function _onError( e : IOErrorEvent ) : void
		{
			Logger.ERROR( "Loader Error " + owner + " URL: " + owner.request.url );
			owner.sendNotification( LoaderStatus.ERROR );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		override public function load( request : URLRequest, context : LoaderContext = null ) : void
		{
			var ul : URLLoader = new URLLoader();
			// listeners
			ul.addEventListener( Event.OPEN, _onStart );
			ul.addEventListener( ProgressEvent.PROGRESS, _onProgres );
			ul.addEventListener( Event.COMPLETE, _onComplete );
			ul.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _onSecurityError );
			ul.addEventListener( IOErrorEvent.IO_ERROR, _onError );
			// format
			ul.dataFormat = _format;
			// start
			ul.load( request );
		}
		
	}
}