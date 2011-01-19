package com.mutado.alice.util
{
	import com.mutado.alice.interfaces.IObserver;
			
	public final class DelegateObserver extends Observer
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _selector : Function;
		private var _context : Object;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function DelegateObserver( selector : Function, context : Object = null )
		{
			super();
			_selector = selector;
			_context = context;
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function compare( method : Function ) : Boolean
		{
			return selector === method;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		override public function update( o : Object ) : void 
		{
			selector.apply( ( context != null ? context : this ), [ o ] );
		}
		
		override public function equals( observer : IObserver ) : Boolean
		{
			if ( observer is DelegateObserver ) {
				var delegate : DelegateObserver = DelegateObserver( observer );
				return delegate.compare( selector );
			}
			return super.equals( observer );
		}	
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get selector() : Function
		{
			return _selector;
		}
		
		protected function get context() : Object
		{
			return _context;
		}
		
		// ==================================================================================
		// INTERNAL FACTORY
		// ==================================================================================
		
		public static function pull( selector : Function, context : Object = null ) : DelegateObserver
		{
			return new DelegateObserver( selector, context );
		}
		
	}
}