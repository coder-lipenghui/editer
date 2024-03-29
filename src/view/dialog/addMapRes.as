package view.dialog 
{
	import editor.EditorManager;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import editor.manager.DataManager;
	import editor.manager.LibraryManager;
	import editor.tools.BrowseTools;
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
				if (txt_path.text!="") 
				{
					file = File.applicationDirectory.resolvePath(txt_path.text);
				}
				file.browseForOpen("选择地图资源",[fileFilter]);
				file.addEventListener(Event.SELECT,function (e:Event):void 
				{
					EditorManager.SaveLastPath("addMapRes",file.parent.nativePath)
					txt_path.text = file.nativePath;
					txt_name.text = file.name.replace(".jpg","");
				});
			});
			txt_path.text = EditorManager.GetLastPath("addMapRes");
		}
		//private function parseName():void 
		//{
			//var tmp:Array = txt_path.text.split("/");
			//if (tmp.length>0) 
			//{
				//var name:String = tmp[tmp.length - 1];	
				//txt_name.text = file.name.replace(".jpg","");
			//}
		//}
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