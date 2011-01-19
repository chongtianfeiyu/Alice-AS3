package com.mutado.alice.interfaces
{
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public interface ILoadStrategy
	{
		function load( request : URLRequest, context : LoaderContext = null ) : void;
		function toString() : String;
		function get owner() : ILoader;
		function set loaded( n : uint ) : void;
		function get loaded() : uint;
		function set total( n : uint ) : void;
		function get total() : uint;
		function get progress() : Number;
	}
}