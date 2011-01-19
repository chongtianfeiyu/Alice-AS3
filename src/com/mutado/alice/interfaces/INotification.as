package com.mutado.alice.interfaces
{
	import com.mutado.alice.core.types.NoteType;
				
	public interface INotification
	{
		function get type() : NoteType;
		function get body() : Object;
		function get description() : Object;
		function toString() : String;
	}
}