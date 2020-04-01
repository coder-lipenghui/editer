package view.dialog 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogJiuYinResGroupUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class groupJiuYinRes extends DialogJiuYinResGroupUI 
	{
		private var _rootPath:String = "";
		private var _actions:Dictionary = new Dictionary;
		//private var _dirs:Array = [];
		public function groupJiuYinRes() 
		{
			super();
			//_dirs=[5, 4, 3, 2, 1];
			//待机,跑步,攻击1,攻击2,攻击3,攻击4,采集,死亡,打坐,跳1,跳2,骑待,骑跑
			_actions = new Dictionary();
			_actions[0] = { id:0, name:"待机", flag:"0", frame:6 };
			_actions[1] = { id:1, name:"跑步", flag:"0", frame:8 };
			_actions[2] = { id:2, name:"攻击", flag:"0", frame:5 };
			_actions[3] = { id:3, name:"施法", flag:"0", frame:5 };
			_actions[4] = { id:4, name:"技能1", flag:"0", frame:8 };
			_actions[5] = { id:5, name:"技能2", flag:"0", frame:8 };
			_actions[6] = { id:6, name:"蓄力", flag:"0", frame:4 };
			_actions[7] = { id:7, name:"死亡", flag:"0", frame:3 };
			_actions[8] = { id:8, name:"打坐", flag:"0", frame:1 };
			_actions[9] = { id:9, name:"跳1", flag:"0", frame:3 };
			_actions[10] = { id:10, name:"跳2", flag:"0", frame:1 };
			_actions[11] = { id:11, name:"骑待", flag:"0", frame:6 };
			_actions[12] = { id:12, name:"骑跑", flag:"0", frame:8 };
			
			btn_browse.clickHandler = new Handler(handlerBrowse);
			btn_ok.clickHandler = new Handler(doGroup);
		}
		private function doGroup():void 
		{
			txt_msg.text = "";
			if (_rootPath=="") 
			{
				if (txt_path.text!="") 
				{
					_rootPath = txt_path.text;
				}
			}
			var rootFolder:File = File.desktopDirectory.resolvePath(_rootPath);
			if (!rootFolder.exists) 
			{
				App.log.error("不存在目录:",rootFolder.nativePath);
				return;
			}
			var targetFolder:Array = [];
			if (ck_batch.selected) 
			{
				targetFolder = rootFolder.getDirectoryListing();
			}else{
				targetFolder.push(rootFolder)
			}
			for (var j:int = 0; j < targetFolder.length; j++) 
			{
				var imgs:Array = targetFolder[j].getDirectoryListing();
				for (var i:int = 0; i < imgs.length; i++) 
				{
					var png:File = imgs[i] as File;
					if (png.extension=="db" || (png.extension).toLowerCase()!="png")
					{
						continue;
					}
					var n:String = png.name.replace(".png", "");
					var reg:RegExp = /[^0-9]/g;
					var info:Array = n.split(reg);//getDescript(png.name);
					var type:int = info[0];
					var dir:int = info[1];
					var index:int = info[2];
					var newName:int = (dir - 5) *-1 * 1000 + index;
					var newPng:File = File.desktopDirectory.resolvePath(targetFolder[j].nativePath + "/" +_actions[type].name+"/" + newName+".png");
					png.moveTo(newPng);
				}
			}
			txt_msg.text = "整理完成";
		}
		private function handlerBrowse():void 
		{
			var file:File = null;
			if (txt_path.text!="") 
			{
				file = File.desktopDirectory.resolvePath(txt_path.text);
			}else{
				file = File.desktopDirectory;
			}
			file.browseForDirectory("选择文件夹");
			file.addEventListener(Event.SELECT,function (e:Event):void 
			{
				txt_path.text = _rootPath = file.nativePath;
			});
			txt_msg.text = "";
		}
		/**
		 * 根据文件名称获取分类星系
		 * @param	str 文件名
		 * @return  array [0]:动作类型 [1]:当前方向 [2]:当前图片顺序ID
		 */
		private function getDescript(str:String):Array 
		{
			str = str.replace(".png", "");
			var description:Array = str.split("^");
			var tempType:String = description[0];
			var type:int = 0;
			var dir:int = 0;
			var index:int = 0;
			if (tempType.indexOf("_")>-1) 
			{
				var temp:Array = tempType.split("_");
				type = int(temp[0]);
				dir = int(temp[1]);
				index = int(description[1]);
			}else{
				temp = (description[1] as String).split("_");
				type= int(tempType);
				dir = int(temp[0]);
				index = int(temp[1]);
			}
			return [type,dir,index];
		}
	}
}