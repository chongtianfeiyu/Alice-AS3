package com.mutado.alice.interfaces
{
	import flash.system.LoaderContext;
	
	public interface ILoaderStack extends INotificator
	{
		function append( loader : ILoader, location : String, context : LoaderContext = null ) : void;
		function start() : void;
		function clear() : void;
		function get current() : ILoader;
		function get estimateProgress() : Number;
	}
}