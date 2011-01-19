package com.mutado.alice.error
{
	import com.mutado.alice.core.ClassReference;
	
	public class Exception extends Error
	{
		public function Exception( message : String = "" ) 
		{
			super( ClassReference.getType( this ) + ": " + message );
		}
		
	}
}