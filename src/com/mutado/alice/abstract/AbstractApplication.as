package com.mutado.alice.abstract
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.interfaces.IApplication;

	public class AbstractApplication extends Abstract implements IApplication
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================	
		
		private var _version : String; 
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function AbstractApplication()
		{
			super( AbstractApplication );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
			
		public function set version( build : String ) : void
		{
			_version = build;
		}
		
		public function get version() : String
		{
			return _version;
		}
		
	}
}