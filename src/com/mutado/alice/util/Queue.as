package com.mutado.alice.util
{
	import com.mutado.alice.error.NullPointerException;
	
	public class Queue
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _elements : Array;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Queue( ...elements )
		{
			clear();
			_add( elements );
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _add( elements : Array ) : void
		{
			if ( elements.length > 0 ) {
				_elements = _elements.concat( elements.concat() );
			}
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================

		public function add( ...elements) : void
		{
			_add( elements );
		}
		
		public function contains( o : * ) : Boolean
		{
			return _elements.indexOf( o ) != -1;
		}
		
		public function peak() : *
		{
			var e : * = _elements[ 0 ];
			if ( e == null ) {
				throw new NullPointerException( "Queue peak[0] is null!" );
			}
			return e;
		}
		
		public function pull() : *
		{
			return _elements.shift();
		}
		
		public function cut() : *
		{
			return _elements.pop();
		}
		
		public function size() : uint
		{
			return _elements.length;
		}
		
		public function clone() : Queue
		{
			return new Queue( _elements.concat() );
		}
		
		public function clear() : void
		{
			_elements = new Array();
		}
		
		public function isEmpty() : Boolean 
		{
			return size() == 0;	
		}
		
		public function toString() : String
		{
			return _elements.toString();
		}
		
	}
}