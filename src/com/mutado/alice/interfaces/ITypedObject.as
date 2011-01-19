package com.mutado.alice.interfaces
{
	import com.mutado.alice.core.types.ObjectType;
	
	public interface ITypedObject
	{
		function get type() : ObjectType;
		function toString() : String;	
	}
}