package com.mutado.alice.templates.mvc.controller
{
	import com.mutado.alice.abstract.AbstractBatchCommand;
	import com.mutado.alice.interfaces.INotifier;
	import com.mutado.alice.templates.mvc.ApplicationFacade;
	import com.mutado.alice.templates.mvc.interfaces.IApplicationFacade;
	import com.mutado.alice.core.types.NoteType;
	
	public class BatchCommand extends AbstractBatchCommand implements INotifier
	{
				
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function BatchCommand()
		{
			super();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
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