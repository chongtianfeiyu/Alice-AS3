package com.mutado.alice.templates.mvc.view
{
	import com.mutado.alice.abstract.AbstractMediator;
	import com.mutado.alice.core.types.NoteType;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.display.DisplayObjectHelper;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.templates.mvc.ApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IViewAdapter;
	import com.mutado.alice.templates.mvc.interfaces.IViewComposite;
	
	import flash.display.DisplayObjectContainer;

	public class ViewComposite extends AbstractMediator implements IViewComposite
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _container : DisplayObjectContainer;
		private var _helper : DisplayObjectHelper;
		private var _enabled : Boolean;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function ViewComposite( reference : DisplayObjectContainer, type : ObjectType = null )
		{
		 	super( type );
		 	_container = reference;
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
						
		public function addAdapter( reference : IViewAdapter ) : void
		{
			if ( reference.type != null && !application.hasAdapter( reference.type ) ) {
				application.registerAdapter( reference );	
			}
			registerCollegue( reference );
			view.addChild( reference.view );	
		}
		
		public function removeAdapter( reference : IViewAdapter ) : void
		{
			if ( application.hasAdapter( reference.type ) ) {
				application.removeAdapter( reference.type );	
			}
			removeCollegue( reference );
			if ( view.contains( reference.view ) ) {
				try {
					view.removeChild( reference.view );
				} catch ( e : Error ) {
					try {
						reference.view.parent.removeChild( reference.view );	
					} catch ( e : Error ) {
						Logger.WARN( "Impossibile to removeChild( " + reference.view + " ) from View: " + view );	
					}
				}					
			}
			reference.release();
		}
		
		public function removeAdapters() : void
		{
			for ( var i : uint = 0; i < count; i++ ) {
				removeAdapter( getAdapterAt( i ) );
			}
		}
		
		public function removeAdapterType( type : ObjectType ) : void
		{
			if ( application.hasAdapter( type ) ) {
				removeAdapter( application.retrieveAdapter( type ) );	
			} else {
				throw new NullPointerException( "Unknown ViewAdatper for type[" + type + "]" );
			}	
		}
		
		public function hasAdapter( reference : IViewAdapter ) : Boolean
		{
			return hasCollegue( reference );
		}
		
		public function getAdapterAt( index : uint ) : IViewAdapter
		{
			return IViewAdapter( getCollegueAt( index ) );
		}
		
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
			super.release();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var application : IApplicationFacade = ApplicationFacade.getInstance();
		
		protected function get container() : DisplayObjectContainer
		{
			return _container;
		}
		
		public function get view() : DisplayObjectContainer
		{
			return container;
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