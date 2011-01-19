package com.mutado.alice.air.util
{
	import com.mutado.alice.log.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventPhase;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	public class KeyCommandManager
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _commandMap : Dictionary;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function KeyCommandManager()
		{
			_commandMap = new Dictionary();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onKeyDown( e : KeyboardEvent ) : void
		{
			if ( checkCommand( e ) ) {
				if ( e.eventPhase == EventPhase.AT_TARGET || e.eventPhase == EventPhase.BUBBLING_PHASE ) {
					e.stopPropagation();
					e.stopImmediatePropagation();
					e.preventDefault();
				}
			}
		}
		
		// ==================================================================================
		// INTERNAL
		// ==================================================================================
		
		internal function init( view : DisplayObjectContainer, priority : int = 0 ) : void
		{
			view.stage.addEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown, true, priority );
			view.stage.addEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown, false, priority );	
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function append( action : *, keys : Array ) : void
		{
			var kc : KeyCommand = new KeyCommand();
			for ( var i : int = 0; i < keys.length; i++ ) {
				
				switch( keys[ i ] ) {
					
					case 15: // Keyboard.COMMAND fix
					case Keyboard.CONTROL:
						kc.hasCtrl = true;
					break;
					
					case 18: // Keyboard.ALTERNATE fix
						kc.hasAlt = true;
					break;
					
					case Keyboard.SHIFT:
						kc.hasShift = true;
					break;
					
					default:
						kc.keyCode = keys[ i ];
				}
			}
			_commandMap[ kc ] = action;
		}
		
		protected function checkCommand( e : KeyboardEvent ) : Boolean
		{
			var allowExecution : Boolean = e.eventPhase == EventPhase.CAPTURING_PHASE;
			for ( var kc : * in _commandMap ) {
				var kcc : KeyCommand =  KeyCommand( kc ); 
				var checkCtrl : Boolean = kcc.hasCtrl == e.ctrlKey;
				var checkAlt : Boolean = kcc.hasAlt == e.altKey;
				var checkShift : Boolean = kcc.hasShift == e.shiftKey;
				var checkCode : Boolean = kcc.keyCode == e.keyCode;
				if ( checkCtrl && checkAlt && checkShift && checkCode ) {
					if ( allowExecution ) {
						dispatch( _commandMap[ kc ] );
					}
					return true;
				}
			}
			return false;
		}
		
		protected function dispatch( command : Function ) : void
		{
			command.apply();
		}
		
		// ==================================================================================
		// SINGLETON
		// ==================================================================================
		
		protected static var _instance : KeyCommandManager;
		
		protected static function getInstance() : KeyCommandManager
		{
			if ( _instance == null ) _instance = new KeyCommandManager();
			return _instance;
		}
		
		// ==================================================================================
		// STATIC PUBLIC API
		// ==================================================================================
		
		public static function initialize( view : DisplayObjectContainer, priority : int = 0 ) : void
		{
			KeyCommandManager.getInstance().init( view, priority );
		}
		
		public static function appendAction( action : Function, ...keys ) : void
		{	 
			KeyCommandManager.getInstance().append( action, keys );
		} 
		
	}
}

// KeyCommand utility Class

internal class KeyCommand {
	
	function KeyCommand( code : int = 0, ctrl : Boolean = false, alt : Boolean = false, shift : Boolean = false )
	{
		keyCode = code;
		hasCtrl = ctrl;
		hasAlt = alt;
		hasShift = shift;
	}
	
	internal var keyCode : int;
	internal var hasCtrl : Boolean;
	internal var hasAlt : Boolean;
	internal var hasShift : Boolean;
	
}