package com.mutado.alice.templates.properties
{
	import com.mutado.alice.core.types.ObjectType;

	public class PropertyType extends ObjectType
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		public static const NUMERIC : PropertyType		= new PropertyType( "text" );
		public static const TEXT : PropertyType			= new PropertyType( "numeric" );
		public static const BOOLEAN : PropertyType		= new PropertyType( "boolean" );
		public static const IMAGE : PropertyType		= new PropertyType( "image" );
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function PropertyType( name : String )
		{
			super( name );
		}
		
	}
}