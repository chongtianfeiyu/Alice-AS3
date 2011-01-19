package com.mutado.alice.templates.mvc.interfaces
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.IMediator;
	import com.mutado.alice.interfaces.INotifier;

	public interface IViewComposite extends IMediator, INotifier, IViewAdapter
	{
		function addAdapter( reference : IViewAdapter ) : void;
		function removeAdapter( reference : IViewAdapter ) : void;
		function removeAdapters() : void;
		function removeAdapterType( type : ObjectType ) : void;
		function hasAdapter( reference : IViewAdapter ) : Boolean;
		function getAdapterAt( index : uint ) : IViewAdapter;
	}
}