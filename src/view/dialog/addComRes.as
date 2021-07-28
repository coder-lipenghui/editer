package view.dialog 
{
	import flash.geom.Point;
	import game.assets.ActionManager;
	import game.assets.BinaryManager;
	import game.assets.action.Action;
	import flash.events.Event;
	import flash.filesystem.File;
	import editor.log.Logger;
	import game.data.DataManager;
	import editor.manager.CatalogManager;
	import editor.manager.LibraryManager
	import game.tools.BrowseTools;
	import morn.core.components.Box;
	import morn.core.components.PullDownMenu;
	import morn.core.components.TextInput;
	import morn.core.handlers.Handler;
	import game.tools.texturePacker.TexturePacker;
	import view.auto.dialog.DialogAddCompResUI;
	import view.window.Log;
	
	/**
	 * 增加人物显示组件素材：衣服、武器、翅膀等
	 * @author 3464285@gmail.com
	 */
	public class addComRes extends DialogAddCompResUI 
	{
		private var _rootPath:String = "";
		private var _sourcePath:String = "";
		private var _savePath:String = "";
		private var _tpList:Array = [];
		private var _targets:Array = [];
		private var _currActions:Array = [];
		private var _pdm:PullDownMenu = null;
		public function addComRes() 
		{
			super();
			btn_browse.clickHandler = new Handler(function ():void 
			{
				BrowseTools.browseForDirectory("选择资源文件夹", txt_path.text==""?"":txt_path.text, function(file:File, target:String):void{
					txt_path.text = _sourcePath = target;
					if (!cb_batch.selected) 
					{
						setFileIdAndName(file.name);
					}
				});
			});
			btn_add.clickHandler = new Handler(add);
		}
		override protected function initialize():void 
		{
			super.initialize();
			var temp:Array = DataManager.action.getModels();
			com_moudle.labels = temp.join(",");
			com_moudle.selectHandler = new Handler(handleChangeActoin);
			list_action.renderHandler = new Handler(handleListActionRender);
			_pdm = new PullDownMenu();
			_pdm.selectedHandler = new Handler(function (index:int):void 
			{
				setCbActions();
			});
			_pdm.x = txt_position.x + txt_position.width + 7;
			_pdm.y = txt_position.y;
			box_catalog.addChild(_pdm);
		}
		private function setCbActions():void
		{
			if (list_action.array) 
			{
				var effectModel:Boolean = false;
				if (CatalogManager.instance.isEffectCatalog(_pdm.selectedId))
				{
					effectModel = true;
				}
				box_effect_model.visible = effectModel;
				cb_effect_action.selectedIndex =-1;
				if (effectModel) 
				{
					var labelArr:Array = [];
					for (var i:int = 0; i < list_action.array.length; i++) 
					{
						var action:Action = list_action.array[i];
						labelArr.push(action.name);
					}
					cb_effect_action.labels = labelArr.join(",");
				}
			}
		}
		private function add():void 
		{
			_tpList = [];
			var folder:File = null;
			if (_sourcePath=="") 
			{
				_sourcePath = txt_path.text;
			}
			_savePath = ProjectConfig.libraryPath+CatalogManager.instance.getAbsolutePath(_pdm.selectedId);
			if (_savePath=="") 
			{
				return ;
			}
			folder = new File(_sourcePath);
			if (folder.exists) 
			{
				if (cb_batch.selected) 
				{
					_targets = folder.getDirectoryListing();
				}else{
					_targets = [];
					_targets.push(folder);
				}
			}else{
				App.log.warn("不存在文件/文件夹:", _sourcePath);
				return;
			}
			if (_pdm.selectedId<0) 
			{
				App.log.error("请选贼保存路劲");
				return;
			}
			for (var i:int = 0; i < _targets.length; i++) 
			{
				var file:File = _targets[i] as File;
				if (file.isDirectory) 
				{
					var __id:String = "";
					var __name:String = "";
					var tempArr:Array = file.name.split("(");
					if (tempArr.length>1)
					{
						__name = tempArr[0];
						__id = tempArr[1].replace(")","");
					}else{
						App.log.warn("文件夹命名格式不对,必须按照“名称(ID)”的形式进行命名");
						return;
					}
					var centerStr:String = txt_x.text + "," + txt_y.text;
					if (CatalogManager.instance.isEffectCatalog(_pdm.selectedId))
					{
						var tpcmd:TexturePacker = new TexturePacker(__id,file.nativePath,_savePath+"/"+__name+"/export/",ProjectConfig.textureModelPath+"/cmd_effect_"+(rg_extension.selectedIndex?"jpg":"png")+".txt");
						tpcmd.successHandler = next;
						tpcmd.errorHandler = onError;
						tpcmd.rootPath = file.nativePath;
						tpcmd.center = centerStr;
						if (!check_rotaion.selected)
						{
							tpcmd.allowRotation = false;
						}
						_tpList.push(tpcmd);
					}else{
						var temp:Array = file.getDirectoryListing();
						for (var j:int = 0; j < temp.length; j++) 
						{
							var child:File = temp[j] as File;
							var actionId:String = DataManager.action.getActionIdByName(com_moudle.selectedLabel, child.name);
							if (actionId) 
							{
								tpcmd = new TexturePacker(actionId,child.nativePath,_savePath+"/"+__name+"/export/",ProjectConfig.textureModelPath+"/cmd_cloth.txt");
								tpcmd.successHandler = next;
								tpcmd.errorHandler = onError;
								tpcmd.rootPath = file.nativePath;
								tpcmd.center = centerStr;
								if (!check_rotaion.selected) 
								{
									tpcmd.allowRotation = false;
								}
								_tpList.push(tpcmd);
							}
						}
					}
				}
			}
			next(null);
		}
		private function onError(target:TexturePacker,info:String):void
		{
			if (info==TexturePacker.TP_ERROR_OUT_RANGE) 
			{
				var newSize:int = target.adjustSize * 2;
				if (newSize<=4096) 
				{
					
					var newCmd:TexturePacker = new TexturePacker(target.name, target.inputPath,target.outputPath, target.paramsPath);
					newCmd.adjustSize = newSize;
					newCmd.center = target.center;
					newCmd.successHandler = next;
					newCmd.errorHandler = onError;
					newCmd.rootPath = target.rootPath;
					_tpList.push(newCmd);
					//App.log.warn("尺寸超过["+target.max_size+"],已经增大放入队列末尾等待重新处理",1);
				}else {
					App.log.error("这个素材已经超过4096了，可以考虑不用这个素材了",1);
				}
			}else
			{
				App.log.info(info,1);
			}
			target = null;
			next(null);
			//var event:Event = new Event(CustomEvent.EVENT_BUILD_FAIL);
			//DialogAddResource.instance.dispatchEvent(new Event(CustomEvent.EVENT_BUILD_FAIL));
		}
		private function next(tp:TexturePacker):void
		{
			if (tp && tp.data!="" && tp.sheet!="")
			{
				var descriptionXML:XML = null;
				if (CatalogManager.instance.isEffectCatalog(_pdm.selectedId))
				{
					descriptionXML = LibraryManager.getDescriptionXML(tp.rootPath, _pdm.selectedId, int(cb_dirCount.selectedLabel), tp.center, com_moudle.selectedLabel,cb_effect_action.selectedLabel);
				}else{
					descriptionXML = LibraryManager.getDescriptionXML(tp.rootPath, _pdm.selectedId, int(cb_dirCount.selectedLabel), tp.center, com_moudle.selectedLabel);
				}
				var imgNum:int = 0;
				var pointStr:String = String(descriptionXML.@center);
				var temp:Array = pointStr.split(",");
				var point:Point = new Point(temp[0], temp[1]);
				var dir:int = descriptionXML.@dir;
				var frameInfo:String = "";
				var children:XMLList = descriptionXML.children();
				if (children && children[0]) 
				{	
					for (var i:int = 0; i < children.length(); i++) 
					{
						var child:XML = children[i] as XML;
						if(child.@id==tp.name) 
						{
							imgNum = child.@imgNum;
							frameInfo = child.@frameinfo;
							pointStr = child.@center;
							if (pointStr && pointStr!="") 
							{
								pointStr = String(child.@center);
								temp = pointStr.split(",");
								point.x = temp[0];
								point.y = temp[1];
							}
						}
					}
				}else{
					imgNum = descriptionXML.@imgNum;
					frameInfo = descriptionXML.@frameinfo;
				}
				DataManager.library.addResNode(descriptionXML);
				var animatData:Array=TexturePacker.plistData(tp.data);
				DataManager.library.createBinFile(tp.data.replace(".plist", ".bin"), animatData, dir, imgNum, frameInfo, point);
			}
			if (_tpList.length>0)
			{
				var tpcmd:TexturePacker = _tpList.removeAt(0);
				tpcmd.start();
			}else{
				App.log.info("全部生成完毕");
			}
		}
		private function handleChangeActoin(index:int):void
		{
			list_action.array = DataManager.action.model[com_moudle.selectedLabel];
			setCbActions();
		}
		private function handleListActionRender(item:Box,index:int):void 
		{
			var txt_name:TextInput = item.getChildByName("txt_name") as TextInput;
			var txt_frame:TextInput = item.getChildByName("txt_frame") as TextInput;
			var txt_id:TextInput = item.getChildByName("txt_id") as TextInput;
			var txt_amendment:TextInput = item.getChildByName("txt_amendment") as TextInput;
			if (list_action.array[index]) 
			{
				var ac:Action = list_action.array[index];
				item.visible = true;
				txt_name.text = ac.name;
				txt_frame.text = ac.frame;
				txt_id.text = ac.id;
				txt_amendment.text = ac.adjust;
			}else{
				item.visible = false;
			}
		}
		private function setFileIdAndName(fn:String):void 
		{
			var tempArr:Array = fn.split("(");
			if (tempArr.length>1)
			{
				txt_id.text = tempArr[1].replace(")","");;
				txt_name.text = tempArr[0];
			}else{
				txt_name.text = fn;
			}
		}
		
		public function get rootPath():String 
		{
			return _rootPath;
		}
		
		public function set rootPath(value:String):void 
		{
			_rootPath = value;
		}
	}
}