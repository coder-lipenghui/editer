package editor.events 
{
	import editor.configuration.BaseAttribute;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class AttributeEvent extends Event 
	{
		public static var SELECTED:String = "selected";
		public static var RES_ACTION_SELECTED:String = "res_action_selected";
		private var _data:*= null;
		private var _attribute:BaseAttribute = null;
		public function AttributeEvent(type:String,attribute:BaseAttribute,data:*=null,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_data = data;
			_attribute = attribute;
		}
		override public function clone():flash.events.Event 
		{
			return new AttributeEvent(type,_attribute,_data,bubbles, cancelable);
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
		public function get attribute():BaseAttribute 
		{
			return _attribute;
		}
		
		public function set attribute(value:BaseAttribute):void 
		{
			_attribute = value;
		}
	}

}