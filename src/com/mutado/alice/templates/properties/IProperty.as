package com.mutado.alice.templates.properties
{
	import com.mutado.alice.interfaces.INotificator;
	
	public interface IProperty extends INotificator
	{
		function set name( value : String ) : void;
		function get name() : String;
		function set value( val : * ) : void;
		function get value() : *;
		function set title( value : String ) : void;
		function get title() : String;
		function set readonly( value : Boolean ) : void;		
		function get readonly() : Boolean;
		function set binder( value : PropertyBinder ) : void;
		function get binder() : PropertyBinder;
		function get type() : PropertyType;
	}
}