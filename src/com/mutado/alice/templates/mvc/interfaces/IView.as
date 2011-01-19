package com.mutado.alice.templates.mvc.interfaces
{
	import com.mutado.alice.core.types.ObjectType;
	
	public interface IView 
	{
		function registerAdapter( adapter : IViewAdapter ) : void;
		function removeAdapter( type : ObjectType ) : void;
		function hasAdapter( type : ObjectType ) : Boolean;
		function retrieveAdapter( type : ObjectType ) : IViewAdapter;
		function releaseAdapters() : void;
		function toString() : String;
	}
}