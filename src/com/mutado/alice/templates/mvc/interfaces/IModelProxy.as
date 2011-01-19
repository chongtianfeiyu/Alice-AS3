package com.mutado.alice.templates.mvc.interfaces
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.INotifier;
	import com.mutado.alice.interfaces.IProxy;
	
	public interface IModelProxy extends IProxy, INotifier
	{
		function register() : void;
		function dismiss() : void;
	}
}