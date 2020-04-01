package
{
	import flash.filesystem.File;
	import editor.EditorManager;
	import game.tools.texturePacker.TexturePacker;
	import tests.configruation.MapInfo_Test;
	import view.work;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author lee
	 */
	public class Main extends Sprite 
	{
		public function Main() 
		{
			if (false) 
			{
				doTest();
				return;
			}
			if (stage) 
			{
				init();
			}
		}
		private function init(e:Event=null):void 
		{
			//copyPanelCloak();
			//return;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			if (false) //复制资源
			{
				var file:File = File.applicationDirectory.resolvePath("D:/JiuYin/client/design/JiuYinNew/library/特效/其他特效");
				var folders:Array = file.getDirectoryListing();
				for each(var folder:File in folders ) 
				{
					var folderName:String = folder.name;
					var targetFile:File = File.applicationDirectory.resolvePath(folder.nativePath + "/export");
					var targets:Array = targetFile.getDirectoryListing();
					for each(var bin:File in targets) 
					{
						if (bin.extension=="bin") 
						{
							var png:File = File.applicationDirectory.resolvePath("D:/JiuYin/client/res/effect/" + bin.name.replace(".bin", "") + ".png");
							if (png.exists) 
							{
								var targetPath:String=targetFile.nativePath + "/" + png.name
								var targetPng:File = File.applicationDirectory.resolvePath(targetPath);
								trace("正在复制:",png.name);
								png.copyToAsync(targetPng,true);
							}
						}
					}
				}
				return;
			}
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf"], new Handler(handlerEnterEditer));
			TexturePacker.tpPath = "C:/Program Files/CodeAndWeb/TexturePacker/bin/TexturePacker.exe";
		}
		private function handlerEnterEditer():void 
		{
			stage.addEventListener(Event.RESIZE, handleResize);
			this.addChild(work.instance);
			work.instance.setSize(stage.stageWidth, stage.stageHeight);
			EditorManager.init(this);
		}
		//测试用例
		private function doTest():void 
		{
			MapInfo_Test.exportTest();
		}
		private function handleResize(e:Event):void 
		{
			work.instance.width = stage.stageWidth;
			work.instance.height = stage.stageHeight;
		}
		//宠物处理
		private function copyPet():void 
		{
			var root:String = "D:/xjh/client/design/JiuYinNew/resource/宠物";
			var rootFolder:File = File.applicationDirectory.resolvePath(root);
			var folders:Array = rootFolder.getDirectoryListing();
			for (var i:int = 0; i < folders.length; i++) 
			{
				var folder:File = folders[i];
				var actions:Array = folder.getDirectoryListing();
				for (var j:int = 0; j < actions.length; j++) 
				{
					var action:File = actions[j];
					if (action.name=="面板待机" || action.name=="面板休闲") 
					{
						var newAction:File = File.applicationStorageDirectory.resolvePath(root+"/"+"面板"+"/"+folder.name+"/"+action.name);
						action.moveTo(newAction, true);
						//trace(newAction.nativePath);
					}
				}
			}
		}
		//披风面板资源
		private function copyPanelCloak():void 
		{
			//少林 100 pt_0
			//武当 110 pt_1
			//峨眉 120 pt_3
			var job:Array = ["少林","武当","古墓","峨眉"];
			for (var i:int = 0; i <job.length; i++) 
			{
				if (i == 2) continue;
				for (var k:int = 0; k < 9; k++) 
				{
					var root:String = "D:/xjh/client/design/JiuYinNew/resource/披风/"+job[i]+"/第"+(k+1)+"套";
					var target:String = "D:/xjh/client/design/JiuYinNew/resource/披风/整理后";
					
					var newName:String = job[i] + "(" + (100 + i * 10) + (k + 1) + ")";
					if (i==3) 
					{
						newName=job[i] + "(" + (100 + (i-1) * 10) + (k + 1) + ")";
					}
					trace(newName);
					//var action:Array = ["待机", "跑步", "攻击", "施法", "技能1", "技能2", "蓄力", "死亡", "打坐", "跳1", "跳2"];
					//var dirs:Array = [5,4,3,2,1];
					var folder:File = File.applicationDirectory.resolvePath(root+"/pt_"+i+"_"+k+"_m_dir/0_0");
					var newFolder:File = File.applicationDirectory.resolvePath(target + "/面板/" + newName);
					folder.copyTo(newFolder, true);
				}
			}
		}
		//披风处理
		private function copyFileToFolder():void 
		{
			for (var k:int = 0; k < 9; k++) 
			{
				var root:String = "D:/xjh/client/design/JiuYinNew/resource/披风/峨眉/第"+(k+1)+"套";
				var target:String = "D:/xjh/client/design/JiuYinNew/resource/披风/整理后";
				var newName:String = "峨眉(120"+(k+1)+")";
				var action:Array = ["待机", "跑步", "攻击", "施法", "技能1", "技能2", "蓄力", "死亡", "打坐", "跳1", "跳2"];
				var dirs:Array = [5,4,3,2,1];
				var file:File = File.applicationDirectory.resolvePath(root+"/pt_3_"+k+"_dir");
				
				var folderList:Array = file.getDirectoryListing();
				for (var i:int = 0; i < folderList.length; i++) 
				{
					var folder:File = folderList[i];
					var fn:String = folder.name;
					var name_dir:Array = fn.split("_");
					var n:int = name_dir[0];
					var d:int = name_dir[1];
					var pngs:Array = folder.getDirectoryListing();
					if (action[n] == "打坐" || action[n] == "跳1" || action[n] == "跳2"  || action[n] == "蓄力" || action[n]=="打坐") 
					{
						continue;
					}
					for (var j:int = 0; j < pngs.length; j++) 
					{
						var png:File = pngs[j];
						var newpng:File = File.applicationDirectory.resolvePath(target +"/"+newName+"/"+action[n] + "/" + (dirs[d] * 1000 + j) + ".png");
						//trace(png.nativePath);
						//trace(newpng.nativePath);
						png.copyTo(newpng,true);
					}
				}
			}
		}
	}
	
}