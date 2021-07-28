package view.dialog 
{
	import flash.filesystem.File;
	import game.data.DataManager;
	import editor.manager.CatalogManager;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogDeleteResUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class delRes extends DialogDeleteResUI 
	{
		private var _catalogId:int = 0;
		private var _resId:int = 0;
		private var _xml:XML = null;
		public function delRes(obj:Object) 
		{
			super();
			if (obj as XML) 
			{
				_xml = obj as XML;
				_catalogId = _xml.@catalog;
				_resId = _xml.@id;
			}else{
				_catalogId = obj.catalog;
				_resId = obj.id;
				_xml = DataManager.library.getResNode(_resId+"", _catalogId);
			}
			
			txt_msg.text = "是否删除资源:" + _resId;
			if (_xml) 
			{
				txt_msg.text = txt_msg.text + ","+_xml.@name;
			}
			btn_ok.clickHandler = new Handler(handlerDeleteRes);
		}
		public function handlerDeleteRes():void 
		{
			if (_xml && (ck_release.selected || ck_library.selected)) 
			{
				if (ck_release.selected) 
				{
					var xmllist:XMLList = _xml.children();
					for (var i:int = 0; i < xmllist.length(); i++) 
					{
						var child:XML = xmllist[i] as XML;
						var path:String = "";
						switch (int(_catalogId)) 
						{
							case 2:
							case 3:
							case 7:
								path = "cloth";
								break;
							case 8:
								path = "weapon";
								break;
							case 9:
								path = "wing";
								break;
							case 10:
							case 11:
							case 12:
							case 13:
								path = "effect";
							break;
							default:
						}
						var resFile:File = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath + path + "/" + _resId + child.@id + ".png");
						if (resFile.exists) 
						{
							resFile.deleteFile();
						}
					}
					DataManager.library.unuseNode(_xml);
					App.log.info("已删除res中的资源");
				}
				
				if (ck_library.selected) 
				{
					var _resName:String = DataManager.library.getPathByExportId(int(_catalogId),_xml.@export);
					var oldFile:File = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(int(_catalogId)) + "/"+_resName);
					if (oldFile.exists && oldFile.isDirectory) 
					{
						oldFile.deleteDirectory(true);
						trace("已经删掉资源库中的文件:",oldFile.name);
					}
					DataManager.library.delResNode(_catalogId, _resId);
					App.log.info("已删除");
				}
				this.close();
			}
		}
	}

}