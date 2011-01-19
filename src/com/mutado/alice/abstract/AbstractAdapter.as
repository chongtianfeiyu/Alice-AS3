package com.mutado.alice.abstract
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.IAdapter;

	public class AbstractAdapter extends Abstract implements IAdapter
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _adaptee : Object;
		private var _type : ObjectType;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractAdapter( reference : Object, type : ObjectType = null )
		{
			super( AbstractAdapter );
			_adaptee = reference;
			_type = type;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function release() : void
		{
			_adaptee = null;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get adaptee() : Object
		{
			return _adaptee;
		}
		
		protected function set adaptee( reference : Object ) : void
		{
			_adaptee = reference;
		}
		
		public function get type() : ObjectType
		{
			return _type;
		}
		
	}
}