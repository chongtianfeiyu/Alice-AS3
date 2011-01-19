package com.mutado.alice.util
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.ITypedObject;
	
	import flash.utils.Dictionary;
	
	public final class TypedArray
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _types : Dictionary;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================

		public function TypedArray()
		{
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_types = new Dictionary();
		}
		
		private function _getType( type : ObjectType ) : Array 
		{
			if ( _types[ type ] == null ) {
				_types[ type ] = new Array(); 
			}
			return _types[ type ]; 
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function move( value : ITypedObject, newPos : uint ) : void
		{
			var original : Array = list( value.type );
			original.splice( original.indexOf( value ), 1 );
			original.splice( newPos, 0, value );
		}
		
		public function push( value : ITypedObject ) : void
		{
			_getType( value.type ).push( value );
		}
		
		public function remove( value : ITypedObject ) : void
		{
			var a : Array = list( value.type );
			a.splice( a.indexOf( value ), 1 );
		}
		
		public function list( type : ObjectType ) : Array
		{
			return _getType( type );
		}

	}
}