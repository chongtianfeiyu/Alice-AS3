package com.mutado.alice.util
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class MouseProxy
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _target : DisplayObject;
		private var _isDown : Boolean;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function MouseProxy( reference : DisplayObject )
		{
			_target = reference;
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			isDown = false;
			_listenForMouse();
		}
		
		private function _listenForMouse() : void
		{
			if ( stage != null ) {
				stage.addEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown );
				stage.addEventListener( MouseEvent.MOUSE_UP, _onMouseUp );
			}
		}
		
		private function _unlistenForKey() : void
		{
			if ( stage != null ) {
				stage.removeEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown );
				stage.removeEventListener( MouseEvent.MOUSE_UP, _onMouseUp );	
			}
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onMouseDown( e : MouseEvent ) : void
		{
			isDown = true;
		}
		
		private function _onMouseUp( e : MouseEvent ) : void
		{
			isDown = false; 
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function release() : void
		{
			_unlistenForKey();
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
		
		public function get isDown() : Boolean
		{
			return _isDown;
		}
		
		public function set isDown( value : Boolean ) : void
		{
			_isDown = value;
		}
		
	}
}