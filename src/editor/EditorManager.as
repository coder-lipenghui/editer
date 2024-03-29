package editor 
{
	import editor.manager.ShortcutManager;
	import flash.filesystem.File;
	import editor.manager.ActionManager;
	import editor.manager.BinaryManager;
	import editor.manager.DataManager;
	import editor.configuration.BaseAttribute;
	import editor.events.EditorEvent;
	import editor.menu.EditorContextMenu;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.ui.Keyboard;
	import editor.manager.LibraryManager;
	import morn.core.handlers.Handler;
	import view.work;
	import view.dialog.welcome;
	/**
	 * 视图管理
	 * @author 3464285@gmail.com
	 */
	public class EditorManager
	{
		public static var stage:Stage = null;
		public static var contextMenu:EditorContextMenu = new EditorContextMenu;
		public static var focus:*= null; //编辑器中可操作的对象
		public static var shiftDown:Boolean = false;
		public static var altDown:Boolean = false;
		public static var ctrlDown:Boolean = false;
		
		//public static var shortcut:ShortcutManager = new ShortcutManager();
		public function EditorManager()
		{
			
		}
		public static function init(main:Sprite):void 
		{
			stage = main.stage;
			contextMenu.stage = stage;
			stage.addEventListener(EditorEvent.CONTEXT_DELETE, hanldeContextMenuSelected);
			stage.addEventListener(EditorEvent.CONTEXT_COPY, hanldeContextMenuSelected);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKey);
			stage.addEventListener(EditorEvent.DATA_REFRESH, handleDataRefesh);
			
			ShortcutManager.instance.init(stage);
			DataManager.init();
			
			var file:File = File.applicationDirectory.resolvePath("projects.xml");
			var temp:welcome = new welcome();
			if (file.exists) 
			{
				temp.readLastOpenProject();
			}else{
				App.dialog.show(temp,true);
			}
		}
		private static function hanldeContextMenuSelected(e:EditorEvent):void 
		{
			if (e.data as BaseAttribute) 
			{
				handleDataAction(e.type,e.data as BaseAttribute,e.callBack);
			}
		}
		private static function handleDataAction(type:String,ba:BaseAttribute,callBack:Handler=null):void 
		{
			switch (type) 
			{
				case EditorEvent.CONTEXT_DELETE:
					DataManager.delBaseAttribute(ba,callBack);
					break;
				case EditorEvent.CONTEXT_COPY:
					DataManager.copyAndPasteBaseAttribute(ba, callBack);
					break;
				case EditorEvent.CONTEXT_PASTE:
					break;
				case EditorEvent.CONTEXT_SHOW:
					break;
			}
		}
		private static function handleFileAction():void
		{
			
		}
		private static function handleDataRefesh(e:EditorEvent):void 
		{
			work.instance.refesh();
		}
		private static function handleKey(e:KeyboardEvent):void 
		{
			var down:Boolean = e.type == KeyboardEvent.KEY_DOWN?true:false;
			if (e.keyCode==Keyboard.ALTERNATE) 
			{
				altDown = down;
			}
			if (e.keyCode==Keyboard.CONTROL) 
			{
				ctrlDown = down;
			}
			if (e.keyCode==Keyboard.SHIFT) 
			{
				shiftDown = down;
			}
		}
		public static function GetLastPath(type:String):String 
		{
			var file:File = File.applicationDirectory.resolvePath("paths.xml");
			var path:String = "";
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
					if (String(item.@key)==type)
					{
						path = item.@path;
						break;
					}
				}
			}
			return path;
		}
		public static function SaveLastPath(type:String,path:String):void 
		{
			var file:File =File.applicationDirectory.resolvePath(File.applicationDirectory.resolvePath("paths.xml").nativePath);
			var child:String = "<item key=\"" + type+"\" path=\"" + path + "\"/>";
			var xml:XML = null;
			var fs:FileStream = new FileStream();
			if (file.exists) 
			{
				fs.open(file, FileMode.READ);
				var xmlString:String = fs.readMultiByte(fs.bytesAvailable, "utf-8");
				fs.close();
				xml = new XML(xmlString);
				var xmllist:XMLList = xml.children();
				var founded:Boolean = false;
				for (var i:int = 0; i < xmllist.length(); i++) 
				{
					var item:XML = xmllist[i] as XML;
					if (String(item.@key)==type)
					{
						item.@path = path;
						founded = true;
						break;
					}
				}
				if (!founded) 
				{
					xml.appendChild(new XML(child));
				}
			}else 
			{
				xml = new XML("<paths>" + child + "</paths>");
			}
			fs = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(xml.toString(), "utf-8");
			fs.close();
		}
	}
}