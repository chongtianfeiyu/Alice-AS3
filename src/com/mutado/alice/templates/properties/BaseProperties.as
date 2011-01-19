package com.mutado.alice.templates.properties
{
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.log.Logger;
	
	public class BaseProperties implements IPropertiesBinding
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function BaseProperties( reference : * )
		{
			target = reference;
			properties = new Array();
			propsMap = new Object();
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function commitProperties() : void
		{
			Logger.LOG( this + ".commitProperties() is not implemented!" );
		}
		
		protected function propName( prop : IProperty ) : String {
			return String( propsMap[ prop ] );
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onPropertyChanged( note : INotification ) : void
		{
			var prop : IProperty = IProperty( note.body );
			prop.binder.apply(); 
			commitProperties();
		}	
	
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function addProperty( name : String, type : PropertyType, value : *, binder : PropertyBinder = null, title : String = null, readonly : Boolean = false ) : IProperty
		{
			var prop : IProperty;
			
			 switch ( type ) {
			 	
			 	case PropertyType.NUMERIC:
			 		prop = new NumericProperty(); 
			 	break;
			 	
			 	case PropertyType.TEXT:
			 		prop = new TextProperty();
			 	break;
			 	
			 	case PropertyType.BOOLEAN:
			 		prop = new BooleanProperty();
			 	break;
			 	
			 	case PropertyType.IMAGE:
			 		prop = new ImageProperty();
			 	break;
			 	
			 }
			 
			 prop.name = name;
			 prop.binder = binder == null ? new PropertyBinder( target, name ) : binder;
			 prop.value = value;
			 prop.title = title;
			 prop.readonly = readonly;
			 prop.registerListener( PropertyNote.CHANGED, _onPropertyChanged );
			 
			 propsMap[ name ] = prop;
			 properties.push( prop );
			 return prop;
		}
		
		public function addTextProperty( name : String, value : String, binder : PropertyBinder = null, title : String = null, readonly : Boolean = false ) : IProperty
		{
			return addProperty( name, PropertyType.TEXT, value, binder, title, readonly );
		}
		
		public function addImageProperty( name : String, value : *, binder : PropertyBinder = null, title : String = null, readonly : Boolean = false ) : IProperty
		{
			return addProperty( name, PropertyType.IMAGE, value, binder, title, readonly );
		} 
		
		public function addNumericProperty( name : String, value : Number, binder : PropertyBinder = null, title : String = null, readonly : Boolean = false ) : IProperty
		{
			return addProperty( name, PropertyType.NUMERIC, value, binder, title, readonly );
		}
		
		public function setPropertyBinder( name : String, object : *, targetName : String ) : void
		{
			IProperty( propsMap[ name ] ).binder = new PropertyBinder( object, targetName );
		}
		
		public function setPropertyValue( name : String, value : * ) : void
		{
			IProperty( propsMap[ name ] ).value = value;
		}
		
		public function getPropertyValue( name : String ) : *
		{
			return IProperty( propsMap[ name ] ).value;
		}
		
		public function getPropertyAt( index : uint ) : IProperty
		{
			return IProperty( properties[ index ] );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var target : *;
		protected var properties : Array;
		protected var propsMap : Object;
		
		public function get size() : uint
		{
			return properties.length;
		}
				
	}
}