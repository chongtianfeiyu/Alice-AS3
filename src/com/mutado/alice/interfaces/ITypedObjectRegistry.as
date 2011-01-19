package com.mutado.alice.interfaces
{
	import com.mutado.alice.core.types.ObjectType;
		
	public interface ITypedObjectRegistry
	{
		function register( instance : ITypedObject ) : void;
		function unregister( type : ObjectType ) : ITypedObject;
		function isRegistered( type : ObjectType ) : Boolean;
		function resolve( type : ObjectType ) : ITypedObject;
		function listTypes() : Array;
		function listValues() : Array;
		function release() : void;
		function toString() : String;
	}
}