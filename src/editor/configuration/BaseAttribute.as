package editor.configuration 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import view.events.AttributeChangeEvent;
	/**
	 * ...
	 * @author lee
	 */
	public class BaseAttribute extends EventDispatcher
	{
		private var _name:String = "";
		private var _values:Dictionary = new Dictionary;
		private var _keys:Array = [];
		public var group1:Array = [];
		public var group2:Array = [];
		public var displayGroup:Dictionary = new Dictionary;
		public function BaseAttribute(xml:XML=null) 
		{
			if (xml) 
			{
				_name = xml.name();
				var xmlList:XMLList = xml.children();
				for (var i:int = 0; i < xmlList.length() ; i++) 
				{
					var xa:XmlAttribute = new XmlAttribute(xmlList[i]);
					_keys.push(xa);
					if (xa.group==1) 
					{
						group1.push(xa);
					}else{
						group2.push(xa);
					}
					if (xa.defaultValue) 
					{
						setValue(xa.key,xa.defaultValue);
					}
					if (xa.dispalyGroup!="")
					{
						if (!displayGroup[xa.dispalyGroup]) 
						{
							displayGroup[xa.dispalyGroup] = [];
						}
						displayGroup[xa.dispalyGroup].push(xa);
					}
					
				}
			}
		}
		/**
		 * 从已有的对象快速创建一个新的对象出来
		 */
		public function clone(copyValue:Boolean=false):BaseAttribute 
		{
			var ba:BaseAttribute = new BaseAttribute();
			ba.name = this._name;
			ba.keys = this._keys.concat();
			ba.group1 = this.group1.concat();
			ba.group2 = this.group2.concat();
			ba.displayGroup = this.displayGroup;
			ba.values = new Dictionary;
			if (copyValue) 
			{
				for (var key:String in this.values) 
				{
					//TODO object|dictionary类型的需要改成值引用
					switch (this.values[key]) 
					{
						case "Array":
							ba.values[key] = this.values[key].concat();
							break;
						default:
						ba.values[key] = this.values[key];
					}
				}
			}
			return ba;
		}
		public function haveKey(key:String):XmlAttribute 
		{
			for (var i:int = 0; i < _keys.length; i++) 
			{
				if (key==_keys[i].key) 
				{
					return _keys[i];
				}
			}
			return null;
		}
		/**
		 * 当设置array类型的值时，除了初始化的时候使用concat形式，其他时候都直接替换。
		 * @param	key
		 * @param	value
		 */
		public function setValue(key:String,value:*):void 
		{
			if (value is Array) 
			{
				if (!_values[key])
				{
					_values[key] = [];
				}
				_values[key] = (_values[key] as Array).concat(value);
			}else {
				if (getType(key)=="array" && !(value as Array))
				{
					value = String("value").split(",");
				}else{
					_values[key] = value;
				}
			}
			dispatchEvent(new AttributeChangeEvent(AttributeChangeEvent.ATTRIBUTE_CHANGE,key,value));
		}
		public function getValue(key:String):* 
		{
			var xa:XmlAttribute = haveKey(key);
			if (xa) 
			{
				return _values[key];
			}
			return null;
		}
		public function getType(key:String):String
		{
			var xa:XmlAttribute = haveKey(key);
			if (xa) 
			{
				return xa.type;
			}
			return "unknow";
		}
		public function get values():Dictionary 
		{
			return _values;
		}
		
		public function set values(value:Dictionary):void 
		{
			_values = value;
		}
		
		public function get keys():Array 
		{
			return _keys;
		}
		
		public function set keys(value:Array):void 
		{
			_keys = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}

}