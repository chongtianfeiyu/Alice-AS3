package com.mutado.alice.templates.mvc.view
{
	import com.mutado.alice.abstract.AbstractAdapter;
	import com.mutado.alice.core.types.NoteType;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.display.DisplayObjectHelper;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.templates.mvc.ApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IViewAdapter;
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	public class ViewAdapter extends AbstractAdapter implements IViewAdapter
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _selectors : Dictionary;
		private var _helper : DisplayObjectHelper;
		private var _enabled : Boolean;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function ViewAdapter( reference : DisplayObjectContainer, type : ObjectType = null )
		{
			super( reference, type );
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{

		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================

		protected function validate() : void
		{
			Logger.INFO( this + ".validate() is not impemented!" );
		}
		
		protected function invalidate() : void
		{
			Logger.INFO( this + ".invalidate() is not impemented!" );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function listenFor( type : NoteType, selector : Function ) : void
		{
			application.registerListener( type, selector, this );
		}
		
		public function unlistenFor( type : NoteType, selector : Function ) : void
		{
			application.removeListener( type, selector, this );
		}
	
		public function register() : void
		{
			Logger.INFO( this + ".register() is not implemented!" );
		}
		
		public function dismiss() : void
		{
			Logger.INFO( this + ".dismiss() is not implemented!" );
		}
		
		public function sendNotification( type : NoteType, body : Object = null, description : Object = null ) : void
		{
			application.sendNotification( type, body, description );
		}
		
		override public function release() : void
		{
			application.releaseListenersFor( this );
			helper.removeFromSuperview();
			super.release();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var application : IApplicationFacade = ApplicationFacade.getInstance();
		
		public function get view() : DisplayObjectContainer
		{
			return DisplayObjectContainer( adaptee );
		}
		
		public function get helper() : DisplayObjectHelper
		{
			if ( _helper == null ) {
				_helper = new DisplayObjectHelper( view );
			}	
			return _helper;
		}
		
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		
		public function set enabled( value : Boolean ) : void
		{
			_enabled = value;
			value ? validate() : invalidate();
		}
		
	}
}