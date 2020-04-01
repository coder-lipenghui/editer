package editor.menu 
{
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import flash.display.DisplayObject;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class EditorContextMenu
	{
		private var contextMenu:NativeMenu = new NativeMenu();
		private var _nativeMenus:Array = [];
		//private var _funcs:Array = [];
		private var _stage:Stage = null;
		private var _offset:Point = new Point(10, 10);
		//private var _focus:*= null;
		public function EditorContextMenu() 
		{
			super();
			contextMenu.addEventListener(Event.SELECT, handlerMenuSelected);
		}
		/**
		 * 显示右键菜单
		 * 示例:
		 * 		show(data,["增加","","修改","删除","前往"],[function(){trace("增加完成");}],new Point(10,10))
		 * @param	focus 目标对象
		 * @param	menus 菜单列表,空字符串则为横线 [<string>]
		 * @param	callbacks 菜单回调[<Function>]
		 * @param	offset 偏移位置
		 */
		public function show(menus:Array,offset:Point=null):void 
		{
			if (offset) 
			{
				_offset = offset;
			}
			//_focus= focus;
			contextMenu.removeAllItems();
			
			_nativeMenus = menus;
			
			//_funcs = callbacks;
			
			for (var i:int = 0; i < menus.length; i++)
			{
				var m:menu = menus[i] ;
				var item:NativeMenuItem = new NativeMenuItem(m.name, m.name == ""?true:false);
				
				contextMenu.addItem(item);
			}
			
			contextMenu.display(stage, stage.mouseX+_offset.x, stage.mouseY+_offset.y);
		}
		private function handlerMenuSelected(event:Event):void 
		{
			var currentItem:NativeMenuItem = event.target as NativeMenuItem;
			
			var index:int = contextMenu.getItemIndex(currentItem);
			var m:menu = _nativeMenus[index];
			_stage.dispatchEvent(new EditorEvent(m.event,m.data,m.callBack is Function?new Handler(m.callBack):null,true));
		}
		
		public function get stage():Stage 
		{
			return _stage;
		}
		
		public function set stage(value:Stage):void 
		{
			_stage = value;
		}
	}

}