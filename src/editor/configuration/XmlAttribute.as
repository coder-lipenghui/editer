package editor.configuration 
{
	/**
	 * ...
	 * @author lee
	 */
	public class XmlAttribute 
	{
		private var _key:String = "";
		private var _type:String = "";
		private var _group:int = 1;
		private var _tips:String = "";
		private var _name:String = "";
		private var _separtor:String = ";";
		private var _defaultValue:*= null;
		private var _disabled:String = "false";
		private var _xml:XML = null;
		
		private var _dispalyGroup:String = "1基础";
		public function XmlAttribute(xml:XML=null) 
		{
			if (xml) 
			{
				_xml = xml;
				_key = String(xml.@key);
				_name = String(xml.@name);
				_tips = String(xml.@tips);
				_type = String(xml.@type);
				
				var g:String = String(xml.@group);
				if (value != "") _group = int(g);
				
				var value:*= String(xml.attribute('default'));
				if (value != "") defaultValue = xml.attribute('default');
				
				var dg:String = String(xml.@displayGroup);
				if (dg != "") _dispalyGroup = dg;
				
				var sp:String = String(xml.@separtor);
				if (sp != "")_separtor = sp;
				
				var dis:String = String(xml.@disabled);
				if (dis != "") _disabled = dis;
			}
		}
		
		public function get key():String 
		{
			return _key;
		}
		
		public function set key(value:String):void 
		{
			_key = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get group():int 
		{
			return _group;
		}
		
		public function set group(value:int):void 
		{
			_group = value;
		}
		
		public function get tips():String 
		{
			return _tips;
		}
		
		public function set tips(value:String):void 
		{
			_tips = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get defaultValue():* 
		{
			return _defaultValue;
		}
		
		public function set defaultValue(value:*):void 
		{
			switch (_type) 
			{
				case "textarea":
				case "string":
					value = String(value);
					break;
				case "int":
					value = int(value);
					break;
				case "bool":
					value = String(value) == "true"?true:false;
					break;
				case "array":
					value = String(value).split(",");
					break;
				default:
					value = String(value);
			}
			_defaultValue = value;
		}
		
		public function get dispalyGroup():String 
		{
			return _dispalyGroup;
		}
		
		public function set dispalyGroup(value:String):void 
		{
			_dispalyGroup = value;
		}
		
		public function get separtor():String 
		{
			return _separtor;
		}
		
		public function set separtor(value:String):void 
		{
			_separtor = value;
		}
		
		public function get disabled():String 
		{
			return _disabled;
		}
		
		public function set disabled(value:String):void 
		{
			_disabled = value;
		}
		
	}

}