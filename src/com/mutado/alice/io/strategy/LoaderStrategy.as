package com.mutado.alice.io.strategy
{
	import com.mutado.alice.abstract.AbstractLoadStrategy;
	import com.mutado.alice.interfaces.ILoader;
	import com.mutado.alice.io.LoaderStatus;
	import com.mutado.alice.log.Logger;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class LoaderStrategy extends AbstractLoadStrategy
	{
				
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function LoaderStrategy( owner : ILoader )
		{
			super( owner );
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
			loaderInfo = e.currentTarget.loader.contentLoaderInfo;
			owner.data = e.currentTarget.loader.content;
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
			var ol : Loader = new Loader();
			// listeners
			ol.contentLoaderInfo.addEventListener( Event.OPEN, _onStart );
			ol.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _onProgres );
			ol.contentLoaderInfo.addEventListener( Event.INIT, _onComplete );
			ol.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _onSecurityError );
			ol.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _onError );
			ol.load( request, context );
			loader = ol;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public var loader : Loader;
		public var loaderInfo : LoaderInfo; 
		
	}
}