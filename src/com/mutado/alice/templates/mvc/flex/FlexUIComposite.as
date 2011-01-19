package com.mutado.alice.templates.mvc.flex
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.log.Logger;
	import com.mutado.alice.templates.mvc.view.ViewComposite;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	public class FlexUIComposite extends ViewComposite
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function FlexUIComposite( reference : UIComponent, type : ObjectType = null )
		{
			super( reference, type );
			reference.addEventListener( FlexEvent.CREATION_COMPLETE, _onCreationComplete );
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		protected function creationComplete() : void
		{
			Logger.INFO( this + ".creationComplete() is not implemented!" );
		} 
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onCreationComplete( e : FlexEvent ) : void
		{
			view.removeEventListener( FlexEvent.CREATION_COMPLETE, _onCreationComplete );
			creationComplete();
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get component() : UIComponent
		{
			return UIComponent( view );
		}
		
	}
}