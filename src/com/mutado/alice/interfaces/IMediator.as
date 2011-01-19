package com.mutado.alice.interfaces
{		
	public interface IMediator extends ITypedObject
	{
		function registerCollegue( reference : Object ) : void;
		function removeCollegue( reference : Object ) : void;
		function hasCollegue( reference : Object ) : Boolean;
		function getCollegueAt( index : uint ) : Object;
		function release() : void;
		function get count() : uint;
	}
}