package com.mutado.alice.templates.mvc
{
	import com.mutado.alice.abstract.AbstractApplication;
	import com.mutado.alice.core.types.NoteType;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.interfaces.INotificator;
	import com.mutado.alice.io.LoaderStatus;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.templates.mvc.core.*;
	import com.mutado.alice.templates.mvc.interfaces.*;
	import com.mutado.alice.templates.types.CoreNote;
	import com.mutado.alice.util.Config;
	import com.mutado.alice.util.Notificator;
	
	import flash.display.DisplayObjectContainer;

	public class ApplicationFacade extends AbstractApplication implements IApplicationFacade
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _container : DisplayObjectContainer;
		private var _config : Config;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function ApplicationFacade()
		{
			super();
			if ( _instance != null ) {
				throw new IllegalAccessException( "Singleton instance already exists for " + this );
			}
			_instance = this;
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			// init notification manager
			notificator = Notificator.getNew();
			// core
			model = Model.getInstance();
			view = View.getInstance();
			controller = Controller.getInstance();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _onConfigAvailable( note : INotification ) : void
		{
			initialize();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		// INotificator
		
		public function registerListener( type : NoteType, selector : Function, owner : * = null ) : void
		{
			notificator.registerListener( type, selector, owner );
		}
		
		public function removeListener( type : NoteType, selector : Function, owner : * = null ) : void
		{
			notificator.removeListener( type, selector, owner );
		}
		
		public function notifyListeners( notification : INotification ) : void
		{
			notificator.notifyListeners( notification );
		}
		
		public function releaseListeners( type : NoteType = null ) : void
		{
			notificator.releaseListeners( type );
		}
		
		public function releaseListenersFor( owner : * ) : void
		{
			notificator.releaseListenersFor( owner );	
		}
		
		public function sendNotification( type : NoteType, body : Object = null, description : Object = null ) : void
		{
			notificator.sendNotification( type, body, description );
		}
		
		// IModel
		
		public function registerProxy( proxy : IModelProxy ) : void
		{
			model.registerProxy( proxy );
		}
		
		public function removeProxy( type : ObjectType ) : void
		{
			model.removeProxy( type );
		}
		
		public function hasProxy( type : ObjectType ) : Boolean
		{
			return model.hasProxy( type );
		}
		
		public function retrieveProxy( type : ObjectType ) : IModelProxy
		{
			return model.retrieveProxy( type );
		}
		
		public function releaseProxies() : void
		{
			model.releaseProxies();
		}
		
		// IView
		
		public function registerAdapter( adapter : IViewAdapter ) : void
		{
			view.registerAdapter( adapter );
		}
		
		public function removeAdapter( type : ObjectType ) : void
		{
			view.removeAdapter( type );
		}
		
		public function hasAdapter( type : ObjectType ) : Boolean
		{
			return view.hasAdapter( type );
		}
		
		public function retrieveAdapter( type : ObjectType ) : IViewAdapter
		{
			return view.retrieveAdapter( type );
		}
		
		public function releaseAdapters() : void
		{
			view.releaseAdapters();
		}
		
		// IController
		
		public function registerCommand( type : NoteType, command : Class ) : void
		{
			controller.registerCommand( type, command );
		}
		
		public function removeCommand( type : NoteType ) : void
		{
			controller.removeCommand( type );
		}
		
		public function hasCommand( type : NoteType ) : Boolean
		{
			return controller.hasCommand( type );
		}
		
		public function executeCommand( notification : INotification ) : void
		{
			controller.executeCommand( notification );
		}
		
		public function releaseCommands() : void
		{
			controller.releaseCommands();
		}
		
		// IApplicationFacade
				
		public function bootstrap( container : DisplayObjectContainer, cfgfile : String = null ) : void
		{
			Logger.LOG( "Bootstrap Application @ " + new Date() );
			_container = container;
			config.registerListener( LoaderStatus.COMPLETE, _onConfigAvailable );
			config.load( cfgfile );
			sendNotification( CoreNote.BOOTSTRAP );
		}
		
		public function initialize() : void
		{
			Logger.LOG( "Initialize Application @ " + new Date() );
			config.removeListener( LoaderStatus.COMPLETE, _onConfigAvailable );
			sendNotification( CoreNote.INITIALIZE );	
		}
		
		public function startup() : void
		{
			Logger.LOG( "Startup Application @ " + new Date() );
			sendNotification( CoreNote.STARTUP );
		}
		
		public function shutdown() : void
		{
			Logger.LOG( "Shutdown Application @ " + new Date() );
			sendNotification( CoreNote.SHUTDOWN );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var model : IModel;
		protected var view : IView;
		protected var controller : IController;
		protected var notificator : INotificator;
		
		public function get container() : DisplayObjectContainer
		{
			return _container;
		}
		
		public function get config() : Config
		{
			if ( _config == null ) {
				_config = Config.getNew();
			}
			return _config;
		}
		
		// ==================================================================================
		// SINGLETON
		// ==================================================================================
		
		protected static var _instance : IApplicationFacade;
		
		public static function getInstance() : IApplicationFacade
		{
			if ( _instance == null ) _instance = new ApplicationFacade();
			return _instance;
		}
		
	}
}