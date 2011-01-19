package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.types.NoteType;
	import com.mutado.alice.interfaces.INotification;

	public class Notification implements INotification
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _type : NoteType;
		private var _body : Object;
		private var _description : Object;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Notification( type : NoteType, body : Object = null, description : Object = null )
		{
			_type = type;
			_body = body;
			_description = description;
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function toString() : String
		{
			return ClassReference.getReference( this );
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get type() : NoteType
		{
			return _type;
		}
				
		public function get body() : Object
		{
			return _body;
		}
		
		public function get description() : Object
		{
			return _description;
		}
		
	}
}