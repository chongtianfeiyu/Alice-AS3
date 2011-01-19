package com.mutado.alice.templates.mvc.interfaces
{
	import com.mutado.alice.core.types.NoteType;
	import com.mutado.alice.display.DisplayObjectHelper;
	import com.mutado.alice.interfaces.IAdapter;
	import com.mutado.alice.interfaces.INotifier;
	
	import flash.display.DisplayObjectContainer;

	public interface IViewAdapter extends IAdapter, INotifier
	{
		function listenFor( type : NoteType, selector : Function ) : void;
		function unlistenFor( type : NoteType, selector : Function ) : void;
		function register() : void;
		function dismiss() : void;
		function get view() : DisplayObjectContainer;
		function get helper() : DisplayObjectHelper;
		function get enabled() : Boolean;
		function set enabled( value : Boolean ) : void;
	}
}