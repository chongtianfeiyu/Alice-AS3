package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.interfaces.IObserver;
	import com.mutado.alice.log.Logger;

	public class Observer implements IObserver
	{
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Observer()
		{
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function update( o : Object ) : void
		{
			Logger.INFO( this + ".update() method is not implemented" );
		}
		
		public function equals( observer : IObserver ) : Boolean
		{
			return this === observer;
		}
		
		public function toString():String
		{
			return ClassReference.getReference( this );
		}
		
	}
}