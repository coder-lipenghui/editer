package view.dialog 
{
	import flash.data.EncryptedLocalStore;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.geom.Matrix;
	import game.data.DataManager;
	import editor.manager.LibraryManager;
	import game.tools.other.MapTools;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogExportMapUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class exportMapRes extends DialogExportMapUI 
	{
		private var _obj:Object = null;
		private var _mapId:String = "";
		private var _mapName:String = "";
		public function exportMapRes(obj:Object) 
		{
			super();
			_obj = obj;
			var xml:XML = null;
			if (_obj as XML) 
			{
				xml = _obj as XML;
			}else{
				xml=DataManager.library.getResNode(obj.id,5)
			}
			if (xml) 
			{
				_mapId = txt_mapId.text = xml.@export;
				_mapName = xml.@name;
			}
			btn_export.clickHandler = new Handler(export);
			
		}
		private function export():void 
		{
			if (txt_mapId.text=="")
			{
				App.log.warn("请填写地图编号");
				return;
			}
			if (!ck_mapo.selected || ck_minimap.selected) 
			{
				var url:String = ProjectConfig.libraryPath + "地图/" +_mapName+".jpg";
				App.loader.loadBMD(url, new Handler(hanlderMapLoaded), new Handler(handlerMapLoadProgress), new Handler(handlerMapLoadError), false);
			}
			var mapo:File = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath + "地图/" + _mapName+".mapo");
			if (mapo.exists) 
			{
				if (txt_mapId.text!="") 
				{
					var newFile:File = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath + "/map/" + txt_mapId.text + ".mapo");
					mapo.copyTo(newFile, true);
					var dataFile:File = File.applicationDirectory.resolvePath(ProjectConfig.dataPath + "../map/" + txt_mapId.text + ".mapo");
					mapo.copyTo(dataFile, true);
					txt_msg.text = "mapo导出成功";
				}else{
					App.log.warn("不存在mapId，未导出mapo");
				}
			}
		}
		private function hanlderMapLoaded(bmd:BitmapData):void 
		{
			txt_msg.text = "正在生成小地图...";
			MapTools.exportMiniMap(bmd, txt_mapId.text);
			txt_msg.text = "小地图导出完成。";
			if (!ck_minimap.selected) 
			{
				txt_msg.text = "开始切图,非异步操作会有卡顿，请稍后。";
				var path:String = ProjectConfig.assetsPath + "/map/" + txt_mapId.text;
				var oldFolder:File = File.applicationDirectory.resolvePath(path);
				if (oldFolder.exists) 
				{
					oldFolder.deleteDirectory(true);
				}
				App.timer.doOnce(1500,function ():void 
				{
					MapTools.exportMap(bmd, txt_mapId.text);
					bmd.dispose();
					bmd = null;
					txt_msg.text = "地图导出完成。";
					var xml:XML = new XML(" <assets/>");
					xml.@catalog = 5;
					xml.@id = _mapName;
					xml.@name = _mapName;
					xml.@export = txt_mapId.text;
					DataManager.library.addResNode(xml);
				});
			}else{
				bmd.dispose();
				bmd = null;
			}
		}
		private function handlerMapLoadProgress(progress:Number):void 
		{
			txt_msg.text="正在加载地图:"+(progress*100).toFixed(2)+"%";
		}
		private function handlerMapLoadError(msg:String):void 
		{
			txt_msg.text = msg;
		}
	}

}