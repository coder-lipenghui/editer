package view.dialog 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogConverDirUI;
	
	/**
	 * ...
	 * @author conlinLee
	 */
	public class converDir extends DialogConverDirUI 
	{
		private var _folderPath:String = "";
		private var _enabled:Boolean = true;
		private var _files:Array = null;
		private var _needDelFrame:Array = null;
		private var _dirCount:int = 0;
		private var _imgNum:int = 0;
		private static var _instance:converDir = null;
		public function converDir() 
		{
			super();
			btn_select.clickHandler = new Handler(handlerSelectFolder)
			btn_start.clickHandler = new Handler(handlerDelResource);
		}
		private function handlerSelectFolder():void 
		{
			var folder:File = null;
			if (txt_file.text!="")
			{
				folder = File.applicationDirectory.resolvePath(txt_file.text);
			}else {
				folder=File.applicationDirectory;
			}
			folder.browseForDirectory("选择资源文件夹");
			folder.addEventListener(Event.SELECT, handlerOpenFolder);
			
			function handlerOpenFolder(e:Event):void 
			{
				_folderPath = txt_file.text = folder.nativePath;
			}
		}
		private function handlerDelResource():void
		{
			var source:Array = [];
			if (ck_batch.selected) 
			{
				var tmp:File = File.applicationDirectory.resolvePath(txt_file.text);
				if (tmp.isDirectory) 
				{
					source = tmp.getDirectoryListing();
				}else{
					App.log.error("目标路径不是文件夹");
				}
			}else{
				source.push(File.applicationDirectory.resolvePath(txt_file.text));
			}
								//4      6       6       1        6      6       3       4       4       6       6       6
			var names:Array = ["待机", "走路", "跑步", "预备", "攻击", "施法", "受伤", "死亡", "骑待", "骑走", "骑跑", "跳跃"];
			var frames:Array= [4,        6,      6,      1,      6,      6,      3,       4,      4,     6,      6,      6]
			
			for (var n:int = 0; n < source.length;n++ )
			{
				var target:File = source[n];
				var folders:Array = target.getDirectoryListing();
				for (var i:int = 0; i < folders.length; i++) 
				{
					var folder:File = folders[i];
					if(frames[names.indexOf(folder.name)])
					{
						var dir:int = 5;
						var frame:int = frames[names.indexOf(folder.name)];
						var pngs:Array = folder.getDirectoryListing();
						var endId:int = dir * frame;
						for (var j:int = 0; j < pngs.length; j++) 
						{
							var png:File = pngs[j];
							if (j>=endId) 
							{
								//trace("正在删除资源:",png.nativePath);
								png.deleteFileAsync();
							}
						}
					}else{
						App.log.warn("不存在文件夹:",folder.name);
					}
					
				}
			}
			App.log.info("转换结束");
		}
		
		static public function get instance():converDir 
		{
			if (!_instance) 
			{
				_instance = new converDir;
			}
			return _instance;
		}
	}

}