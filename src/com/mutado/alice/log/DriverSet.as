package com.mutado.alice.log
{
	import com.mutado.alice.log.driver.*;
	
	internal class DriverSet
	{
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		public var CONSOLE : Class							= ConsoleDriver;
		public var LUMINIC : Class							= LuminicDriver;
		public var MONSTERDEBUGGER : Class					= MonsterDebuggerDriver;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function DriverSet()
		{
			
		}
		
	}
}