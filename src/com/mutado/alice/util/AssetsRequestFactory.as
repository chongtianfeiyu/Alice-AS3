package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.io.BinaryLoader;
	import com.mutado.alice.io.GraphicLoader;
	import com.mutado.alice.io.LoaderStack;
	import com.mutado.alice.io.LoaderStatus;
	import com.mutado.alice.io.TextLoader;
	import com.mutado.alice.io.VarsLoader;
	import com.mutado.alice.io.XMLLoader;
	
	import flash.system.LoaderContext;
	
	public final class AssetsRequestFactory extends Notificator
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		public static const START 		: LoaderStatus				= LoaderStatus.START;
		public static const PROGRESS 	: LoaderStatus				= LoaderStatus.PROGRESS;
		public static const COMPLETE 	: LoaderStatus				= LoaderStatus.COMPLETE;
		public static const ERROR 		: LoaderStatus				= LoaderStatus.ERROR;
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _stack : LoaderStack;
		private var _context : LoaderContext;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AssetsRequestFactory( context : LoaderContext = null, pass : PrivateConstructor = null )
		{
			super();
			if ( !( pass is PrivateConstructor ) ) {
				if ( ClassReference.compare( this, AssetsRequestFactory ) ) {
					throw new IllegalAccessException( "You cannot instantiate " + this + ". Use accessor methods instead" );
				}
			}
			_context = context;
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_stack = new LoaderStack();
			_stack.registerListener( START, notifyListeners );
			_stack.registerListener( PROGRESS, notifyListeners );
			_stack.registerListener( COMPLETE, _onComplete );
			_stack.registerListener( ERROR, notifyListeners );
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onComplete( note : INotification ) : void
		{
			_stack.releaseListeners();
			notifyListeners( note );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function stackGraphic( type : ObjectType, location : String, autoShow : Boolean = false ) : GraphicLoader
		{
			var lo : GraphicLoader = new GraphicLoader( null, type, autoShow );
			_stack.append( lo, location, context );
			return lo;
		}
		
		public function stackXML( type : ObjectType, location : String ) : XMLLoader
		{
			var lo : XMLLoader = new XMLLoader( type );
			_stack.append( lo, location );
			return lo;
		}
		
		public function stackVars( type : ObjectType, location : String ) : VarsLoader
		{
			var lo : VarsLoader = new VarsLoader( type );
			_stack.append( lo, location );
			return lo;
		}
		
		public function stackText( type : ObjectType, location : String ) : TextLoader
		{
			var lo : TextLoader = new TextLoader( type );
			_stack.append( lo, location );
			return lo;
		}
		
		public function stackBinary( type : ObjectType, location : String ) : BinaryLoader
		{
			var lo : BinaryLoader = new BinaryLoader( type );
			_stack.append( lo, location );
			return lo;
		}
		
		public function start() : void
		{
			_stack.start();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get context() : LoaderContext
		{
			return _context;
		}
		
		protected function set context( c : LoaderContext ) : void
		{
			_context = c;
		}
		
		// ==================================================================================
		// SINGLETON INSTANCE
		// ==================================================================================
		
		private static var _instance : AssetsRequestFactory;
		
		public static function getDefault( context : LoaderContext = null ) : AssetsRequestFactory
		{
			if ( _instance == null ) _instance = new AssetsRequestFactory( context, new PrivateConstructor() );
			_instance.context = context;
			return _instance;
		}
		
		// ==================================================================================
		// INTERNAL FACTORY
		// ==================================================================================
		
		public static function getNew( context : LoaderContext = null ) : AssetsRequestFactory
		{
			return new AssetsRequestFactory( context, new PrivateConstructor() );
		}
		
	}
}

internal class PrivateConstructor { }