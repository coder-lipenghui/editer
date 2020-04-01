package view.window 
{
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import flash.events.TextEvent;
	import morn.core.handlers.Handler;
	import view.auto.window.WindowLogUI;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class Log extends WindowLogUI 
	{
		private var _filters:Array = [];
		private var _msgs:Array = [];
		private var _canScroll:Boolean = false;
		public function Log() 
		{
			super();
			txt_filters.addEventListener(TextEvent.TEXT_INPUT, handlerFilter);
			btn_clean.clickHandler = new Handler(function ():void 
			{
				_msgs = [];
				txt_log.text = "";
			});
		}
		public function handlerLogMsg(e:EditorEvent):void 
		{
			_msgs.push(e.data);
			refresh(e.data as String);
		}
		public function clear():void {
			_msgs.length = 0;
			//_textField.htmlText = "";
		}
		
		/**信息*/
		public function info(... args):void {
			print("info", args, 0x3EBDF4);
		}
		
		/**消息*/
		public function echo(... args):void {
			print("echo", args, 0x00C400);
		}
		
		/**调试*/
		public function debug(... args):void {
			print("debug", args, 0xdddd00);
		}
		
		/**错误*/
		public function error(... args):void {
			print("error", args, 0xFF4646);
		}
		
		/**警告*/
		public function warn(... args):void {
			print("warn", args, 0xFFFF80);
		}
		
		public function print(type:String, args:Array, color:uint):void {
			//trace(args.join(" "));
			var msg:String = "<p><font color='#" + color.toString(16) + "'><b>[" + type + "]</b></font> <font color='#EEEEEE'>" + args.join(" ") + "</font></p>";
			if (_msgs.length > 500) {
				_msgs.length = 0;
			}
			
			_msgs.push(msg);
			refresh(msg);
			//EditorManager.stage.dispatchEvent(new EditorEvent(EditorEvent.LOG_REFRESH,msg));
		}
		/**根据过滤刷新显示*/
		private function refresh(newMsg:String):void {
			var msg:String = "";
			if (newMsg != null) {
				if (isFilter(newMsg)) {
					msg = (txt_log.text || "") + newMsg;
					txt_log.text = msg;
				}
			} else {
				for each (var item:String in _msgs) {
					if (isFilter(item)) {
						msg += item;
					}
				}
				txt_log.text = msg;
			}
			if (ck_scroll.selected) {
				txt_log.scrollTo(txt_log.maxScrollV);
			}
		}
		private function handlerFilter(e:TextEvent):void {
			_filters = Boolean(txt_filters.text) ? txt_filters.text.split(",") : [];
			refresh(null);
		}
		/**是否是筛选属性*/
		private function isFilter(msg:String):Boolean {
			if (_filters.length < 1) {
				return true;
			}
			for each (var item:String in _filters) {
				if (msg.indexOf(item) > -1) {
					return true;
				}
			}
			return false;
		}
	}

}