package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.interfaces.IObservable;
	import com.mutado.alice.interfaces.IObserver;

	public class Observable implements IObservable
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _observers : Array;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Observable()
		{
		
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
				
		protected function getObserverAt( index : uint ) : IObserver
		{
			return IObserver( observers[ index ] );
		}

		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function addObserver( observer : IObserver ) : void
		{
			if ( !observers ) releaseObservers();
			observers.push( observer );
		}
		
		public function removeObserver( observer : IObserver ) : void
		{
			var i : Number = 0;
			while ( i < size() ) {
				if ( getObserverAt( i ).equals( observer ) ) {
					observers.splice( i, 1 );
					return;
				}
				i++;
			} 
		}
		
		public function releaseObservers() : void
		{
			_observers = new Array();
		}
		
		public function notifyObservers( o : Object ) : void
		{
			var target : Observable = Observable( clone() ); // avoid observer deletion on looping
			var i : Number = 0;
			while ( i < target.size() ) {
				target.getObserverAt( i ).update( o );
				i++;
			}
		}
		
		public function size() : uint
		{
			return observers != null ? observers.length : 0;
		}
		
		public function clone() : IObservable
		{
			var result : IObservable = new Observable();
			var i : Number = 0;
			while ( i < size() ) {
				result.addObserver( getObserverAt( i ) );
				i++;
			}
			return result;
		}
		
		public function toString() : String
		{
			return ClassReference.getReference( this );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get observers() : Array
		{
			return _observers;
		}
		
	}
}