package view.dialog 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import morn.core.handlers.Handler;
	import view.auto.common.DialogWelcomUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class welcome extends DialogWelcomUI 
	{
		private var _projectPath:String = "";
		public function welcome() 
		{
			super();
			btn_browse.clickHandler = new Handler(brower);
			btn_start.clickHandler = new Handler(start);
			btn_newProject.clickHandler = new Handler(function ():void 
			{
				App.dialog.show(new createNew);
			});
		}
		private function brower():void 
		{
			var file:File = File.desktopDirectory;
			var fileFilterXml:FileFilter = new FileFilter("xml", "*.xml");
			var fileFilterTe:FileFilter = new FileFilter("xml", "*.te");
			file.browseForOpen("选择项目文件",[fileFilterXml,fileFilterTe]);
			file.addEventListener(Event.SELECT,function (e:Event):void 
			{
				_projectPath=txt_path.text = file.nativePath;
			});
		}
		private function start():void 
		{
			if (_projectPath=="" && txt_path.text!="") 
			{
				_projectPath = txt_path.text;
			}
			var file:File = File.desktopDirectory.resolvePath(_projectPath);
			if (file.exists) 
			{
				var xmlStr:String = "";
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				xmlStr = fs.readMultiByte(fs.bytesAvailable, "utf-8");
				fs.close();
				fs = null;
				var xml:XML = new XML(xmlStr);
				var version:String = xml.@version;
				if (version && int(version)<3) 
				{
					upgrade(xml);
					trace("项目升级完成");
				}else{
					if (ProjectConfig.loadProjectXML(_projectPath))
					{
						saveLastOpenProject();
					}
				}
			}else{
				trace("项目文件不存在");
			}
		}
		public  function readLastOpenProject():void 
		{
			var file:File = File.applicationDirectory.resolvePath("projects.xml");
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
					if (String(item.@selected)=="true")
					{
						_projectPath = item.@path;
						break;
					}
				}
			}
			if (_projectPath && _projectPath!="") 
			{
				start();
			}
		}
		public  function saveLastOpenProject():void 
		{
			var file:File = File.applicationDirectory.resolvePath(File.applicationDirectory.resolvePath("projects.xml").nativePath);
			var fs:FileStream = new FileStream();
			var xml:XML = null;
			if (file.exists) 
			{
				fs.open(file, FileMode.READ);
				var xmlString:String=fs.readMultiByte(fs.bytesAvailable, "utf-8");
				fs.close();
				xml = new XML(xmlString);
				var have:Boolean = false;
				var xmlList:XMLList = xml.children();
				for (var i:int = 0; i < xmlList.length();i++)
				{
					var item:XML = xmlList[i] as XML;
					if (item.@path == _projectPath)
					{
						have = true;
						item.@selected = "true";
					}else{
						item.@selected = "false";
					}
				}
				if (!have) 
				{
					xml.appendChild(new XML("<item path=\""+_projectPath+"\" selected=\"true\"/>"));
				}
			}else{
				xml = new XML("<project>"+
				"<item path=\""+_projectPath+"\" selected=\"true\"/>"+
				"</project>");
			}
			
			fs = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(xml.toString(), "utf-8");
			fs.close();
		}
		/**
		 * 项目升级
		 */
		public function upgrade(xml:XML):void 
		{
			var projectXml:String = "";
			var newProjectPath:String = "D:/JiuYin/client/design/JiuYinNew/";
			//var mondefStr:XML = xml.child("mon")[0];
			
			//todo 生成项目描述文件
			var projectFile:File = File.desktopDirectory.resolvePath(newProjectPath + "project.xml");
			//step 1
			createFolder();
			//step 2
			moveAssets(xml);
			//step 3
			createLibraryXml(xml);
		}
		private function createDefineXML(xml:XML):void 
		{
			//todo 生成游戏配置文件
			//var itemdef:File = File.desktopDirectory.resolvePath(newProjectPath + "config/data/xml_itemdef.xml");
			//var levelinfo:File = File.desktopDirectory.resolvePath(newProjectPath + "config/data/xml_levelinfo.xml");
			//var mapconn:File = File.desktopDirectory.resolvePath(newProjectPath + "config/data/xml_mapconn.xml");
			//var mapinfo:File = File.desktopDirectory.resolvePath(newProjectPath + "config/data/xml_mapinfo.xml");
			//var mondef:File = File.desktopDirectory.resolvePath(newProjectPath + "config/data/xml_mondef.xml");
			//var mongen:File = File.desktopDirectory.resolvePath(newProjectPath + "config/data/xml_mongen.xml");
			//var npcgen:File = File.desktopDirectory.resolvePath(newProjectPath + "config/data/xml_npcgen.xml");
			//var npcgenXMl:XML = xml.child("define").child("npc")[0];
			//
			//var fs:FileStream = new FileStream();
			//fs.open(itemdef, FileMode.WRITE);
		}
		/**
		 * 移动资源
		 * @param	xml
		 */
		private function moveAssets(xml:XML):void 
		{
			var oldProjectResPath:String = "D:/JiuYin/client/res/";
			var newProjectPath:String = "D:/JiuYin/client/design/JiuYinNew";
			var targets:Array = [
				//{catalogName:"怪物",catalogId:"2",path:"cloth/"},
				//{catalogName:"游NPC",catalogId:"3",path:"cloth/"},
				//{catalogName:"地图",catalogId:"5",path:"map/"},
				{catalogName:"主角/外观",catalogId:"7",path:"cloth/"},
				//{catalogName:"主角/武器",catalogId:"9",path:""},
				//{catalogName:"特效/战士技能",catalogId:"10",path:"effect/"},
				//{catalogName:"特效/法师技能",catalogId:"11",path:"effect/"},
				//{catalogName:"特效/道士技能",catalogId:"12",path:"effect/"},
				//{catalogName:"特效/其他特效",catalogId:"13",path:"effect/"},
			];
			var fileType:Array = [".bin", ".plist",".png"];//,".jpg",".mapo"
			for (var j:int = 0; j < targets.length; j++) 
			{
				var target:Object = targets[j];
				var targetFolder:String = target.catalogName;
				var targetCatalog:String = target.catalogId;
				var savePath:String = newProjectPath+"/library/"+targetFolder;
				
				var originalPath:String = xml.child("path").text();
				var reg:RegExp = new RegExp("\\\\", "g");
				originalPath = originalPath.replace(reg, "/");
				
				var parentPath:String = originalPath + "/JiuYin/" + targetFolder;
				var respath:String = oldProjectResPath+target.path;
				
				var originalXml:XML = xml.child("resource")[0] as XML;
				if (originalXml) 
				{
					var xmlList:XMLList = originalXml.children();
					for each(var child:XML in xmlList) 
					{
						var catalog:String = child.@catalog;
						if (catalog==targetCatalog) 
						{
							var temp:XMLList = child.children();
							var id:String = child.@id;
							var name:String = child.@name;
							if (temp.length()>0) 
							{
								for each(var assets:XML in temp) 
								{
									name = name == ""?id:name;
									var actionId:String = assets.@id;
									for (var i:int = 0; i < fileType.length; i++) 
									{
										var newName:String = actionId.replace(id, "");
										var filePath:String = parentPath + "/" + actionId + fileType[i];
										
										if (fileType[i]==".png") 
										{
											filePath = respath + actionId + fileType[i];
										}
										var file:File = File.desktopDirectory.resolvePath(filePath);
										if (file.exists) 
										{
											if (newName=="08") 
											{
												trace();
											}
											trace("新路径",savePath + "/" + name+"(" + id + ")/export/" + newName+fileType[i]);
											var newFile:File = File.desktopDirectory.resolvePath(savePath + "/" + name+"(" + id + ")/export/" + newName+fileType[i]);
											if (newFile.exists)
											{
												trace("存在",newFile.nativePath);
												continue;
											}
											file.copyTo(newFile, true);
										}else{
											trace("不存在文件:",filePath);
										}
									}
								}
							}else{
								if (targetFolder=="地图")
								{
									fileType = [".mapo"];
								}
								for (var k:int = 0; k < fileType.length; k++) 
								{
									filePath = parentPath + "/" + id + fileType[i];
									if (fileType[i]==".png")
									{
										filePath = respath + id + fileType[i];
									}
									file = File.desktopDirectory.resolvePath(filePath);
									if (file.exists) 
									{
										newFile = File.desktopDirectory.resolvePath(savePath + "/" + name+"(" + id + ")/export/" + id + fileType[i]);
										if (targetFolder=="地图")
										{
											newFile = File.desktopDirectory.resolvePath(savePath + "/" + name+fileType[i]);
										}
										if (newFile.exists) continue;
										file.copyTo(newFile, true);
									}
								}
							}
						}
					}
				}
			}
		}
		private function createFolder():void 
		{
			var newProjectPath:String = "D:/JiuYin/client/design/JiuYinNew/";
			var folders:Array = ["config", "library", "output", "resource"];
			var childFolders:Array = [
				["action", "data","texturepacker"]
			];
			for (var i:int = 0; i < folders.length; i++) 
			{
				var folder:File = File.desktopDirectory.resolvePath(newProjectPath + folders[i]);
				folder.createDirectory();
				if (childFolders[i]) 
				{
					for (var j:int = 0; j < childFolders[i].length; j++) 
					{
						folder = File.desktopDirectory.resolvePath(newProjectPath + folders[i] + "/" + childFolders[i][j]);
						if (!folder.exists) 
						{
							folder.createDirectory();
						}
					}
				}
			}
		}
		/**
		 * 生成library xml 信息
		 * @param	xml
		 */
		private function createLibraryXml(xml:XML):void 
		{
			var newProjectPath:String = "D:/JiuYin/client/design/JiuYinNew/";
			//todo 生成资源描述文件library.xml 及复制资源
			var libraryFile:File = File.desktopDirectory.resolvePath(newProjectPath + "library/library.xml");
			var libraryXml:XML=new XML("<resource/>")
			var originalXml:XML = xml.child("resource")[0] as XML;
			if (originalXml) 
			{
				var xmlList:XMLList = originalXml.children();
				for each(var child:XML in xmlList) 
				{
					var assets:XML = new XML("<assets/>");
					assets.@id = child.@id;
					assets.@name = child.@name;
					assets.@catalog = child.@catalog;
					
					var signFile:String = child.@noChildren;
					
					if (signFile!="") 
					{
						assets.@dir = child.@dir;
						assets.@center = child.@center;
						assets.@hideChildren = child.@noChildren
						var children:XMLList = child.children();
						for each(var item:XML in children) 
						{
							var newItem:XML = new XML("<item/>");
							 //<file id="2800206" framecount="3" picnum="3" frameinfo="1,1,1" maxSize="1024" path="主角/外观"/>
							 var parentId:String = assets.@id;
							 var oldId:String = item.@id;
							 var newId:String = oldId.replace(parentId,"");
							 newItem.@id = newId;
							 newItem.@framecount = item.@framecount;
							 newItem.@frameinfo = item.@frameinfo;
							 newItem.@imgNum = item.@picnum;
							 assets.appendChild(newItem);
						}
					}else{
						//地图文件
						var mapres:String = child.@mapres;
						if (mapres!="") 
						{
							//assets.@res = mapres;
							//assets.@mapo = child.@mapo;
						}else{
							//特效文件
							assets.@framecount = child.@framecount;
							assets.@imgNum = child.@imgNum;
							assets.@frameinfo = child.@frameinfo;
							assets.@center = child.@center;
							assets.@dir = child.@dir;
							assets.@hideChildren=child.@noChildren
						}
					}
					libraryXml.appendChild(assets);
				}
			}
			var fs:FileStream = new FileStream();
			fs.open(libraryFile, FileMode.WRITE);
			fs.writeMultiByte(libraryXml.toString(), "utf-8");
			fs.close();
		}
	}

}