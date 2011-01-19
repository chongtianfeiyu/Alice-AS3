package com.mutado.alice.interfaces
{
	import com.mutado.alice.core.types.NoteType;
	
	public interface IFrontController
	{
		function registerCommand( type : NoteType, command : Class ) : void;
		function removeCommand( type : NoteType ) : void;
		function hasCommand( type : NoteType ) : Boolean;
		function executeCommand( notification : INotification ) : void;
		function releaseCommands() : void;
		function toString() : String;
	}
}