package com.mutado.alice.interfaces
{
	public interface IProxy extends ITypedObject
	{
		function release() : void;
		function get data() : Object;
		function set data( source : Object) : void;
	}
}