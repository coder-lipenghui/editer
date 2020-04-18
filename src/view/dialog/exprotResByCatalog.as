package view.dialog 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import view.auto.dialog.DialogExportAssetsUI;
	import morn.core.handlers.Handler;
	import game.data.DataManager;
	import game.library.CatalogManager;
	/**
	 * ...
	 * @author ...
	 */
	public class exprotResByCatalog extends DialogExportAssetsUI 
	{
		//private var id:String = "";
		private var _catalogId:int = -1;
		private var _total:int = 0;
		private var _curr:int =0;
		public function exprotResByCatalog(catalogId:int) 
		{
			super();
			_catalogId = catalogId;
			var catalog:*= CatalogManager.instance.getCatalogById(_catalogId);
			if (catalog) 
			{
				txt_msg.text = "是否将[ "+catalog.name+" ]下的资源全部导出？";
			}else{
				txt_msg.text = "未知目录:"+_catalogId;
			}
			
			btn_ok.clickHandler = new Handler(export);
		}
		private function export():void 
		{
			if (_catalogId<0) 
			{
				App.log.warn("不存在目录:",_catalogId);
				return;
			}
			var assets:Array = DataManager.library.getAssetsByCatalogId(_catalogId);
			_total = assets.length;
			for (var j:int = 0; j < assets.length; j++) 
			{
				var obj:Object = assets[j];
				if (obj) 
				{
					var id:String = obj.id+"";
					var action:String = obj.action + "";
					var oldFile:File = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(int(_catalogId)) + "/" + obj.folderName+"/export/" + action + ".png");
					if (oldFile.exists) 
					{
						var outPath:String=CatalogManager.instance.getOutputPathById(_catalogId)+"/" + id + ".png"
						var newFile:File = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath +outPath);
						oldFile.addEventListener(Event.COMPLETE,copyComplete);
						oldFile.copyToAsync(newFile,true);
					}
				}
			}
			this.close();
		}
		private function copyComplete(e:Event):void 
		{
			var target:File = e.target as File;
			App.log.info("资源已导出:",target.nativePath);
		}
	}
}