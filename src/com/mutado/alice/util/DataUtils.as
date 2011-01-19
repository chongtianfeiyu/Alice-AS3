package com.mutado.alice.util
{
	import flash.utils.Dictionary;
	
	public class DataUtils
	{
		
		public static function dictionaryCount( d : Dictionary ) : uint
		{
			var c : uint = 0;
			for ( var item : * in d ) {
				c++;
			}
			return c;
		}

	}
}