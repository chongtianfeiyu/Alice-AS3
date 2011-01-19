package com.mutado.alice.interfaces
{	
	import com.mutado.alice.core.types.ObjectType;
	
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public interface ILoader extends ITypedObject, INotificator
	{ 
		function load( location : String = null, context : LoaderContext = null ) : void;
		function release() : void;
		function set context( context : LoaderContext ) : void;
		function get context() : LoaderContext;
		function set data( o : Object ) : void;
		function get data() : Object;
		function set post( b : Boolean ) : void;
		function set params( o : Object ) : void;
		function set nocache( b : Boolean ) : void;
		function get request() : URLRequest;
		function get loaded() : uint;
		function get total() : uint;
		function get progress() : Number;	
		function get complete() : Boolean;	
	}
}