package com.mutado.alice.util
{
	public class DateUtils
	{
		
		public static function stringTimeStamp() : String
		{
			var d : Date = new Date();
			return String( d.getTime() );
		}

	}
}