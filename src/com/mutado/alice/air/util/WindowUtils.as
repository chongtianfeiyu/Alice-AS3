package com.mutado.alice.air.util
{
	import flash.system.Capabilities;
	
	import mx.core.Window;
	
	public class WindowUtils
	{
		
		public static function center( win : Window ) : void
		{
			win.nativeWindow.x = ( Capabilities.screenResolutionX - win.nativeWindow.width ) / 2;
			win.nativeWindow.y = ( Capabilities.screenResolutionY - win.nativeWindow.height ) / 2;
		}
	}
}