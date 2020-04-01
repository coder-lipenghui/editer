package view.window 
{
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import editor.menu.menu;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FileListEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import morn.core.components.Box;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	import view.auto.window.WindowAssetsUI;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class Assets extends WindowAssetsUI 
	{
		private var rootXML:XML = new XML("<root/>");
		public function Assets() 
		{
			super();
			addEventListener(MouseEvent.CLICK,function (e:Event):void
			{
				dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
			});
			TreeAssets.array = [];
			this.addEventListener(Event.COMPLETE, handlerListComplete);
			TreeAssets.renderHandler = new Handler(handlerTreeRender);
			TreeAssets.list.selectHandler = new Handler(handlerTreeSelected);
			TreeAssets.list.rightClickHandler = new Handler(handleShowListMenu);
			init();
		}
		public function init():void 
		{
			var path:String = ProjectConfig.assetsPath;
			var rootXML:XML = new XML("<root/>");
			var t1:int = getTimer();
			var listArray:Array = getDirectoryList(path);
			for each(var xml:XML in listArray)
			{
				rootXML.appendChild(xml);
			}
			var t2:int = getTimer();
			trace("资源目录读取耗时：",t2-t1,"秒");
			TreeAssets.xml = rootXML;
		}
		private function handlerListComplete(e:Event):void 
		{
			TreeAssets.xml = rootXML;
		}
		private function getDirectoryList(path:String):Array 
		{
			var file:File = File.applicationDirectory.resolvePath(path);
			if (file.exists)
			{
				var list:Array = file.getDirectoryListing();
				var folders:Array = [];
				var files:Array = [];
				for each (var child:File in list) 
				{
					var xml:XML = null;
					if (child.isDirectory) 
					{
						xml = new XML("<folder name='" + child.name+"' hasChild='true' path='" + child.nativePath + "'/>");
						folders.push(xml);
					}else{
						xml = new XML("<file name='" + child.name+"' path='" + child.nativePath + "'/>");
						files.push(xml);
					}
				}
				return folders.concat(files);
			}
			return [];
		}
		private function handlerTreeRender(item:Box,index:int):void 
		{
			var obj:Object = TreeAssets.array[index];
			if (obj)
			{
				var txt_name:Label = item.getChildByName("txt_name") as Label;
				txt_name.text = obj.name;
			}else{
				item.remove();
			}
		}
		private function handlerTreeSelected(index:int):void 
		{
			var obj:Object = TreeAssets.array[index];
			TreeAssets.selectedItem
			if (obj&& obj.hasChild) 
			{
				targetXml(obj);
			}
		}
		private function targetXml(obj:Object):void 
		{
			var childXML:Array=getDirectoryList(obj.path);
			var treeXML:XML = TreeAssets.xml;
			function analyseXML(object:Object,rootXML:XML):void 
			{
				var treeXMLList:XMLList = rootXML.children();
				for (var i:int = 0; i< treeXMLList.length(); i++) 
				{
					var xml:XML = treeXMLList[i] as XML;
					if (xml.@path==object.path)
					{
						for each(var child:XML in childXML)
						{
							xml.appendChild(child);
						}
						break;
					}else{
						if (xml.children()) 
						{
							analyseXML(object,xml);
						}
					}
				}
			}
			analyseXML(obj,treeXML);
			TreeAssets.xml = treeXML;
		}
		private function handleShowListMenu(index:int):void 
		{
			var obj:Object = TreeAssets.array[index];
			if (obj) 
			{
				var m1:menu = new menu("删除", EditorEvent.CONTEXT_DELETE, obj, null);
				var m2:menu = new menu("改名", EditorEvent.CONTEXT_RENAME, obj, null);
				var menus:Array  = [m1,m2];
				if (obj.hasChild) 
				{
					var m3:menu = new menu("新增目录", EditorEvent.CONTEXT_ADD_FOLDER, obj, null);
					var m4:menu = new menu("新增文件", EditorEvent.CONTEXT_ADD_FILE, obj, null);
					
					menus.insertAt(0,m3);
					menus.insertAt(1, m4);
				}
				EditorManager.contextMenu.show(menus, null);
			}
		}
		override protected function resetPosition():void 
		{
			super.resetPosition();
			//if (clip_focus.index==1) 
			//{
				//showBorder(0xCFDDFA, 0.5);
			//}
		}
	}
}