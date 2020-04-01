package editor.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 李鹏辉
	 */
	public class ShortcutEvent extends Event 
	{
		public static var SHORTCUT_EVENT:String = "shortcut_event";
		/**
		 * 
		 * @param	type 快捷键类型（Up，down）
		 * @param	data 
		 * @param	bubbles
		 * @param	cancelable
		 */
		private var _key:String = "";
		public function ShortcutEvent(type:String,key:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_key = key;
		}
		override public function clone():Event {
			return new ShortcutEvent(type, _key, bubbles, cancelable);
		}
		public function get key():String 
		{
			return _key;
		}
		
		public function set key(value:String):void 
		{
			_key = value;
		}
	}

}