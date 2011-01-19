package com.mutado.alice.templates.properties
{
	public class PropertyBinder
	{
		public function PropertyBinder( target : * = null, name : String = null )
		{
			this.target = target;
			this.name = name; 	
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function apply() : void
		{
			target[ name ] = property.value;
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================

		public var property : IProperty;
		public var target : *;
		public var name : String;
		
	}
}