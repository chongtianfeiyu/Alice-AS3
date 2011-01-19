package com.mutado.alice.templates.mvc.interfaces
{
	import com.mutado.alice.interfaces.INotificator;
	import com.mutado.alice.util.Config;
	
	import flash.display.DisplayObjectContainer;
			
	public interface IApplicationFacade extends INotificator, IModel, IView, IController
	{
		function bootstrap( container : DisplayObjectContainer, cfgfile : String = null ) : void;
		function initialize() : void;
		function startup() : void;
		function shutdown() : void;
		function get container() : DisplayObjectContainer;
		function get config() : Config;
	}
}