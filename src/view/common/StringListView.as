package view.common 
{
	import flash.display.DisplayObject;
	import morn.core.components.Box;
	import morn.core.components.TextInput;
	import morn.core.handlers.Handler;
	import view.auto.common.CommListViewUI;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class StringListView extends CommListViewUI 
	{
		private var _data:String = "";
		private var _separtor:String = ";";
		private var _title:String = "";
		public function StringListView() 
		{
			super();
			list_item.array = [];
			list_item.renderHandler = new Handler(hanldeRender);
			list_item.selectHandler = new Handler(handleListSelected);
		}
		private function init():void 
		{
			list_item.array = _data.split(_separtor);
		}
		override public function set dataSource(value:Object):void 
		{
			_data = String(value);
			init();
		}
		private function handleListSelected(index:int):void 
		{
			
		}
		private function hanldeRender(item:Box,index:int):void 
		{
			if (list_item.array[index]) 
			{
				var input:TextInput = item.getChildByName("txt_input") as TextInput;
				input.text = list_item.array[index];
			}
		}
		//public function get title():String 
		//{
			//return _title;
		//}
		
		//public function set title(value:String):void 
		//{
			//txt_title.text=_title = value;
		//}
		
		public function get separtor():String 
		{
			return _separtor;
		}
		
		public function set separtor(value:String):void 
		{
			_separtor = value;
		}
	}

}