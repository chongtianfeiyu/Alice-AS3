package com.mutado.alice.abstract
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.IProxy;

	public class AbstractProxy extends Abstract implements IProxy
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _data : Object;
		private var _type : ObjectType;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractProxy( source : Object = null, type : ObjectType = null )
		{
			super( AbstractProxy );
			_data = source;
			_type = type;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function release() : void
		{
			_data = null;	
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
	
		public function get data() : Object 
		{
			return _data;
		}
		
		public function set data( source : Object ) : void
		{
			_data = source;
		}
		
		public function get type() : ObjectType
		{
			return _type;
		}
		
	}
}