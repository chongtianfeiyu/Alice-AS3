package com.mutado.alice.io
{
	import com.mutado.alice.error.IOException;
	import com.mutado.alice.interfaces.ILoader;
	import com.mutado.alice.interfaces.ILoaderStack;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.util.Notificator;
	import com.mutado.alice.util.Queue;
	
	import flash.system.LoaderContext;

	public class LoaderStack extends Notificator implements ILoaderStack
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _queue : Queue;
		private var _currentLoader : ILoader;
		private var _completed : uint;
		private var _size : uint;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function LoaderStack()
		{
			super();
			_init();
		}

		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_queue = new Queue();
			_completed = 0;
		}
		
		private function _next() : void
		{
			sendNotification( LoaderStatus.NEXT, this, _currentLoader );
			_currentLoader = ILoader( _queue.pull() );
			if ( _currentLoader != null ) {
				_registerListeners();
			}
			_currentLoader.load();
		}
		
		private function _registerListeners() : void
		{
			_unregisterListeners();
			_currentLoader.registerListener( LoaderStatus.PROGRESS, _onLoaderProgress );
			_currentLoader.registerListener( LoaderStatus.ERROR, _onLoaderError );	
			_currentLoader.registerListener( LoaderStatus.COMPLETE, _onLoaderComplete );
		}
		
		private function _unregisterListeners() : void
		{
			_currentLoader.removeListener( LoaderStatus.PROGRESS, _onLoaderProgress );
			_currentLoader.removeListener( LoaderStatus.ERROR, _onLoaderError );	
			_currentLoader.removeListener( LoaderStatus.COMPLETE, _onLoaderComplete );
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onLoaderComplete( note : INotification ) : void
		{
			_completed++;
			if ( _queue.size() > 0 ) {
				_next();
				return;	
			}
			_unregisterListeners();
			sendNotification( LoaderStatus.COMPLETE, this );
		}
		
		private function _onLoaderError( note : INotification ) : void
		{
			sendNotification( LoaderStatus.ERROR, this );
			throw new IOException( "LoaderStack fail due to an error URL: " + _currentLoader.request.url );
		}
		
		private function _onLoaderProgress( note : INotification ) : void
		{
			sendNotification( LoaderStatus.PROGRESS, this );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function append( loader : ILoader, location : String, context : LoaderContext = null ) : void
		{
			// setup
			if ( context != null ) {
				loader.context = context;
			}
			// save url
			loader.request.url = location;
			// add to queue
			_queue.add( loader );
		}
		
		public function start() : void
		{
			_size = _queue.size();
			_next();
		}
		
		public function clear() : void
		{
			_queue.clear();
			_init();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
	
		public function get current() : ILoader
		{
			return _currentLoader;
		}
		
		public function get estimateProgress() : Number
		{
			var p1 : Number = _completed / _size * 100;
			var p2 : Number = 100 / _size * ( current.progress / 100 );
			return Math.ceil( ( p1 + p2 ) * 100 ) / 100;
		}
		
	}
}