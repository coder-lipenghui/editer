package view.common 
{
	import game.data.configuration.BaseAttribute;
	import game.data.configuration.XmlAttribute;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import editor.log.Logger;
	import morn.core.components.Component;
	import view.auto.common.CommPullDownPanelUI;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import morn.core.components.Box;
	import morn.core.components.CheckBox;
	import morn.core.components.HBox;
	import morn.core.components.Label;
	import morn.core.components.TextInput;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class PulldownPanel extends CommPullDownPanelUI 
	{
		private var _attributes:Array = null;
		private var _value:BaseAttribute = null;
		private var _components:Array = new Array;
		private var _containerHeight:int = 0;
		private var _space:int = 1;
		public function PulldownPanel() 
		{
			super();
			btn_hide.clickHandler = new Handler(handleContainerState, [0]);
			btn_show.clickHandler = new Handler(handleContainerState, [1]);
		}
		/**
		 * 销毁前调用
		 */
		public function dispose():void 
		{
			//for (var key:String in _components) 
			//{
				//var component:Component = _components[key];
				//if (component as TextInput) 
				//{
					//component.removeEventListener(TextEvent.TEXT_INPUT, onTextFieldTextInput);
				//}
			//}
		}
		private function handleContainerState(vi:Boolean):void 
		{
			if (vi) 
			{
				clip_arrow.index = 1;
				btn_show.visible = false;
				btn_hide.visible = true;
				this.addChild(box_container);
				this.height = box_title.height + _containerHeight + 2;
			}else{
				clip_arrow.index = 0;
				btn_show.visible = true;
				btn_hide.visible = false;
				box_container.remove();
				this.height = box_title.height + 2;
			}
			dispatchEvent(new Event(Event.RESIZE));
		}
		public function set attributes(value:Array):void 
		{
			_attributes = value;
			var yy:int = 0;
			var hh:int = 0;
			_containerHeight = 0;
			for (var i:int = 0; i < value.length; i++) 
			{
				var hbox:XmlComponent = new XmlComponent(value[i]);
				hbox.x = 1;
				hbox.y = yy;
				yy = yy +hbox.height + _space;
				box_container.addChild(hbox);
				hh = hbox.height;
				_containerHeight += hh + space;
				_components.push(hbox);
			}
			this.height = box_title.height + _containerHeight + 2;
		}
		
		/**
		 * 设置值
		 */
		public function get value():BaseAttribute 
		{
			return _value;
		}
		
		public function set value(v:BaseAttribute):void 
		{
			_value = v;
			if (_value) 
			{
				for (var i:int = 0; i < _components.length; i++) 
				{
					(_components[i] as XmlComponent).baseAttribute = _value;
				}
			}
		}
		
		public function get space():int 
		{
			return _space;
		}
		
		public function set space(value:int):void 
		{
			_space = value;
		}
	}

}