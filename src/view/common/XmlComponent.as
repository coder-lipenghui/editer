package view.common 
{
	import game.data.configuration.BaseAttribute;
	import game.data.configuration.XmlAttribute;
	import editor.events.EditorEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.utils.Dictionary;
	import morn.core.components.Box;
	import morn.core.components.CheckBox;
	import morn.core.components.Component;
	import morn.core.components.Label;
	import morn.core.components.TextArea;
	import morn.core.components.TextInput;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class XmlComponent extends Box 
	{
		private var _xmlAttribute:XmlAttribute;
		private var _baseAttribute:BaseAttribute;
		private var _label:Label=new Label;
		private var _component:*= null;
		public function XmlComponent(xa:XmlAttribute) 
		{
			//this.mouseEnabled = true;
			super();
			_xmlAttribute = xa;
			_label.width = 80;
			build();
		}
		private function build():void 
		{
			_label.name = "xc_" + _xmlAttribute.key;
			_label.text = _xmlAttribute.name;
			_label.toolTip = _xmlAttribute.tips;
			_label.mouseEnabled = true;
			_label.color = "0xBDBDBD";
			this.addChild(_label);
			var disabled:Boolean = _xmlAttribute.disabled == "true"?true:false;
			switch (_xmlAttribute.type) 
			{
				case "int":
				case "string":
				case "array":
				case "number":
					var input:TextInput = new TextInput(_xmlAttribute.defaultValue,"png.comp.textinput");
					input.name = _xmlAttribute.key;
					input.width = 115;
					input.addEventListener(Event.CHANGE, handleInputTextChange);
					input.color = "0xe0e0e0";
					_component = input;
					break;
				case "bool":
				case "check":
					var check:CheckBox = new CheckBox("png.comp.checkbox");
					check.clickHandler = new Handler(onCheckSelected);
					check.name = _xmlAttribute.key;
					_component = check;
					break;
				case "slist":
					var slist:StringListView = new StringListView();
					slist.separtor = _xmlAttribute.separtor;
					slist.name = _xmlAttribute.key;
					slist.y = 21;
					_component = slist;
					break;
				case "textarea":
					var textarea:TextArea = new TextArea();
					textarea.skin = "png.comp.textinput";
					textarea.width = 100;
					textarea.height = 100;
					textarea.name = _xmlAttribute.key;
					_component = textarea;
					break;
				case "option":
					break;
			}
			
			if (_component) 
			{
				_component.disabled = disabled;
				_component.x = 81;
				if (_component as StringListView) 
				{
					_component.x = 10;
				}
				this.addChild(_component);
			}
			
		}
		private function handleInputTextChange(e:Event):void 
		{
			if (_baseAttribute) 
			{
				_baseAttribute.setValue(_component.name, e.target.text);
				dispatchEvent(new EditorEvent(EditorEvent.DATA_REFRESH, _baseAttribute,null,true));
			}
		}
		private function onCheckSelected():void 
		{
			if (_baseAttribute) 
			{
				_baseAttribute.setValue(_component.name,_component.selected);
			}
		}
		public function get xmlAttribute():XmlAttribute 
		{
			return _xmlAttribute;
		}
		
		public function set xmlAttribute(value:XmlAttribute):void 
		{
			_xmlAttribute = value;
		}
		
		public function get baseAttribute():BaseAttribute 
		{
			return _baseAttribute;
		}
		
		public function set baseAttribute(value:BaseAttribute):void 
		{
			_baseAttribute = value;
			//TODO 设置值
			if (_baseAttribute && _component) 
			{
				for(var key:String in _baseAttribute.values)
				{
					if (_component.name==key) 
					{
						_component.dataSource = _baseAttribute.getValue(key);
						break;
					}
				}
			}
		}
		
	}

}