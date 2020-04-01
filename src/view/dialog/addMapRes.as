package view.dialog 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import game.data.DataManager;
	import game.library.LibraryManager;
	import game.tools.BrowseTools;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogAddMapResUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class addMapRes extends DialogAddMapResUI 
	{
		public function addMapRes() 
		{
			super();
			btn_add.clickHandler = new Handler(add);
			btn_browse.clickHandler = new Handler(function ():void 
			{
				var fileFilter:FileFilter = new FileFilter("jpg", "*.jpg");
				var file:File = File.desktopDirectory;
				file.browseForOpen("选择地图资源",[fileFilter]);
				file.addEventListener(Event.SELECT,function (e:Event):void 
				{
					txt_path.text = file.nativePath;
					txt_name.text = file.name.replace(".jpg","");
				});
			});
		}
		public function add():void 
		{
			if (txt_path.text=="") 
			{
				App.log.warn("轻选择需要导入的地图素材");
				return;
			}
			var file:File = File.applicationDirectory.resolvePath(txt_path.text);
			if (file.exists) 
			{
				var fileName:String = txt_name.text;
				if (fileName=="") 
				{
					fileName = file.name.replace(".jpg", "");
				}
				var path:String = ProjectConfig.libraryPath + "地图/" +fileName;
				var imgFile:File = File.applicationDirectory.resolvePath( path+ "."+file.extension);
				if (imgFile.exists) 
				{
					App.log.warn("存在地图文件:",file.name,"正在覆盖...");
				}
				file.copyTo(imgFile, true);
				var xml:XML = new XML("<assets/>");
				xml.@catalog = 5;
				xml.@id = fileName;
				xml.@name = fileName;
				DataManager.library.addResNode(xml);
				App.log.warn("地图添加成功");
			}else{
				App.log.warn("不存在地图素材",txt_path.text);
			}
		}
	}

}