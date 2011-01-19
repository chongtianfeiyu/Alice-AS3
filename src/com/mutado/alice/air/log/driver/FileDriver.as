package com.mutado.alice.air.log.driver
{
	import com.mutado.alice.abstract.AbstractLoggerDriver;
	import com.mutado.alice.air.util.FileUtils;
	import com.mutado.alice.log.LogLevel;
	import com.mutado.alice.log.Logger;
	
	import flash.filesystem.File;

	public class FileDriver extends AbstractLoggerDriver
	{
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function FileDriver( level : LogLevel )
		{
			super( level );
			Logger.INFO( "Log File: " + log.nativePath );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		override public function publish( level : LogLevel, msg : Object ) : void
		{
			if ( !flag ) {
				flag = true;
				FileUtils.writeUTF8File( log, "" );
			}
			FileUtils.appendUTF8File( log, new Date() + " [" + level.name + "] " + msg + File.lineEnding );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		internal var flag : Boolean;
		internal var log : File = File.applicationStorageDirectory.resolvePath( "application.log" );
		
	}
}