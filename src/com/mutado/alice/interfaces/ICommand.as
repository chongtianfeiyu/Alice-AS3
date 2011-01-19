package com.mutado.alice.interfaces
{
	public interface ICommand
	{
		function execute( notification : INotification ) : void;
		function toString() : String;
		function get callback() : Function;
		function set callback( selector : Function ) : void;
	}
}