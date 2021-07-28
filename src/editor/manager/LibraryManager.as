package editor.manager 
{
	import editor.events.EditorEvent;
	import editor.manager.CatalogManager;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	import game.assets.ActionManager;
	import game.assets.AnimateManager;
	import game.assets.action.Action;
	import game.assets.animat.AnimatInfo;
	import game.data.DataManager;
	import game.tools.texturePacker.TexturePacker;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class LibraryManager 
	{
		private var _instance:LibraryManager = null;
		private  var _resDic:Dictionary = new Dictionary;
		private  var _path:String = "";
		public function LibraryManager() 
		{
			
		}
		public  function init():void 
		{
			_path = ProjectConfig.libraryPath + "library.xml";
			var xmlFile:File = File.applicationDirectory.resolvePath(_path);
			if (xmlFile.exists) 
			{
				var start:int = getTimer();
				var xml:XML = null;
				try 
				{
					var fileStream:FileStream = new FileStream();
					fileStream.open(xmlFile, FileMode.READ);
					var xmlStr:String = fileStream.readMultiByte(fileStream.bytesAvailable, 'utf-8');
					xml = new XML(xmlStr);
					fileStream.close();
					fileStream = null;
				}catch (err:Error)
				{
					trace("读取文件出错:",err.message);
				}
				var xmllist:XMLList = xml.children();
				for (var i:int = 0; i <xmllist.length() ; i++)
				{
					var files:XML = xmllist[i] as XML;
					var catalogid:int = int(files.@catalog)
					var dic:Dictionary = null;
					if (_resDic[catalogid]) 
					{
						dic = _resDic[catalogid];
					}else {
						_resDic[catalogid] = dic = new Dictionary;
					}
					var fileid:String = String(files.@id);
					dic[fileid] = files;
				}
				trace("读取library资源耗时:", (getTimer() - start) / 1000);
				App.stage.dispatchEvent(new EditorEvent(EditorEvent.LIBRARY_LOAD_COMPLETED));
			}else{
				trace("文件不不存在");
			}
		}
		/**
		 * 生成资源描述xml
		 * @param	path
		 * @param	catalogId
		 * @param	dirCount
		 * @param	center
		 * @param	actionModel
		 * @return
		 */
		public static function getDescriptionXML(path:String,catalogId:int,dirCount:int,center:String,actionModel:String,actionId:String=""):XML
		{
			var xml:XML = null;
			var folder:File = File.applicationDirectory.resolvePath(path);
			if (folder.exists)
			{
				var tempStr:String = folder.name.replace("(", ",");
				tempStr = tempStr.replace(")", "");
				var tempArr:Array = tempStr.split(",");
				var id:int = tempArr[1];
				var name:String = tempArr[0];
				xml = <assets/>;
				xml.@id = id;
				xml.@name = name;
				xml.@dir = dirCount;
				xml.@center = center;
				xml.@hideChildren = "true";
				xml.@actionModel = actionModel;
				xml.@catalog = catalogId;
				switch (catalogId) 
				{
					case 2:
					case 3:
					case 7:
					case 8:
					case 9:
					case 10:
					case 11:
					case 12:
					case 13:
					case 14:
					case 15:
					case 16:
					case 17:
					case 18:
					case 19:
						xml.@export = id;
					break;
				}
				if (CatalogManager.instance.isEffectCatalog(catalogId)) 
				{
					var frame:int = 2;
					if (actionId!="") 
					{
						var action:Action = DataManager.action.getActionByName(actionModel, actionId);
						if (action) 
						{
							xml.@action = action.id;
							xml.@action = action.id;
							frame = int(action.frame);
						}
					}
					var list:int = folder.getDirectoryListing().length;
					var imgNum:int = list / dirCount;
					var frameCount:int = frame*imgNum;
					var frameInfo:String = "";
					var temp:Array = [];
					for (var k:int = 0; k < imgNum; k++) 
					{
						temp.push("2");
					}
					frameInfo = temp.join(",");
					xml.@framecount = frameCount;
					xml.@imgNum = imgNum;
					xml.@frameinfo = frameInfo;
					
				}else{
					var children:Array = folder.getDirectoryListing();
					for each(var file:File in children)
					{
						action = DataManager.action.getActionByName(actionModel, file.name);
						if (action) 
						{
							list = file.getDirectoryListing().length;
							imgNum = list / dirCount;
							var item:XML =<item/>;
							frameCount = 0;
							frameInfo = "";
							if (action.adjust!="") 
							{
								var adjust:Array = action.adjust.split(",");
								for (var i:int = 0; i < adjust.length; i++) 
								{
									frameCount += int(adjust[i]);
								}
								frameInfo = action.adjust;
							}else{
								temp = [];
								frameCount = imgNum * int(action.frame);
								for (var j:int = 0; j < imgNum; j++) 
								{
									temp.push(action.frame);
								}
								frameInfo = temp.join(",");
							}
							item.@id =action.id;
							item.@framecount = frameCount;
							item.@imgNum = imgNum;
							item.@frameinfo = frameInfo;
							xml.appendChild(item);
						}else{
							trace("未找到",file.name,"的动作描述信息");
						}
					}
				}
			}
			return xml;
		}
		public function unuseNode(xml:XML):void 
		{
			xml.@unuse = 'true';
			addResNode(xml);
		}
		public function usedNode(xml:XML):void 
		{
			xml.@unuse = '';
			addResNode(xml);
		}
		public function addResNode(xml:XML,autosave:Boolean=true):void 
		{
			var catalogid:int = xml.@catalog;
			var fileid:String = String(xml.@id);
			if (!_resDic[catalogid])
			{
				_resDic[catalogid] = new Dictionary;
			}
			if (!_resDic[catalogid][fileid]) 
			{
				App.log.info("新增一个资源:"+fileid);
			}
			_resDic[catalogid][fileid] = xml;
			saveLibraryXML();
		}
		public function delResNode(catalogId:int,resId:int):void 
		{
			if (_resDic[catalogId] && _resDic[catalogId][resId+""]) 
			{
				delete _resDic[catalogId][resId + ""];
			}
			saveLibraryXML();
		}
		public  function saveLibraryXML():void 
		{
			var resRootXml:XML = new XML("<resource/>");
			for (var catalogid:* in _resDic) 
			{
				var dic:Dictionary = _resDic[catalogid];
				for (var fileid:* in dic) 
				{
					switch (catalogid) 
					{
						case 2:
						case 3:
						case 7:
						case 8:
						case 9:
						case 16:
							dic[fileid].@export = fileid+ "";
							break;
						
					}
					resRootXml.appendChild(dic[fileid]);
				}
			}
			var file:File = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath + "library.xml");
			if (file.exists) 
			{
				try 
				{
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.WRITE);
					fileStream.writeMultiByte(resRootXml.toXMLString(), "utf-8");
					fileStream.close();
					fileStream = null;
				}catch (e:Error)
				{
					trace("保存library信息失败："+e.message);
				}
			}
			init();
		}
		public  function getResNode(id:String,catalogId:int):XML 
		{
			var resNode:XML = null;
			if (_resDic[catalogId]) 
			{
				var dic:Dictionary = _resDic[catalogId];
				for each(var xml:XML in dic) 
				{
					var tempId:String= String(xml.@id);
					if (tempId==id) 
					{
						resNode = xml;
						break;
					}
				}
			}
			return resNode;
		}
		/**
		 * 获取exportid对应的文件名称
		 * @param	catalogId
		 * @param	exportId
		 * @return
		 */
		public function getPathByExportId(catalogId:int,exportId:String):String 
		{
			var resNode:XML = null;
			if (_resDic[catalogId]) 
			{
				var dic:Dictionary = _resDic[catalogId];
				for each(var xml:XML in dic) 
				{
					var tempId:String= String(xml.@export);
					if (tempId==exportId) 
					{
						return String(xml.@name);
						break;
					}
				}
			}
			return "";
		}
		public  function getResCatalogNode(id:int):Array 
		{
			function sortOnId(a:xmlObj, b:xmlObj):int 
			{
				var aid:int = a.id; var bid:int = b.id;
				if (aid>bid) 
				{
					return 1;
				}else if (aid<bid) {
					return -1;
				}else{
					return 0;
				}
			}
			if (_resDic[id])
			{
				var dic:Dictionary = _resDic[id];
				if (dic) 
				{
					var tempResult:Array = [];
					var result:Array = [];
					reg = null;
					if (id==5) 
					{
						var tempMapArr:Array = [];
						var tempDicMap:Dictionary = new Dictionary;
						for each(xml in dic)
						{
							var tempStrId:String = String(xml.@id);
							tempMapArr.push(tempStrId);
							tempDicMap[tempStrId] = xml;
						}
						tempMapArr = tempMapArr.sort();
						for each(var key:String in tempMapArr)
						{
							result.push(tempDicMap[key]);
						}
					}else{
						var reg:RegExp = new RegExp('[^0-9]*', "g");
						for each(var xml:XML in dic) 
						{
							var temp:String = String(xml.@id);
							var __id:String = temp.replace(reg, "");
							var tempId:int = int(__id);
							tempResult.push(new xmlObj(tempId,temp,new XML(xml.toXMLString())));
						}
						tempResult.sort(sortOnId);
						
						for (var i:int = 0; i < tempResult.length; i++) 
						{
							result.push(tempResult[i].xml);
						}
						tempResult = [];
						tempResult = null;
					}
					return result;
				}
				return null;
			}
			return null;
		}
		public function exportQiege():void 
		{
			exportBiz("qiege", 4);
		}
		public function exportCloth():void
		{
			exportBiz("cloth", 0);
		}
		public function exportWeapon():void 
		{
			exportBiz("weapon", 1);
			//exportPng("weapon",1);
		}
		public function exprotWing():void 
		{
			exportBiz("wing",2);
		}
		public function exprotEffect():void 
		{
			exportBiz("effect",3);
		}
		public function exprotMount():void 
		{
			exportBiz("mount",5);
		}
		public function exprotPet():void 
		{
			exportBiz("pet",6);
		}
		private function exportPng(folder:String,displayId:int):void 
		{
			var assets:Array = getExportAssets(displayId);
			for each(var obj:Object in assets) 
			{
				var path:String = ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(obj.catalog) +"/"+obj.folderName+"/export/" + obj.action + ".png";
				var file:File = File.applicationDirectory.resolvePath(path);
				if (file.exists) 
				{
					var newFile:File = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath +folder + "/" + obj.id + ".png");
					file.copyToAsync(newFile, true);
				}
			}
			App.log.info("资源全部导出完毕");
		}
		
		private function getExportAssets(displayId:int):Array
		{
			var catalogs:Array = CatalogManager.instance.getCatalogIdByDisplayId(displayId);
			var assets:Array = [];
			for (var k:int = 0; k < catalogs.length; k++) 
			{
				assets=assets.concat(getAssetsByCatalogId(catalogs[k]));
			}
			return assets;
		}
		/**
		 * 根据目录ID获取资源李彪
		 * @param	id
		 * @return array
		 */
		public function getAssetsByCatalogId(id:int):Array 
		{
			var assets:Array = [];
			var dic:Dictionary = _resDic[id];
			var displayId:int = CatalogManager.instance.getDisplayIdByCatalogId(id);
			if (dic) 
			{
				for each(var xml:XML in dic) 
				{
					if (displayId==3)
					{
						var item:Object = new Object;
						item.catalog = id;
						item.id = xml.@export;
						item.name = xml.@name;
						item.folderName = item.name;
						item.action = xml.@id;
						item.type = String(xml.@type) == "jpg"?"jpg":"png";
						assets.push(item);
					}else
					{
						var children:XMLList = xml.children();
						for (var i:int = 0; i < children.length(); i++) 
						{
							var child:XML = children[i] as XML;
							if (DataManager.action.getActionPublish(ProjectConfig.adoptAction,child.@id)) 
							{
								child.@catalog = id;
								item = new Object;
								item.name = String(xml.@name);
								item.folderName = item.name;
								item.id = String(xml.@export + child.@id);
								item.action = String(child.@id);
								item.catalog = id;
								item.type = String(xml.@type) == "jpg"?"jpg":"png";
								assets.push(item);
							}
						}
					}
				}
			}
			return assets;
		}
		/**
		 * 根据显示组件分类生成biz
		 * @param	bizName
		 * @param	displayId
		 */
		private function exportBiz(bizName:String,displayId:int):void 
		{
			var assets:Array = getExportAssets(displayId);
			createBiz(bizName, assets);
		}
		private function createBiz(bizName:String,assets:Array,path:String=""):void
		{
			if (!assets) 
			{
				return;
			}
			var bizPath:String = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath +"biz/" + bizName + ".biz").nativePath;
			var bizFile:File = new File(bizPath);
			var bizStream:FileStream = new FileStream();
				bizStream.open(bizFile, FileMode.WRITE);
			//biz文件前期的描述: 0x43固定、文件数量
			var bizByteArray:ByteArray = new ByteArray();
				bizByteArray.endian = Endian.LITTLE_ENDIAN;
				bizByteArray.writeByte(0x4c);
				bizByteArray.writeByte(0x49);
				bizByteArray.writeByte(0x50);
				bizByteArray.writeByte(0x45);
				bizByteArray.writeByte(0x4e);
				bizByteArray.writeByte(0x47);
				bizByteArray.writeByte(0x48);
				bizByteArray.writeByte(0x75);
				bizByteArray.writeByte(0x69);
				//文件总数
				bizByteArray.writeInt(assets.length);
			var len:int = 0;
			//var children:XMLList = parentXML.children();
			for (var k:int = 0; k < assets.length; k++)
			{
				var item:Object = assets[k];
				//每个文件单的名称写入
				var binFile:File = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath+ CatalogManager.instance.getAbsolutePath(int(item.catalog))+ "/" +item.folderName+"/export/" +item.action+".bin");
				if (binFile.exists)
				{
					var fileid:String = item.id;// binFile.name.replace(".bin", "");
					bizByteArray.writeByte(fileid.length);
					bizByteArray.writeMultiByte(fileid, 'utf-8');
					bizByteArray.writeByte(0);
					bizByteArray.writeInt(1);
					//bin文件写入
					var binByteArray:ByteArray = new ByteArray();
						binByteArray.endian = Endian.LITTLE_ENDIAN;
					var binStream:FileStream = new FileStream();
						binStream.open(binFile, FileMode.READ);
						binStream.readBytes(binByteArray)
						binStream.close();
					//单个bin文件出错后则continue
					try 
					{
						var dirCount:int = binByteArray.readByte();  	// 方向数
						binByteArray.readByte();  						// 暂时无用
						var imgNum:int=binByteArray.readByte(); 		// 图片数量
						var frameCount:int = 0;
						for (var i:int = 0; i < imgNum; i++) 
						{
							var temp:int = binByteArray.readByte();
							frameCount += temp;
						}
						for (var ii:int=0; ii < dirCount; ii++)
						{
							for (var jj:int = 0; jj < imgNum; jj++)
							{
								var x:int=binByteArray.readShort();
								var y:int=binByteArray.readShort();
								var w:int=binByteArray.readShort();
								var h:int=binByteArray.readShort();
								var cx:int=binByteArray.readShort();
								var cy:int=binByteArray.readShort();
								var rotated:int = binByteArray.readShort();
							}
						}
					}catch (err:Error)
					{
						bizStream.close();
						bizFile.deleteFile();
						App.log.error("发布失败,存在异常文件:[ <font color='#FF0000'>" + binFile.name+"</font> ]");
						//DialogPrompt.instance.alert("发布失败,存在异常文件:[ <font color='#FF0000'>"+binFile.name+"</font> ]");
						//App.dialog.show(DialogPrompt.instance);
						return;
					}
					bizByteArray.writeBytes(binByteArray, 0, binByteArray.length);
					//tempCurr++;
				}else {
					trace("3:文件不存在:",binFile.nativePath);
				}
			}
			bizStream.writeBytes(bizByteArray,0,bizByteArray.length);
			bizStream.close();
			App.log.info("biz生成完毕,共",assets.length,"个文件");
		}
		/**
		 * 根据resnode创建bin文件
		 * @param	xml Library中的xml描述信息
		 * @param	targetAction 指定的动作信息，未指定则全部生成
		 */
		public  function createBinFileByXmlNode(xml:XML,targetAction:String=""):void 
		{
			var catalogId:int = xml.@catalog;
			if (catalogId && catalogId>0) 
			{
				var id:String = xml.@id;
				var name:String = xml.@name;
				var dir:int = xml.@dir;
				var center:String = xml.@center;
				var path:String =[ProjectConfig.libraryPath,CatalogManager.instance.getAbsolutePath(catalogId),xml.@name,"export",""].join("/");
				
				var xmlList:XMLList = null;
				if (CatalogManager.instance.isEffectCatalog(catalogId)) 
				{
					xmlList = new XMLList(xml);
					targetAction = "";
				}else{
					xmlList= xml.children();
				}
				for each(var child:XML in xmlList) 
				{
					var actionId:String = child.@id;
					var imgNum:int = child.@imgNum;
					var childCenter:String = child.@center;
					var frameInfo:String = child.@frameinfo;
					var tempCenter:String = center;
					if (childCenter && childCenter!="") 
					{
						tempCenter = childCenter;
					}
					var point:Array = tempCenter.split(",");
					var plist:String = path + actionId + ".plist";
					var bin:String = path + actionId + ".bin";
					var animatData:Array = TexturePacker.plistData(plist);
					if (targetAction!="")
					{
						if (targetAction == actionId)
						{
							createBinFile(bin, animatData, dir, imgNum, frameInfo, new Point(point[0], point[1]));
							break;
						}
					}else{
						createBinFile(bin, animatData, dir, imgNum, frameInfo, new Point(point[0],point[1]));
					}
				}
			}
		}
		
		/**
		 * 
		 * @param	outputPath 保存路径
		 * @param	animatData 通过plist文件获取到的Animate信息
		 * @param	dir 方向
		 * @param	imgNum 图片数量
		 * @param	frameInfo 动作帧信息
		 * @param	center 中心点
		 */
		public  function createBinFile(outputPath:String,animatData:Array,dir:int,imgNum:int,frameInfo:String,center:Point):void 
		{
			var ba:ByteArray = new ByteArray();
			ba.endian = Endian.LITTLE_ENDIAN;
			ba.writeByte(dir);
			ba.writeByte(dir);
			ba.writeByte(imgNum);
			var frameArr:Array = frameInfo.split(",");
			for (var k:int = 0; k < imgNum; k++) 
			{
				ba.writeByte(frameArr[k]);
			}
			for (var j:int = 0; j < dir; j++)
			{
				for (var l:int = 0; l < imgNum; l++)
				{
					var id:int = (j * imgNum) + l;
					var animat:AnimatInfo = animatData[id];
					if (animat)
					{
						ba.writeShort(animat.x);
						ba.writeShort(animat.y);
						ba.writeShort(animat.w);
						ba.writeShort(animat.h);
						ba.writeShort(animat.oldX-center.x);
						ba.writeShort(animat.oldY-center.y);
						ba.writeShort(animat.rotated);
					}
				}
			}
			var binfile:File = new File(outputPath);
			var binStream:FileStream = new FileStream();
				binStream.open(binfile, FileMode.WRITE);
				binStream.writeBytes(ba,0,ba.length);
				binStream.close();
			App.log.info(outputPath);
			App.stage.dispatchEvent(new EditorEvent(EditorEvent.LIBRARY_BINFILE_COMPLETED,binfile.name.replace(".bin",""),null,true));
			ba = null;
			binStream = null;
			binfile = null;
		}
		public function get instance():LibraryManager 
		{
			if (_instance==null) 
			{
				_instance = new LibraryManager();
			}
			return _instance;
		}
		
		public function set instance(value:LibraryManager):void 
		{
			_instance = value;
		}
	}

}
class xmlObj {
	private var _id:int;
	private var _xml:XML;
	private var _name:String;
	public function xmlObj(id:int,name:String,xml:XML):void 
	{
		_id = id;
		_name = name;
		_xml = xml;
	}
	
	public function get xml():XML 
	{
		return _xml;
	}
	
	public function get id():int 
	{
		return _id;
	}
}