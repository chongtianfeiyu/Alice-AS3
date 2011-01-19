package com.mutado.alice.templates.mvc.core
{
	import com.mutado.alice.abstract.AbstractFrontController;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.templates.mvc.ApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IController;
	import com.mutado.alice.core.types.NoteType;

	public class Controller extends AbstractFrontController implements IController
	{
	
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Controller()
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
			 //
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		override public function registerCommand( type : NoteType, command : Class ) : void
		{
			if ( !hasCommand( type ) ) {
				application.registerListener( type, executeCommand );	
			}
			super.registerCommand( type, command );
		}
		
		override public function removeCommand( type : NoteType ) : void
		{
			if ( !hasCommand( type ) ) {
				application.removeListener( type, executeCommand );
			}
			super.removeCommand( type );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var application : IApplicationFacade = ApplicationFacade.getInstance();
		
		// ==================================================================================
		// SINGLETON INSTANCE
		// ==================================================================================
		
		private static var _instance : IController;
		
		public static function getInstance() : IController
		{
			if ( _instance == null ) _instance = new Controller();
			return _instance;
		}
		
	}
}