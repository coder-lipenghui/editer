package view.dialog 
{
	import editor.events.ShortcutEvent;
	import editor.manager.ShortcutManager;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import morn.core.components.Box;
	import morn.core.components.Button;
	import morn.core.components.Label;
	import morn.core.components.TextInput;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogShortcutUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class shortcut extends DialogShortcutUI 
	{
		private var defShortcutList:Array = [];
		private var shortcutList:Array = [];
		private var currAction:String = "";
		private var currSelected:String = "";
		public function shortcut() 
		{
			App.stage.addEventListener(ShortcutEvent.SHORTCUT_EVENT, handlerShortcut);
			list_shortcut.renderHandler = new Handler(handlerRender);
			btn_ok.clickHandler = new Handler(save);
			init();
		}
		override public function close(type:String = null):void 
		{
			super.close(type);
			App.stage.removeEventListener(ShortcutEvent.SHORTCUT_EVENT, handlerShortcut)
		}
		public function init():void 
		{
			var file:File = File.applicationDirectory.resolvePath("shortcut.xml");
			if (file.exists) 
			{
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var xmlString:String=fs.readMultiByte(fs.bytesAvailable, "utf-8");
				fs.close();
				var xml:XML = new XML(xmlString);
				
				
				var xmllist:XMLList = xml.children();
				for (var i:int = 0; i < xmllist.length(); i++) 
				{
					var item:XML = xmllist[i] as XML;
					shortcutList.push(item);
					trace("===>>>>",item.toXMLString());
					defShortcutList.push(new XML(item.toXMLString()));
				}
				list_shortcut.array = shortcutList;
				list_shortcut.selectedIndex = 0;
			}
		}
		public function save():void 
		{
			if (btn_ok.label=="保存") 
			{
				if (currSelected!="") 
				{
					if (ShortcutManager.instance.hasOwnProperty(currAction))
					{
						ShortcutManager.instance[currAction] = currSelected;
					}
					var newXML:XML = new XML("<shortcut/>");
					for (var i:int = 0; i < shortcutList.length; i++) 
					{
						newXML.appendChild(shortcutList[i]);
					}
					var file:File = new File(File.applicationDirectory.resolvePath("shortcut.xml").nativePath);
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.WRITE);
					fileStream.writeMultiByte(newXML.toXMLString(), "utf-8");
					fileStream.close();
					fileStream = null;
					App.log.info("快捷键保存成功");
				}
				btn_ok.label = "编辑";
				currAction = "";
				currSelected = "";
			}else
			{
				var item:XML = shortcutList[list_shortcut.selectedIndex];
				btn_ok.label = "保存";
				currAction = String(item.@target);
			}
		}
		public function handlerRender(box:Box,index:int):void 
		{
			if (shortcutList[index]) 
			{
				var item:XML = shortcutList[index];
				var txt_key:TextInput = box.getChildByName("txt_key") as TextInput;
				var txt_name:Label = box.getChildByName("txt_name") as Label;
				txt_key.text = String(item.@key);
				txt_name.text = String(item.@desp);
			}
		}
		private function handlerShortcut(e:ShortcutEvent):void 
		{
			if (currAction!="")
			{
				var tmp:Array = ["F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12"];
				var key:String = e.key;	
				//var selected:String = "";
				if (key.indexOf("ctrl")>=0 || key.indexOf("shift")>=0) 
				{
					if (key.indexOf(",")>=0) 
					{
						currSelected = key;
					}
				}
				else if ((tmp.indexOf(key)>=0))
				{
					currSelected = key;
				}
				if (currSelected!="") 
				{
					checkRepeat();
					shortcutList[list_shortcut.selectedIndex].@key = currSelected;
					list_shortcut.refresh();
				}
			}
			e.stopPropagation();
		}
		public function checkRepeat():void 
		{
			for (var i:int = 0; i < shortcutList.length; i++) 
			{
				var item:XML = shortcutList[i];
				var def:XML = defShortcutList[i];
				if (item.@key==currSelected) 
				{
					item.@key = "";
				}
				if (item.@key=="" ) 
				{
					if (def.@key != currSelected)
					{
						item.@key = def.@key;	
					}
				}
			}
			list_shortcut.refresh();
		}
	}
}