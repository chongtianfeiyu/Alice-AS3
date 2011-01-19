package com.mutado.alice.encryption
{
	import com.mutado.alice.util.IntUtils;
	
	public final class GUIDFactory
	{
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private static function _newString() : String {
			return String( new Date().time ) + String( Math.floor( Math.random() * 10000 ) );
		}
		
		private static function _newInt() : int {
			return parseInt( _newString() );
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public static function create() : String
		{
			return String( IntUtils.toHex( _newInt(), true ) ).toUpperCase();
		} 

	}
}