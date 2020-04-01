package editor.menu 
{
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class menu 
	{
		private var _name:String = "";
		private var _data:*= null;
		private var _callBack:Function = null;
		private var _event:String = null;
		public function menu(name:String,event:String,data:*,callBack:Function) 
		{
			this._name = name;
			this._event = event;
			this._data = data;
			this._callBack = callBack;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
		public function get callBack():Function 
		{
			return _callBack;
		}
		
		public function set callBack(value:Function):void 
		{
			_callBack = value;
		}
		
		public function get event():String 
		{
			return _event;
		}
		
		public function set event(value:String):void 
		{
			_event = value;
		}
		
	}

}