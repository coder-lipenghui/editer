package view.common 
{
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import editor.menu.menu;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import morn.core.components.Box;
	import morn.core.components.Clip;
	import morn.core.components.Image;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	import view.auto.common.CommLibrayPullDownUI;
	/**
	 * ...
	 * @author ...
	 */
	public class LibraryPullDown extends CommLibrayPullDownUI
	{
		public static var LIBRARY_PULL_DOWN_SHOW:String = "library_pull_down_show";
		public static var LIBRARY_PULL_DOWN_HIDE:String = "library_pull_down_hide";
		private var _myVisible:Boolean = true;
		private var _listNumber:int = 0;
		private var _index:int =-1;
		private var _catalogId:int =-1;
		public function LibraryPullDown(idx:int,catalogId:int,listNum:int) 
		{
			_index = idx;
			_listNumber = listNum;
			_catalogId = catalogId;
			btn_hide.clickHandler = new Handler(handleContainerState, [0]);
			btn_show.clickHandler = new Handler(handleContainerState, [1]);
			
			btn_show.addEventListener(MouseEvent.RIGHT_CLICK, handleTitleRightClick);
			btn_hide.addEventListener(MouseEvent.RIGHT_CLICK, handleTitleRightClick);
			
			treeLibrary.array = [];
			treeLibrary.renderHandler = new Handler(handlerTreeRender);
			treeLibrary.rightClickHandler = new Handler(handlerTreeRightClick);
			treeLibrary.mouseHandler = new Handler(handlerMouseAction);
			
			handleContainerState(false);
			this.addEventListener(Event.RESIZE, handleResize);
		}
		public function clean():void 
		{
			
		}
		public function setData(name:String,dic:Array):void 
		{
			txt_title.text = name;
			if (dic) 
			{
				treeLibrary.array = dic;
			}
			if (_listNumber==0) 
			{
				box_title.remove();
				treeLibrary.top = 0;
				treeLibrary.bottom = 25;
				myVisible = true;
				handleContainerState(true);
			}
		}
		private function handleContainerState(vi:Boolean):void 
		{
			myVisible = vi;
			
			dispatchEvent(new Event(Event.RESIZE));
			dispatchEvent(new Event(vi?LIBRARY_PULL_DOWN_SHOW:LIBRARY_PULL_DOWN_HIDE,true));
		}
		private function handlerTreeRender(item:Box,index:int):void 
		{
			var txt_name:Label = item.getChildByName("txt_name") as Label;
			var folder:Clip = item.getChildByName("folder") as Clip;
			if (!item.dataSource) 
			{
				return;
			}
			var xml:XML = item.dataSource as XML;
			folder.index = 2;
			var id:String = xml.@id;
			var catalog:String = xml.@catalog;
			if (id && id!="" && catalog!="5") 
			{
				txt_name.text=xml.@name+"("+id+")";
			}else {
				txt_name.text = xml.@name;
			}
			if (xml.@unuse=="true") 
			{
				txt_name.text = txt_name.text+"<font color='#ffff66'>[未使用]</font>";
			}
		}
		private function handlerMouseAction(e:MouseEvent,index:int):void
		{
			if (e.type==MouseEvent.DOUBLE_CLICK) 
			{
				selectItem();
			}
			if (e.type==MouseEvent.MOUSE_DOWN)
			{
				var obj:XML = treeLibrary.array[index];
				var _catalog:int = int(obj.@catalog);
				if (_catalog==3) 
				{
					var resid:int = int(obj.@id);
					var dragImg:Image = new Image("png.comp.btn_file");
					App.drag.doDrag(e.currentTarget as Sprite,dragImg as Sprite,obj);
				}
			}
		}
		/**
		 * 按Enter键后展开/收起资源树
		 */
		public function selectItem():void 
		{
			var selectedIndex:int = treeLibrary.selectedIndex;
			var obj:XML = treeLibrary.array[selectedIndex];
			var _catalog:int = int(obj.@catalog);
			if (_catalog==5) 
			{
				App.stage.dispatchEvent(new EditorEvent(EditorEvent.CONTEXT_MAP_EDIT, obj, null, true));
			}else if (_catalog==10 ||_catalog==11 ||_catalog==12 ||_catalog==13)
			{
				App.stage.dispatchEvent(new EditorEvent(EditorEvent.CONTEXT_EFFECT_EDIT, obj, null, true));
			}
			else{
				App.stage.dispatchEvent(new EditorEvent(EditorEvent.CONTEXT_RES_EDIT, obj, null, true));
			}
		}
		private function handleTitleRightClick(e:Event):void 
		{
			var m1:menu = new menu("导出", EditorEvent.CONTEXT_RES_EXPORT_CATALOG, _catalogId, null);
			EditorManager.contextMenu.show([m1]);
		}
		/**
		 * 右键菜单
		 * @param	index
		 */
		private function handlerTreeRightClick(index:int):void 
		{
			var obj:Object = treeLibrary.array[index];
			if (obj) 
			{
				var m1:menu = new menu("删除", EditorEvent.CONTEXT_RES_DELETE, obj, null);
				var m2:menu = new menu("改名", EditorEvent.CONTEXT_RENAME, obj, null);
				
				var menus:Array = [m1, m2];
				if (!obj.isDirectory || obj.hideChildren) 
				{
					var m4:menu = new menu("编辑", EditorEvent.CONTEXT_RES_EDIT, obj, null);
					var exprotType:String = EditorEvent.CONTEXT_RES_EXPORT;
					if (obj as XML && obj.@catalog=="5") 
					{
						m4 = new menu("编辑", EditorEvent.CONTEXT_MAP_EDIT, obj, null);
						exprotType = EditorEvent.CONTEXT_MAP_EXPORT;
					}
					else if (obj.catalog=="5") 
					{
						m4 = new menu("编辑", EditorEvent.CONTEXT_MAP_EDIT, obj, null);
						exprotType = EditorEvent.CONTEXT_MAP_EXPORT;
					}
					var m3:menu = new menu("导出", exprotType, obj,null);
					menus.push(m3);
					menus.insertAt(0,m4);
				}
				EditorManager.contextMenu.show( menus);
			}
		}
		
		public function get myVisible():Boolean 
		{
			return _myVisible;
		}
		
		public function set myVisible(value:Boolean):void 
		{
			_myVisible = value;
			if (_myVisible) 
			{
				clip_arrow.index = 1;
				btn_show.visible = false;
				btn_hide.visible = true;
				this.addChild(treeLibrary);
			}else{
				clip_arrow.index = 0;
				btn_show.visible = true;
				btn_hide.visible = false;
				treeLibrary.remove();
			}
			handleResize(null);
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		public function get catalogId():int 
		{
			return _catalogId;
		}
		
		public function set catalogId(value:int):void 
		{
			_catalogId = value;
		}
		private function handleResize(e:Event):void 
		{
			if (stage) 
			{
				if (_myVisible) 
				{
					this.height = stage.stageHeight - (box_title.height * _listNumber) - 50;
					treeLibrary.height = this.height - treeLibrary.top;
					trace();
				}else{
					this.height = box_title.height;
					treeLibrary.height = this.height - treeLibrary.top;
				}
			}
		}
	}
}