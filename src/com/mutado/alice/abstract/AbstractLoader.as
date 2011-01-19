package com.mutado.alice.abstract
{
	import com.mutado.alice.core.types.NoteType;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.interfaces.ILoadStrategy;
	import com.mutado.alice.interfaces.ILoader;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.interfaces.INotificator;
	import com.mutado.alice.util.DateUtils;
	import com.mutado.alice.util.Notificator;
	import com.mutado.alice.util.TypedObjectRegistry;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.LoaderContext;

	public class AbstractLoader extends Abstract implements ILoader
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _notificator : INotificator;
		private var _request : URLRequest;
		private var _context : LoaderContext;		
		private var _type : ObjectType;
		private var _data : Object;
		private var _strategy : ILoadStrategy;
		private var _nocache : Boolean;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractLoader( strategy : ILoadStrategy, type : ObjectType = null )
		{
			super( AbstractLoader );
			_strategy = strategy;
			_type = type;
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_notificator = Notificator.getNew();
			_request = new URLRequest();
		}
		
		private function _register() : void
		{
			if ( type == null ) {
				return;
			}
			TypedObjectRegistry.getDefault().register( this );
		}
		
		private function _unregister() : void
		{
			if ( type == null ) {
				return;
			}
			TypedObjectRegistry.getDefault().unregister( type );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function load( location : String = null, context : LoaderContext = null ) : void
		{
			if ( location != null ) {
				if ( _nocache ) {
					location += "?nocache=" + DateUtils.stringTimeStamp();
				}
				_request.url = location;	
			}
			if ( _request.url == null ) {
				throw new NullPointerException( "Unable to start " + this + ".load(). URL is null" );
			}
			_register();
			_strategy.load( _request, context );
		}
		
		public function release() : void
		{
			_unregister();
			_init();
		}
		
		public function sendNotification( type : NoteType, body : Object = null, description : Object = null ) : void
		{
			if ( body == null ) {
				body = this;
			}
			_notificator.sendNotification( type, body, description );
		}
		
		public function registerListener( type : NoteType, selector : Function, owner : * = null) : void
		{
			_notificator.registerListener( type, selector, owner );
		}
		
		public function removeListener( type : NoteType, selector : Function, owner : * = null ) : void
		{
			_notificator.removeListener( type, selector, owner );
		}
		
		public function notifyListeners( notification : INotification ) : void
		{
			_notificator.notifyListeners( notification );
		}
		
		public function releaseListeners( type : NoteType = null ) : void
		{
			_notificator.releaseListeners( type );
		}
		
		public function releaseListenersFor( owner : * ) : void
		{
			_notificator.releaseListenersFor( owner );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get strategy() : ILoadStrategy
		{
			return _strategy;	
		}
		
		public function set context( context : LoaderContext ) : void
		{
			_context = context;
		}
		
		public function get context() : LoaderContext
		{
			return _context;
		}
		
		public function get type() : ObjectType
		{
			return _type;
		}
		
		public function set data( o : Object ) : void
		{
			_data = o;
		}
		
		public function get data() : Object
		{
			return _data;
		}
		
		public function set post( b : Boolean ) : void
		{
			if ( b ) {
				_request.method = URLRequestMethod.POST;
			} else {
				_request.method = URLRequestMethod.GET;
			}
		}
		
		public function set params( o : Object ) : void
		{
			var p : URLVariables = new URLVariables();
			for ( var v : String in o ) {
				p[ v ] = o[ v ];
			}
			_request.data = p;
		}
		
		public function set nocache( b : Boolean ) : void
		{
			_nocache = b;
		}
		
		public function get request() : URLRequest
		{
			return _request;
		}
		
		public function get loaded() : uint
		{
			return _strategy.loaded;
		}
		
		public function get total() : uint
		{
			return _strategy.total;
		}
		
		public function get progress() : Number
		{
			return _strategy.progress;
		}
		
		public function get complete() : Boolean
		{
			return loaded == total;
		}
			
	}
}