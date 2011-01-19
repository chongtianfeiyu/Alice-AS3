package com.mutado.alice.interfaces
{
	public interface IObserver
	{
		function update( o : Object ) : void;
		function equals( observer : IObserver ) : Boolean;
		function toString() : String;
	}
}