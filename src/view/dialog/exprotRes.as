package view.dialog 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import editor.manager.DataManager;
	import editor.manager.CatalogManager;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogExportResUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class exprotRes extends DialogExportResUI 
	{
		private var _xml:XML = null;
		private var _id:String = "";
		private var _catalogId:String = "";
		public function exprotRes(obj:Object) 
		{
			super();
			if (obj as XML) 
			{
				_xml = obj as XML;
				
			}else{
				_xml=DataManager.library.getResNode(obj.id,int(obj.catalog))
			}
			
			if (_xml) 
			{
				_id = txt_mapId.text = _xml.@export;
				_catalogId = _xml.@catalog;
			}
			btn_export.clickHandler = new Handler(export);
			App.stage.addEventListener(KeyboardEvent.KEY_DOWN,handleKeyEnter);
		}
		override public function close(type:String = null):void 
		{
			super.close(type);
			App.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyEnter);
		}
		private function handleKeyEnter(e:KeyboardEvent):void 
		{
			if (e.keyCode==Keyboard.ENTER) 
			{
				export();
			}
		}
		private function export():void 
		{
			if (_xml) 
			{
				
				var type:String = String(_xml.@type)==""?"png":"jpg";
				if (CatalogManager.instance.isEffectCatalog(int(_catalogId))) 
				{
					var _resName:String = DataManager.library.getPathByExportId(int(_catalogId),_xml.@export);
					var oldFile:File = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(int(_catalogId)) + "/" + _resName+"/export/" + _xml.@id + "."+type);					
					if (oldFile.exists) 
					{
						var newFile:File = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath +"effect/" + _xml.@id + ".png");
						oldFile.copyTo(newFile, true);
					}
					//DataManager.library.unuseNode(true, _xml);
					_xml.@unuse = '';
					DataManager.library.addResNode(_xml);
					App.log.info("资源已导出:","effect/"+_xml.@id + "."+type=="jpg"?"jpg":"png");
				}else{
					var xmllist:XMLList = _xml.children();
					for (var i:int = 0; i < xmllist.length(); i++) 
					{
						var child:XML = xmllist[i] as XML;
						if (DataManager.action.getActionPublish(ProjectConfig.adoptAction,child.@id))
						{
							_resName = DataManager.library.getPathByExportId(int(_catalogId),_xml.@export);
							oldFile = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(int(_catalogId)) + "/"+_resName+"/export/" + child.@id + ".png");
							if (oldFile.exists) 
							{
								var path:String = CatalogManager.instance.getOutputPathById(int(_catalogId));
								newFile = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath + path+"/" + _id + child.@id + ".png");
								oldFile.copyTo(newFile, true);
								_xml.@unuse = '';
								DataManager.library.addResNode(_xml);
								App.log.info("资源已导出:", path+"/" + _id + child.@id + "."+type);
							}
						}
					}
				}
				this.close();
			}
		}
	}
}