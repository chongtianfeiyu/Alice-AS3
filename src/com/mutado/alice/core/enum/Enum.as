package com.mutado.alice.core.enum
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.log.Logger;
	
	import flash.utils.Dictionary;
					
	public class Enum
	{	
					
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _name : String;
		private var _value : int;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Enum( name : String, value : int = -1, ...args )
		{
			if ( args[0] && ( args[1] != args[0] ) ) {
				throw new IllegalAccessException( "Can't instantiate new enumeration of type (" + this + ")" );
			}
			if ( ClassReference.compare( this, Enum ) ) {
				throw new IllegalAccessException( "Can't instantiate native Enum. Use inheritance instead..." );
			}
			_name = name;
			_value = value;
			_register();		
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _register() : void
		{
			write( this ).add( this );
			prototype.name = name;
			prototype.value = value;
			prototype.setPropertyIsEnumerable( "name" , true);
			prototype.setPropertyIsEnumerable( "value" , true);
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
				
		public function equals( enum : Enum )  : Boolean
		{
			return (name == enum.name && value == enum.value);
		}
		
		public function toString() : String
		{
			return ClassReference.getReference( this ) + "[" + name + "]";
		}
		
		public function valueOf() : Object
		{
			return value;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get name() : String
		{
			return _name;
			
		}
		
		public function get value() : int
		{
			return _value;
		}
		
		public function get list() : Array
		{
			return read( this ).list();
		}
		
		// ==================================================================================
		// STATIC REGISTRY 
		// ==================================================================================
		
		private static var _registry : Dictionary = new Dictionary();
		
		protected static function write( target : Object ) : EnumDictionary
		{
			var cname : String = ClassReference.getReference( target );
			if ( _registry[ cname ] == null ) {
				var s : EnumDictionary = new EnumDictionary();
				_registry[ cname ] = s;
			}
			return EnumDictionary( _registry[ cname ] );
		}
		
		protected static function read( target : Object ) : EnumDictionary
		{
			var cname : String = ClassReference.getReference( target );
			var ed : EnumDictionary = EnumDictionary( _registry[ cname ] );
			if ( ed == null ) {
				throw NullPointerException( "Unknow Enum type " + cname );	
			}
			return ed;
		}
		
	}
}