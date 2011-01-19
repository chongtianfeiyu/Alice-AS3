package com.mutado.alice.abstract
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.ITypedObject;

	public class AbstractTypedObject extends Abstract implements ITypedObject
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _type : ObjectType;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractTypedObject( type : ObjectType = null )
		{
			super( AbstractTypedObject );
			_type = type;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get type() : ObjectType
		{
			return _type;
		}
		
	}
}