package com.mutado.alice.templates.properties
{
	import com.mutado.alice.util.Notificator;
	
	public class BaseProperty extends Notificator implements IProperty
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _type : PropertyType;
		private var _value : *;
		private var _name : String;
		private var _title : String;
		private var _readonly : Boolean;
		private var _binder : PropertyBinder;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function BaseProperty( propertyType : PropertyType )
		{
			_type = propertyType;
		}

		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		protected function commit() : void
		{
			sendNotification( PropertyNote.CHANGED );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get type() : PropertyType 
		{
			return _type;
		}
		
		public function set value( val : * ) : void 
		{
			_value = val;	
			commit();
		}
		
		public function get value() : * 
		{
			return _value;
		}
		
		public function set name( value : String ) : void 
		{
			_name = value;
		}
		
		public function get name() : String 
		{
			return _name;
		}
		
		public function set title( value : String ) : void 
		{
			_title = value;
		}
		
		public function get title() : String 
		{
			return _title;
		}
		
		public function set readonly( value : Boolean ) : void 
		{
			_readonly = value;
		}
		
		public function get readonly() : Boolean 
		{
			return _readonly;
		}
		
		public function set binder( value : PropertyBinder ) : void 
		{
			_binder = value;
			binder.property = this;
		}
		
		public function get binder() : PropertyBinder 
		{
			return _binder;
		}
		
	}
}