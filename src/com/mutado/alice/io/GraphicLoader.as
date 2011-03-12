package com.mutado.alice.io
{
	import com.mutado.alice.abstract.AbstractLoader;
	import com.mutado.alice.core.types.ObjectType;
	import com.mutado.alice.display.DisplayObjectHelper;
	import com.mutado.alice.interfaces.INotification;
	import com.mutado.alice.io.strategy.LoaderStrategy;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;

	public class GraphicLoader extends AbstractLoader
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		private var _container : DisplayObjectContainer;
		private var _bitmapContainer : Sprite;
		private var _autoShow : Boolean;
		private var _helper : DisplayObjectHelper;
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function GraphicLoader( container : DisplayObjectContainer = null, type : ObjectType = null, autoShow : Boolean = false )
		{
			super( new LoaderStrategy( this ), type );
			_container = container;
			_autoShow = autoShow;
			_init();	
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			registerListener( LoaderStatus.COMPLETE, _onComplete );
		}
		
		// ==================================================================================
		// HANDLERS
		// ==================================================================================
		
		private function _onComplete( note : INotification ) : void
		{
			removeListener( LoaderStatus.COMPLETE, _onComplete );
			if ( data is Bitmap ) {
				_bitmapContainer = new Sprite();
				_bitmapContainer.addChild( DisplayObject( data ) );
			}
			if ( _container != null ) {
				_container.addChild( view );
			}
			if ( _autoShow ) {
				view.visible = true;	
			} else {
				view.visible = false;
			}
		}

		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function getDefinition( name : String ) : Class 
		{
			return Class( LoaderStrategy( strategy ).loaderInfo.applicationDomain.getDefinition( name ) );	
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
		public function get view() : DisplayObjectContainer
		{
			var dob : DisplayObjectContainer = DisplayObjectContainer( ( _bitmapContainer != null ? _bitmapContainer : data ) );
			if ( dob == null ) {
				return DisplayObjectContainer( LoaderStrategy( strategy ).loader.content ); 
			}
			return dob;
		}
		
		public function get helper() : DisplayObjectHelper
		{
			if ( _helper == null ) {
				_helper = new DisplayObjectHelper( view ); 
			}
			return _helper;
		}
		
	}
}