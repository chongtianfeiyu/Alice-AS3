package com.mutado.alice.templates.properties
{
	public class NumericProperty extends BaseProperty
	{
		public function NumericProperty()
		{
			super( PropertyType.NUMERIC );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public var precision : uint = 0;
		
	}
}