package com.mutado.alice.io
{
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.interfaces.ILoader;
	import com.mutado.alice.util.TypedObjectRegistry;
	
	public final class LoaderFinder
	{
				
		// ==================================================================================
		// PUBLIC STATIC
		// ==================================================================================
		
		public static function resolve( type : ObjectType ) : ILoader
		{
			return ILoader( TypedObjectRegistry.getDefault().resolve( type ) );
		}

	}
}