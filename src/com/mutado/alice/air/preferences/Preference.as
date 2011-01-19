package com.mutado.alice.air.preferences
{
	import flash.data.EncryptedLocalStore;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.*;
	import flash.utils.ByteArray;

	[Event(name=PreferenceChangeEvent.PREFERENCE_CHANGED_EVENT, type="com.mutado.alice.air.preferences.PreferenceChangeEvent")]

	public class Preference extends EventDispatcher
	{
		private var _modified: Boolean = false;
		private var _filename: String = null;

		private var _data: Object = {};

		public function Preference(filename: String = null)
		{
			super();
			registerClassAlias("com.mutado.alice.air.preferences.PreferenceItem",  com.mutado.alice.air.preferences.PreferenceItem);			
			if (filename == null)
			{
				this._filename = "application.preferences";
			}
			else
			{
				this._filename = filename;
			}
		}

		public function get modified(): Boolean
		{
			return this._modified;
		}

		private static const s_boolean: String = 'Boolean';
		private static const s_int: String = 'int';
		private static const s_uint: String = 'uint';
		private static const s_number: String = 'Number';
		private static const s_bytearray: String = 'ByteArray';

		public function setValue(name: String, value: *, encrypted: Boolean = false): void
		{
			var oldValue: * = this.getValue(name);
			this._modified = oldValue != value;
			if (this._modified)
			{
				var prefItm: PreferenceItem = new PreferenceItem();
				prefItm.encrypted = encrypted;
				if (encrypted)
				{
					var bytes:ByteArray = new ByteArray();
					if (value is Boolean)
					{
						prefItm.value = s_boolean;
						bytes.writeBoolean(value);
					}
					else if (value is int)
					{
						prefItm.value = s_int;
						bytes.writeByte(value);
					}
					else if (value is uint)
					{
						prefItm.value = s_uint;
						bytes.writeUnsignedInt(value);
					}
					else if (value is Number)
					{
						prefItm.value = s_number;
						bytes.writeDouble(value);
					}
					else if (value is ByteArray)
					{
						prefItm.value = s_bytearray;
						bytes.writeBytes(value);
					}
					else  // all other types including string
					{
						bytes.writeUTFBytes(value);
					}
					EncryptedLocalStore.setItem(name, bytes);
				}
				else
				{
					prefItm.value = value;
				}
				this._data[name] = prefItm;
				this.dispatchEvent(new PreferenceChangeEvent(PreferenceChangeEvent.ADD_EDIT_ACTION, name, oldValue, value));
			}
		}

		public function getValue(name: String, defaultValue: * = null): *
		{
			var result: * = defaultValue;
			if (this._data[name] != undefined)
			{
				var prefItm: PreferenceItem = PreferenceItem(this._data[name]);
				if (prefItm.encrypted)
				{
					var bytes:ByteArray = EncryptedLocalStore.getItem(name);
					if (bytes == null)
					{
						return defaultValue;
					}
					else if (prefItm.value == s_boolean)
					{
						result = bytes.readBoolean();
					}
					else if (prefItm.value == s_int)
					{
						result = bytes.readByte();
					}
					else if (prefItm.value == s_uint)
					{
						result = bytes.readUnsignedByte();
					}
					else if (prefItm.value == s_number)
					{
						result = bytes.readDouble();
					}
					else if (prefItm.value == s_bytearray)
					{
						result = new ByteArray();
						bytes.readBytes(result);
					}
					else  // all other types including string
					{
						result = bytes.readUTFBytes(bytes.length);
					}
				}
				else
				{
					result = prefItm.value;
				}
			}
			return result;
		}

		public function deleteValue(name: String): void
		{
			if (this._data[name] != undefined)
			{
				var oldValue:* = this.getValue(name);
				if (PreferenceItem(this._data[name]).encrypted)
				{
					EncryptedLocalStore.removeItem(name);
				}
				delete this._data[name];
				this._modified = true;
				this.dispatchEvent(new PreferenceChangeEvent(PreferenceChangeEvent.DELETE_ACTION, name, oldValue));
			}
		}
		
		public function clear() : void
		{
			var prefsFile: File = File.applicationStorageDirectory.resolvePath(this._filename);
			prefsFile.deleteFile();
		}
		
		public function save(): void
		{
			var prefsFile: File = File.applicationStorageDirectory.resolvePath(this._filename);
			var fs: FileStream = new FileStream();
			try
			{
				fs.open(prefsFile, FileMode.WRITE);
				fs.writeObject(this._data);
			}
			finally
			{
				fs.close();
			}
			this._modified = false;
		}

		public function load(): void
		{
			var prefsFile: File = File.applicationStorageDirectory.resolvePath(this._filename);
			if (prefsFile.exists)
			{
				var fs: FileStream = new FileStream();
				try
				{
					fs.open(prefsFile, FileMode.READ);
					this._data = fs.readObject();
				}
				finally
				{
					fs.close();
				}
			}
		}
		
		// ==================================================================================
		// SINGLETON INSTANCE
		// ==================================================================================
		
		private static var _instance : Preference;
		
		public static function getDefault() : Preference
		{
			if ( _instance == null ) _instance = new Preference();
			return _instance;
		}
	}
}