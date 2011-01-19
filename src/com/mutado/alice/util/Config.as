package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.io.LoaderStatus;
	import com.mutado.alice.io.XMLLoader;
	
	public dynamic class Config extends Notificator
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		private static const DEFAULT : String					= "config.xml";
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Config( pass : PrivateConstructor = null )
		{
			super();
			if ( !( pass is PrivateConstructor ) ) {
				if ( ClassReference.compare( this, Config ) ) {
					throw new IllegalAccessException( "You cannot instantiate " + this + ". Use accessor methods instead" );
				}
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onLoaderComplete( note : INotification ) : void
		{
			parse( XMLLoader( note.body ).xml );
			notifyListeners( note );
		}
		
		private function _onLoaderStart( note : INotification ) : void
		{
			notifyListeners( note );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function parse( xml : XML ) : void
		{
			for each ( var child : XML in xml.children() )
            {
            	this[ child.name() ] = child; 
        	}
		}
		
		public function load( location : String = null ) : void
		{
			if ( location == null ) {
				location = DEFAULT;
			}
			var loader : XMLLoader = new XMLLoader();
			loader.registerListener( LoaderStatus.COMPLETE, _onLoaderComplete );
			loader.registerListener( LoaderStatus.START, _onLoaderStart );
			loader.load( location );
		}
		
		// ==================================================================================
		// SINGLETON INSTANCE
		// ==================================================================================
		
		private static var _instance : Config;
		
		public static function getDefault() : Config
		{
			if ( _instance == null ) _instance = new Config( new PrivateConstructor() );
			return _instance;
		}
		
		// ==================================================================================
		// INTERNAL FACTORY
		// ==================================================================================
		
		public static function getNew() : Config
		{
			return new Config( new PrivateConstructor() );
		}

	}
}

internal class PrivateConstructor { }
