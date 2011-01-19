package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.interfaces.ITypedObject;
	import com.mutado.alice.interfaces.ITypedObjectRegistry;

	public class TypedObjectRegistry implements ITypedObjectRegistry
	{
		
		// ==================================================================================
		// VARIABLES 
		// ==================================================================================
		
		private var _typesRegistry : HashMap;
		
		// ==================================================================================
		// CONSTRUCTOR 
		// ==================================================================================
		
		public function TypedObjectRegistry( pass : PrivateConstructor = null )
		{
			if ( !( pass is PrivateConstructor ) ) {
				if ( ClassReference.compare( this, TypedObjectRegistry ) ) {
					throw new IllegalAccessException( "You cannot instantiate " + this + ". Use accessor methods instead" );
				}
			}
			_init();
		}
		
		// ==================================================================================
		// PRIVATE 
		// ==================================================================================
		
		private function _init() : void
		{
			_typesRegistry = new HashMap();
		}
		
		// ==================================================================================
		// PUBLIC 
		// ==================================================================================
		
		public function register( instance : ITypedObject ) : void
		{
			_typesRegistry.put( instance.type, instance );
		}
		
		public function unregister( type : ObjectType ) : ITypedObject
		{
			return _typesRegistry.remove( type );
		}
		
		public function isRegistered( type : ObjectType ) : Boolean
		{
			return _typesRegistry.containsKey( type );
		}
		
		public function resolve( type : ObjectType ) : ITypedObject
		{
			return _typesRegistry.pull( type );
		}
		
		public function listTypes() : Array
		{
			return _typesRegistry.getKeys();
		}
		
		public function listValues() : Array
		{
			return _typesRegistry.getValues();
		}
		
		public function release() : void
		{
			_typesRegistry.clear();
			_init();
		}
		
		public function toString() : String
		{
			return ClassReference.getReference( this );
		}
		
		// ==================================================================================
		// SINGLETON 
		// ==================================================================================
		
		private static var _instance : ITypedObjectRegistry;
		
		public static function getDefault() : ITypedObjectRegistry
		{
			if ( !_instance ) _instance = new TypedObjectRegistry( new PrivateConstructor() );
			return _instance;
		}
		
		// ==================================================================================
		// INTERNAL FACTORY
		// ==================================================================================
		
		public static function getNew() : ITypedObjectRegistry
		{
			return new TypedObjectRegistry( new PrivateConstructor() );
		}
		
	}
}

internal class PrivateConstructor { }