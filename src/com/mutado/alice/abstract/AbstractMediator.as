package com.mutado.alice.abstract
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.IMediator;
	
	public class AbstractMediator extends Abstract implements IMediator
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _collegues : Array;
		private var _type : ObjectType;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractMediator( type : ObjectType = null )
		{
			super( AbstractMediator );
			_type = type;
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_collegues = new Array();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function registerCollegue( reference : Object ) : void
		{
			if ( hasCollegue( reference ) ) {
				return;
			}
			_collegues.push( reference );
		}
		
		public function removeCollegue( reference : Object ) : void
		{
			_collegues.splice( _collegues.indexOf( reference ), 1 );
		}
		
		public function hasCollegue( reference : Object ) : Boolean
		{
			return _collegues.indexOf( reference ) != -1;
		}
		
		public function getCollegueAt( index : uint ) : Object
		{
			return _collegues[ index ];
		}
		
		public function release() : void
		{
			_init();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function collegues() : Array
		{
			return _collegues;
		}
		
		public function get count() : uint
		{
			return _collegues.length;	
		}
		
		public function get type() : ObjectType
		{
			return _type;
		}
		
	}
}