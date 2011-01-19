package com.mutado.alice.io
{
	import com.mutado.alice.abstract.AbstractLoader;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.io.strategy.URLLoaderStrategy;

	public class FileLoader extends AbstractLoader
	{
		
		// ==================================================================================
		// CONSTANTS
		// ==================================================================================
		
		public static const TEXT : String					= URLLoaderStrategy.TEXT;
		public static const VARIABLES : String				= URLLoaderStrategy.VARIABLES;
		public static const BINARY : String					= URLLoaderStrategy.BINARY;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function FileLoader( format : String, type : ObjectType = null )
		{
			super( new URLLoaderStrategy( this, format ), type );
		}
		
	}
}