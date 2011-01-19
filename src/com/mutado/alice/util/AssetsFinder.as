package com.mutado.alice.util
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.io.*;
	
	public final class AssetsFinder
	{
		
		// ==================================================================================
		// PUBLIC STATIC
		// ==================================================================================
		
		public static function graphic( type : ObjectType ) : GraphicLoader
		{
			return GraphicLoader( LoaderFinder.resolve( type ) );
		}
		
		public static function binary( type : ObjectType ) : BinaryLoader
		{
			return BinaryLoader( LoaderFinder.resolve( type ) );
		}
		
		public static function text( type : ObjectType ) : TextLoader
		{
			return TextLoader( LoaderFinder.resolve( type ) );
		}
		
		public static function vars( type : ObjectType ) : VarsLoader
		{
			return VarsLoader( LoaderFinder.resolve( type ) );
		}
		
		public static function xml( type : ObjectType ) : XMLLoader
		{
			return XMLLoader( LoaderFinder.resolve( type ) );
		}

	}
}