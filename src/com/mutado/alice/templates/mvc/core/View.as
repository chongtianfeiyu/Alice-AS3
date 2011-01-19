package com.mutado.alice.templates.mvc.core
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.interfaces.IAdapter;
	import com.mutado.alice.templates.mvc.interfaces.IView;
	import com.mutado.alice.templates.mvc.interfaces.IViewAdapter;
	
	import flash.utils.Dictionary;

	public class View implements IView
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _adapterDictionary : Dictionary;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function View()
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
			_adapterDictionary = new Dictionary();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function registerAdapter( adapter : IViewAdapter ) : void
		{
			if ( adapter.type == null ) {
				throw new NullPointerException( "Impossible to register an adapter with null type!" );
			}
			if ( hasAdapter( adapter.type ) ) {
				throw new IllegalAccessException( "Adapter with type[" + adapter.type + "] is already registered!" );
			}
			_adapterDictionary[ adapter.type ] = adapter;
			adapter.register();
		}
		
		public function removeAdapter( type : ObjectType ) : void
		{ 
			try {
				var adapter : IViewAdapter = IViewAdapter( _adapterDictionary[ type ] );
				delete _adapterDictionary[ type ];
				adapter.dismiss();	
			} catch ( e : Error ) {
				throw new NullPointerException( "Adapter type[" + type + "] is not registered!" );
			}
		}
				
		public function hasAdapter( type : ObjectType ) : Boolean
		{
			return _adapterDictionary[ type ] != null;
		}
		
		public function retrieveAdapter( type : ObjectType ) : IViewAdapter
		{
			return IViewAdapter( _adapterDictionary[ type ] );
		}
		
		public function releaseAdapters() : void
		{
			for ( var type : Object in _adapterDictionary ) {
				var adapter : IAdapter = IAdapter( _adapterDictionary[ type ] );
				adapter.release();
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
		
		private static var _instance : IView;
		
		public static function getInstance() : IView
		{
			if ( _instance == null ) _instance = new View();
			return _instance;
		}
		
	}
}