package com.mutado.alice.templates.mvc.view
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.error.NullPointerException;
	import com.mutado.alice.util.AssetsFinder;

	public class AssetViewAdapter extends ViewAdapter
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AssetViewAdapter( type : ObjectType )
		{
			super( null, type );
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			adaptee = AssetsFinder.graphic( type );
			if ( adaptee == null ) {
				throw new NullPointerException( "Impossible to initialize " + this + " with type[" + type + "]" );
			}
		}
		
	}
}