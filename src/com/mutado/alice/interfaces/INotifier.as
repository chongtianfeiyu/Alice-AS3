package com.mutado.alice.interfaces
{
	import com.mutado.alice.core.types.NoteType;
	
	public interface INotifier
	{
		function sendNotification( type : NoteType, body : Object = null, description : Object = null ) : void;
		function toString() : String;	
	}
}