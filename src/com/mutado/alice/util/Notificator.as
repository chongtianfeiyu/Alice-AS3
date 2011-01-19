package com.mutado.alice.util
{
	import com.mutado.alice.core.ClassReference;
	import com.mutado.alice.core.types.NoteType;
	import com.mutado.alice.error.IllegalAccessException;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.interfaces.INotificator;
	import com.mutado.alice.interfaces.IObservable;
	import com.mutado.alice.interfaces.IObserver;
	
	import flash.utils.Dictionary;

	public class Notificator implements INotificator
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _typesDictionary : Dictionary;
		private var _ownersMap : HashMap;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function Notificator( pass : PrivateConstructor = null )
		{
			if ( !( pass is PrivateConstructor ) ) {
				if ( ClassReference.compare( this, Notificator ) ) {
					throw new IllegalAccessException( "You cannot instantiate " + this + ". Use accessor methods instead" );
				}
			}
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			_typesDictionary = new Dictionary();
			_ownersMap = new HashMap();
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
			
		public function registerListener( type : NoteType, selector : Function, owner : * = null ) : void
		{
			var observer : IObserver = DelegateObserver.pull( selector );
			var observable : IObservable = IObservable( _typesDictionary[ type ] );
			if ( observable == null ) {
				_typesDictionary[ type ] = new Observable();
				observable = _typesDictionary[ type ];
			}
			if ( owner != null ) {
				var dict : Dictionary = _ownersMap.pull( owner ); 
				if ( dict == null ) {
					dict = new Dictionary();
					_ownersMap.put( owner, dict );
				}
				var list : Array = dict[ type ] as Array;
				if ( list == null ) {
					list = new Array();
					dict[ type ] = list;
				}
				list.push( selector );		 
			}
			observable.addObserver( observer );
		}
		
		public function removeListener( type : NoteType, selector : Function, owner : * = null ) : void
		{
			var observer : IObserver = DelegateObserver.pull( selector );
			var observable : IObservable = IObservable( _typesDictionary[ type ] );
			if ( observable != null ) {
				observable.removeObserver( observer );	
			}
			if ( owner != null ) {
				var dict : Dictionary = _ownersMap.pull( owner ); 
				if ( dict == null ) {
					return;
				}
				var list : Array = dict[ type ] as Array;
				if ( list == null ) {
					return;
				}
				for ( var i : uint; i < list.length; i++ ) {
					if ( list[ i ] ===  selector ) {
						list.splice( i, 1 );
						return;
					}
				}
			}
		}
		
		public function notifyListeners( notification : INotification ) : void
		{
			var observable : IObservable = IObservable( _typesDictionary[ notification.type ] );
			if ( observable != null ) {
				observable.notifyObservers( notification );	
			}
		}
		
		public function releaseListeners( type : NoteType = null ) : void
		{
			if ( type != null ) {
				delete _typesDictionary[ type ];
				var owners : Array = _ownersMap.getKeys();
				for ( var i : uint = 0; i < owners.length; i++ ) {
					var dict : Dictionary = _ownersMap.pull( owners[ i ] );
					delete dict[ type ];
				}
			} else {
				_init();	
			}
		}
		
		public function releaseListenersFor( owner : * ) : void 
		{
			var dict : Dictionary = _ownersMap.pull( owner );
			for ( var item : Object in dict ) {
				var type : NoteType = NoteType( item );
				var list : Array = dict[ type ] as Array;
				var copy : Array = list.concat(); // avoid array modification during loop
				for ( var i : uint = 0; i < copy.length; i++ ) {
					removeListener( type, copy[ i ], owner );
				}
			}	
		}
		
		public function sendNotification( type : NoteType, body : Object = null, description : Object = null ) : void
		{
			if ( body == null ) {
				body = this;
			}
			notifyListeners( new Notification( type, body, description ) );	
		}
		
		public function toString() : String
		{
			return ClassReference.getReference( this );
		}
		
		// ==================================================================================
		// SINGLETON INSTANCE
		// ==================================================================================
		
		private static var _instance : INotificator;
		
		public static function getDefault() : INotificator
		{
			if ( _instance == null ) _instance = new Notificator( new PrivateConstructor() );
			return _instance;
		}
		
		// ==================================================================================
		// INTERNAL FACTORY
		// ==================================================================================
		
		public static function getNew() : INotificator
		{
			return new Notificator( new PrivateConstructor() );
		}
		
	}
}

internal class PrivateConstructor { }
