package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.log.Logger;
	
	import flash.utils.Dictionary;
	
	public final class HashMap
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
	
		private var _n : uint;
		private var _keys : Dictionary;
		private var _values : Dictionary;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function HashMap()
		{
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_n = 0;
			_keys = new Dictionary ( true );
			_values = new Dictionary ( true );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function clear() : void
		{
			_init();
		}
		
		public function isEmpty() : Boolean
		{
			return ( _n == 0 );
		}
		
		public function containsKey( key : * ) : Boolean
		{
			if( key == null ) {
				var msg : String = this + ".containsKey() fails! Key argument can't be null";
				Logger.FATAL( msg );
				throw new NullPointerException( msg );
			}
			return _keys[ key ] != null;
		}

		public function containsValue( value : * ) : Boolean
		{
			return _values[ value ] != null;
		}

		public function put( key : *, value : * ) : *
		{
			if ( key != null ) {
				var old : * = null;
				if ( containsKey( key ) ) {
					old = remove( key );
				} 
				_n++;
				var count : uint = _values[ value ];
				_values[ value ] = (count > 0) ? count + 1 : 1;
				_keys[ key ] = value;
				return old;
			} else {
				var msg : String = this + ".put() failed. Key argument can't be null";
				Logger.FATAL( msg );
				throw new NullPointerException ( msg );
			}
		}

		public function pull( key : * ) : *
		{
			if( key == null ) {
				var msg : String = this + ".pull() failed. Key argument can't be null";
				Logger.FATAL( msg );
				throw new NullPointerException ( msg );
			}
			return _keys[ key ];
		}
		
		public function remove( key : * ) : *
		{
			var value : *;
			if ( containsKey( key ) ) {
				_n--;
				value = _keys[ key ];
				var count : uint = _values[ value ];
				if ( count > 1 ) {
					_values[ value ] = count - 1;
				} else {
					delete _values[ value ];
				}
				delete _keys[ key ];
			}
			return value;
		}
		
		public function size() : uint
		{
			return _n;
		}
		
		public function getKeys() : Array
		{
			var a : Array = new Array();
			for ( var key : * in _keys ) {
				a.push( key );
			} 
			return a;
		}
		
		public function getValues() : Array
		{
			var a : Array = new Array();
			for each ( var value : * in _keys ) {
				a.push( value );
			} 
			return a;
		}
		
		public function toString() : String 
		{
			return ClassReference.getReference( this );
		}

	}
}