package com.mutado.alice.abstract
{
	import com.mutado.alice.interfaces.ILoadStrategy;
	import com.mutado.alice.interfaces.ILoader;
	import com.mutado.alice.log.Logger;
	
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class AbstractLoadStrategy extends Abstract implements ILoadStrategy
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _owner : ILoader;
		private var _loaded : uint;
		private var _total : uint;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractLoadStrategy( owner : ILoader )
		{
			super( AbstractLoadStrategy );
			_owner = owner;
			_loaded = 0;
			_total = 0;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function load( request : URLRequest, context : LoaderContext = null ) : void
		{
			Logger.INFO( this + ".load() method is not implemented" );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get owner() : ILoader
		{
			return _owner;
		}
		
		public function set loaded( n : uint ) : void
		{
			_loaded = n;	
		}
		
		public function get loaded() : uint
		{
			return _loaded;
		}
		
		public function set total( n : uint ) : void
		{
			_total = n;	
		}
		
		public function get total() : uint
		{
			return _total;
		}
		
		public function get progress() : Number
		{
			return Math.ceil( loaded / total * 100 * 100 ) / 100;
		}
		
	}
}