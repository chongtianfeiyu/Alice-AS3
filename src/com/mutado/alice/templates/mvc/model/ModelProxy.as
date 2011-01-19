package com.mutado.alice.templates.mvc.model
{
	import com.mutado.alice.abstract.AbstractProxy;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.templates.mvc.ApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IModelProxy;
	import com.mutado.alice.core.types.NoteType;

	public class ModelProxy extends AbstractProxy implements IModelProxy
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function ModelProxy( source : Object = null, type : ObjectType = null )
		{
			super( source, type );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
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
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		protected var application : IApplicationFacade = ApplicationFacade.getInstance();
		
	}
}