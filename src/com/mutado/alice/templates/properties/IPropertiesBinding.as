package com.mutado.alice.templates.properties
{
	public interface IPropertiesBinding
	{
		function addProperty( name : String, type : PropertyType, value : *, binder : PropertyBinder = null, title : String = null, readonly : Boolean = false ) : IProperty;
		function setPropertyBinder( name : String, object : *, targetName : String ) : void;
		function setPropertyValue( name : String, value : * ) : void;
		function getPropertyValue( name : String ) : *;
		function getPropertyAt( index : uint ) : IProperty;
		function get size() : uint;
	}
}