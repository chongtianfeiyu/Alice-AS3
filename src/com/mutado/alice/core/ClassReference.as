package com.mutado.alice.core
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public final class ClassReference
	{	
		
		// ==================================================================================
		// PRIVATE STATIC 
		// ==================================================================================
		
		private static var _unique : uint = 0;
		
		// ==================================================================================
		// PUBLIC STATIC 
		// ==================================================================================
			
		public static function getReference( instance : Object ) : String
		{
			return getQualifiedClassName( instance );
		}
		
		public static function getType( instance : Object ) : String
		{
			return getReference( instance ).split( "::" ).pop();
		}
		
		public static function getClass( instance : Object ) : Class
		{
			return Class( getDefinitionByName( ClassReference.getReference( instance ) ) );
		}
		
		public static function compare( instance1 : Object, instance2 : Object ) : Boolean
		{
			return getReference( instance1 ) == getReference( instance2 );
		}
		
		public static function identify( instance : Object ) : String {
			return getType( instance ) + _unique++;
		}
		
	}
}