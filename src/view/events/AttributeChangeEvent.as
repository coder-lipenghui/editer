package view.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AttributeChangeEvent extends Event 
	{
		public static const ATTRIBUTE_CHANGE:String = "ATTRIBUTE_CHANGE";
		private var _attribute:String = "";
		private var _value:*= null;
		public function AttributeChangeEvent(type:String,attribute:String="",value:*=null,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_attribute = attribute;
			_value = value;
			super(type, bubbles, cancelable);
		}
		override public function clone():flash.events.Event
		{
			return new AttributeChangeEvent(type,_attribute,_value,bubbles, cancelable);
		}
		
		public function get attribute():String 
		{
			return _attribute;
		}
		
		public function get value():* 
		{
			return _value;
		}
		
	}

}