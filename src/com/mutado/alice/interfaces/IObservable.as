package com.mutado.alice.interfaces
{	
	public interface IObservable
	{
		function addObserver( observer : IObserver) : void;
		function removeObserver( observer : IObserver ) : void;
		function releaseObservers() : void;
		function notifyObservers( o : Object ) : void;
		function size() : uint;
		function clone() : IObservable;
		function toString() : String;
	}
}