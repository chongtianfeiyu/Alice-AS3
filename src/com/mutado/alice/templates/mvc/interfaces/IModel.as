package com.mutado.alice.templates.mvc.interfaces
{
	import com.mutado.alice.core.types.ObjectType;
	
	public interface IModel
	{
		function registerProxy( proxy : IModelProxy ) : void;
		function removeProxy( type : ObjectType ) : void;
		function hasProxy( type : ObjectType ) : Boolean;
		function retrieveProxy( type : ObjectType ) : IModelProxy;	
		function releaseProxies() : void;
		function toString() : String;
	}
}