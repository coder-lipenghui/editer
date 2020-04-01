package editor.log 
{
	import editor.EditorManager;
	import editor.events.EditorEvent;
	/**
	 * ...
	 * @author lee
	 */
	public class Logger
	{
		private static var _msgs:Array = [];
		
		public function Logger() 
		{
			
		}
		/**清理所有日志*/
		public static function clear():void {
			_msgs.length = 0;
			//_textField.htmlText = "";
		}
		
		/**信息*/
		public static function info(... args):void {
			print("info", args, 0x3EBDF4);
		}
		
		/**消息*/
		public static function echo(... args):void {
			print("echo", args, 0x00C400);
		}
		
		/**调试*/
		public static function debug(... args):void {
			print("debug", args, 0xdddd00);
		}
		
		/**错误*/
		public static function error(... args):void {
			print("error", args, 0xFF4646);
		}
		
		/**警告*/
		public static function warn(... args):void {
			print("warn", args, 0xFFFF80);
		}
		
		private static function print(type:String, args:Array, color:uint):void {
			trace(args.join(" "));
			var msg:String = "<p><font color='#" + color.toString(16) + "'><b>[" + type + "]</b></font> <font color='#EEEEEE'>" + args.join(" ") + "</font></p>";
			if (_msgs.length > 500) {
				_msgs.length = 0;
			}
			_msgs.push(msg);
			//EditorManager.stage.dispatchEvent(new EditorEvent(EditorEvent.LOG_REFRESH,msg));
		}
	}

}