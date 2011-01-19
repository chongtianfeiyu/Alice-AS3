package com.mutado.alice.util
{
	import com.mutado.alice.log.Logger;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class KeyProxy
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _target : DisplayObject;
		private var _keysDown : Object;
		private var _priority : uint;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function KeyProxy( reference : DisplayObject, priority : uint = 0 )
		{
			_target = reference;
			_priority = priority;
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_keysDown = new Object();
			_listenForKey();
		}
		
		private function _listenForKey() : void
		{
			if ( stage != null ) {
				stage.addEventListener( KeyboardEvent.KEY_DOWN, _onKeyPressed, _priority > 0, _priority );
				stage.addEventListener( KeyboardEvent.KEY_UP, _onKeyReleased, _priority > 0, _priority );
			}
		}
		
		private function _unlistenForKey() : void
		{	
			if ( stage != null ) {
				stage.removeEventListener( KeyboardEvent.KEY_DOWN, _onKeyPressed, _priority > 0 );
				stage.removeEventListener( KeyboardEvent.KEY_UP, _onKeyReleased, _priority > 0 );	
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onKeyPressed( e : KeyboardEvent ) : void
		{
			_keysDown[ e.keyCode ] = true;
		}
		
		private function _onKeyReleased( e : KeyboardEvent ) : void
		{
			delete _keysDown[ e.keyCode ]; 
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function isDown( code : uint ) : Boolean
		{
			return Boolean( code in _keysDown ) == true;
		}
		
		public function release() : void
		{
			_unlistenForKey();
			_keysDown = new Object();
			_target = null;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected function get target() : DisplayObject
		{
			return _target;
		}
		
		protected function get stage() : Stage
		{
			return target.stage;
		}
		
		public function get countDown() : int 
		{
			var result : int = 0;
			for ( var item : * in _keysDown ) {
				result++;
			}
			return result;
		}

	}
}