package com.mutado.alice.templates.mvc.core
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.interfaces.IProxy;
	import com.mutado.alice.templates.mvc.interfaces.IModel;
	import com.mutado.alice.templates.mvc.interfaces.IModelProxy;
	
	import flash.utils.Dictionary;

	public class Model implements IModel
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _proxyDictionary : Dictionary;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Model()
		{
			super();
			if ( _instance != null ) {
				throw new IllegalAccessException( "Singleton instance already exists for " + this );
			}
			_instance = this;
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_proxyDictionary = new Dictionary();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
					
		public function registerProxy( proxy : IModelProxy ) : void
		{
			if ( proxy.type == null ) {
				throw new NullPointerException( "Impossible to register a proxy with null type!" );
			}
			_proxyDictionary[ proxy.type ] = proxy;
			proxy.register();
		}
		
		public function removeProxy( type : ObjectType ) : void
		{
			try {
				var proxy : IModelProxy = IModelProxy( _proxyDictionary[ type ] );
				delete _proxyDictionary[ type ];	
				proxy.dismiss();
				proxy.release();
			} catch ( e : Error ) {
				throw new NullPointerException( "Proxy type[ " + type + "] is not registered!" );
			}
		}
		
		public function hasProxy( type : ObjectType ) : Boolean
		{
			return _proxyDictionary[ type ] != null;
		}
		
		public function retrieveProxy( type : ObjectType ) : IModelProxy
		{
			var proxy : IModelProxy = _proxyDictionary[ type ];
			if ( proxy == null ) {
				throw new NullPointerException( "Cannot find proxy type[" + type + "]" );
			}
			return proxy;
		}
		
		public function releaseProxies() : void
		{
			for ( var type : Object in _proxyDictionary ) {
				var proxy : IProxy = IProxy( _proxyDictionary[ type ] );
				proxy.release();
			}
			_init();
		}
		
		public function toString() : String
		{
			return ClassReference.getReference( this );
		}
		
		// ==================================================================================
		// SINGLETON INSTANCE
		// ==================================================================================
		
		private static var _instance : IModel;
		
		public static function getInstance() : IModel
		{
			if ( _instance == null ) _instance = new Model();
			return _instance;
		}
		
	}
}