package editor.manager 
{
	import editor.events.ShortcutEvent;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import morn.core.handlers.Handler;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class ShortcutManager
	{
		public static var SAVE:String = "ctrl,s";
		public static var SAVE_ALL:String = "ctrl,shift,s";
		
		private static var _instance:ShortcutManager = null;
		private var _stage:Stage = null;
		private var _ctrlDown:Boolean = false;
		private var _shiftDown:Boolean = false;
		private var _altDown:Boolean = false;
		private var _disableDispatch:Boolean = false;
		private var _code4key:Dictionary = new Dictionary;
		
		private var _keyList:Object = { };
		private var _key4Func:Dictionary = new Dictionary;
		private var _func4Key:Dictionary = new Dictionary;
		
		private var _keys:Array = [];
		
		public var MODEL_BLOCK:String = "";
		public var MODEL_MASK:String = "";
		public var MODEL_ERASER:String = "";
		public var MODEL_FILL:String = "";
		
		public var TYPE_DRAW:String = "";
		public var TYPE_LAYOUT:String = "";
		
		public var EXPORT_MON:String = "";
		public var EXPORT_NPC:String = "";
		public var EXPORT_TEL:String = "";
		public var EXPORT_MAP:String = "";
		
		
		public function ShortcutManager() 
		{
			_code4key[Keyboard.Q] = "q";
			_code4key[Keyboard.W] = "w";
			_code4key[Keyboard.E] = "e";
			_code4key[Keyboard.R] = "r";
			_code4key[Keyboard.T] = "t";
			_code4key[Keyboard.Y] = "y";
			_code4key[Keyboard.U] = "u";
			_code4key[Keyboard.I] = "i";
			_code4key[Keyboard.O] = "o";
			_code4key[Keyboard.P] = "p";
			_code4key[Keyboard.A] = "a";
			_code4key[Keyboard.S] = "s";
			_code4key[Keyboard.D] = "d";
			_code4key[Keyboard.F] = "f";
			_code4key[Keyboard.G] = "g";
			_code4key[Keyboard.H] = "h";
			_code4key[Keyboard.J] = "j";
			_code4key[Keyboard.K] = "k";
			_code4key[Keyboard.L] = "l";
			_code4key[Keyboard.Z] = "z";
			_code4key[Keyboard.X] = "x";
			_code4key[Keyboard.C] = "c";
			_code4key[Keyboard.V] = "v";
			_code4key[Keyboard.B] = "b";
			_code4key[Keyboard.N] = "n";
			_code4key[Keyboard.M] = "m";
			_code4key[Keyboard.DELETE] = "del";
			_code4key[Keyboard.ALTERNATE] = "alt";
			_code4key[Keyboard.CONTROL] = "ctrl";
			_code4key[Keyboard.SHIFT] = "shift";
			
			_code4key[Keyboard.LEFT] = "left";
			_code4key[Keyboard.UP] = "up";
			_code4key[Keyboard.RIGHT] = "right";
			_code4key[Keyboard.DOWN] = "down";
			
			_code4key[Keyboard.NUMBER_0] = "0";
			_code4key[Keyboard.NUMBER_1] = "1";
			_code4key[Keyboard.NUMBER_2] = "2";
			_code4key[Keyboard.NUMBER_3] = "3";
			_code4key[Keyboard.NUMBER_4] = "4";
			_code4key[Keyboard.NUMBER_5] = "5";
			_code4key[Keyboard.NUMBER_6] = "6";
			_code4key[Keyboard.NUMBER_7] = "7";
			_code4key[Keyboard.NUMBER_8] = "8";
			_code4key[Keyboard.NUMBER_9] = "9";
			
			_code4key[Keyboard.NUMPAD_0] = "0";
			_code4key[Keyboard.NUMPAD_1] = "1";
			_code4key[Keyboard.NUMPAD_2] = "2";
			_code4key[Keyboard.NUMPAD_3] = "3";
			_code4key[Keyboard.NUMPAD_4] = "4";
			_code4key[Keyboard.NUMPAD_5] = "5";
			_code4key[Keyboard.NUMPAD_6] = "6";
			_code4key[Keyboard.NUMPAD_7] = "7";
			_code4key[Keyboard.NUMPAD_8] = "8";
			_code4key[Keyboard.NUMPAD_9] = "9";
			
			_code4key[Keyboard.F1] = "F1";
			_code4key[Keyboard.F2] = "F2";
			_code4key[Keyboard.F3] = "F3";
			_code4key[Keyboard.F4] = "F4";
			_code4key[Keyboard.F5] = "F5";
			_code4key[Keyboard.F6] = "F6";
			_code4key[Keyboard.F7] = "F7";
			_code4key[Keyboard.F8] = "F8";
			_code4key[Keyboard.F9] = "F9";
			_code4key[Keyboard.F10] = "F10";
			_code4key[Keyboard.F11] = "F11";
			_code4key[Keyboard.F12] = "F12";
		}
		public function init(stage:Stage):void 
		{
			_stage = stage;
			if (_stage) 
			{
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, handlerKeyDown);
				_stage.addEventListener(KeyboardEvent.KEY_UP, handlerKeyUp);
				_stage.addEventListener(FocusEvent.FOCUS_IN, handlerFocusIn);
				_stage.addEventListener(FocusEvent.FOCUS_OUT,handlerFocusOut);
			}
			initProjectShortcutDefault();
		}
		public function initProjectShortcutDefault():void
		{
			var file:File = File.applicationDirectory.resolvePath("shortcut.xml");
			if (file.exists) 
			{
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var xmlString:String=fs.readMultiByte(fs.bytesAvailable, "utf-8");
				fs.close();
				var xml:XML = new XML(xmlString);
				
				var xmllist:XMLList = xml.children();
				for (var i:int = 0; i < xmllist.length(); i++) 
				{
					var item:XML = xmllist[i] as XML;
					var target:String = String(item.@target);
					if (this.hasOwnProperty(target))
					{
						this[target] = String(item.@key);
					}
				}
			}
		}
		/**
		 * 增加一个快捷键
		 * @param	key 快捷键 例如:ctrl,shift,s; ctrl,s;shift,s 组合键用“,”分隔
		 * @param	type 快捷键类型,0:系统 1:自定义
		 * @param	desp 快捷键描述
		 * @param	handler 对应执行的方法
		 */
		public function register(key:String,type:int,desp:String,handler:Handler):void 
		{
			var obj:Object = new Object();
			obj.type = type;
			obj.desp = desp;
			obj.func = handler;
			obj.key = key;
			_key4Func[key] = obj;
			_func4Key[desp] = obj;
		}
		private function handlerKeyDown(e:KeyboardEvent):void 
		{
			ctrlDown = e.ctrlKey;
			shiftDown = e.shiftKey;
			altDown = e.altKey;
			if (_keys.length==0 &&(e.keyCode!=Keyboard.CONTROL && e.keyCode!=Keyboard.ALTERNATE && e.keyCode!=Keyboard.SHIFT)) 
			{
				if (_ctrlDown) 
				{
					_keys.push(_code4key[Keyboard.CONTROL]);
				}
				if (_altDown) 
				{
					_keys.push(_code4key[Keyboard.ALTERNATE]);
				}
				if (_shiftDown) 
				{
					_keys.push(_code4key[Keyboard.SHIFT]);
				}
			}
			var needDispatch:Boolean = false;
			if (e.keyCode!=Keyboard.CONTROL && e.keyCode!=Keyboard.ALTERNATE && e.keyCode!=Keyboard.SHIFT) 
			{
				needDispatch = true;
			}
			if (!_ctrlDown && !_shiftDown && !_altDown) 
			{
				_keys = [];
			}
			if (_keys.indexOf(_code4key[e.keyCode])<0) 
			{
				_keys.push(_code4key[e.keyCode]);
			}
			var key:String = _keys.join(",");
			trace("按下:",key);
			if (needDispatch) 
			{
				_stage.dispatchEvent(new ShortcutEvent(ShortcutEvent.SHORTCUT_EVENT, key));
			}
		}
		private function handlerKeyUp(e:KeyboardEvent):void 
		{
			ctrlDown = e.ctrlKey;
			shiftDown = e.shiftKey;
			altDown = e.altKey;
			_keys = [];
		}
		/**
		 * 当焦点为输入框的时候不抛出按键事件
		 * dont't dispatch keyboard event when stage's focus is a textfield
		 * @param	e
		 */
		private function handlerFocusIn(e:FocusEvent):void 
		{
			if (e.target is TextField) 
			{
				_disableDispatch = true;
			}else
			{
				_disableDispatch = false;
			}
		}
		private function handlerFocusOut(e:FocusEvent):void 
		{
			if (e.target is TextField) 
			{
				_disableDispatch = false;
			}
		}
		static public function get instance():ShortcutManager 
		{
			if (!_instance) 
			{
				_instance = new ShortcutManager();
			}
			return _instance;
		}
		/**当前ctrl键是否按下*/
		public function get ctrlDown():Boolean 
		{
			return _ctrlDown;
		}
		
		public function set ctrlDown(value:Boolean):void
		{
			_ctrlDown = value;
		}
		/**当前shift键是否按下*/
		public function get shiftDown():Boolean 
		{
			return _shiftDown;
		}
		
		public function set shiftDown(value:Boolean):void 
		{
			_shiftDown = value;
		}
		/**当前alt键是否按下*/
		public function get altDown():Boolean 
		{
			return _altDown;
		}
		
		public function set altDown(value:Boolean):void 
		{
			_altDown = value;
		}
	}

}