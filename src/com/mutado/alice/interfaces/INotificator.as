package com.mutado.alice.interfaces
{
	import com.mutado.alice.core.types.NoteType;
	
	public interface INotificator extends INotifier
	{
		function registerListener( type : NoteType, selector : Function, owner : * = null ) : void;
		function removeListener( type : NoteType, selector : Function, owner : * = null ) : void;
		function notifyListeners( notification : INotification ) : void;
		function releaseListeners( type : NoteType = null ) : void;
		function releaseListenersFor( owner : * ) : void;
	}
}