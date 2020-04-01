package view.object 
{
	import editor.log.Logger;
	import game.data.DataManager;
	import game.data.configuration.MapDesp;
	import flash.data.EncryptedLocalStore;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import game.library.LibraryManager;
	import morn.core.handlers.Handler;
	import morn.core.managers.ResLoader;
	import view.window.Log;
	import view.window.MapEdit;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class MapObject extends Sprite 
	{
		private var _loaders:Array = [];
		private var _mapdesp:MapDesp = null;
		private var _mapId:String = "";
		
		private var _marginLoadedNum:int = 0;
		private var _time1:int = 0;
		private var _urls:Array = [];
		
		private var _progressFun:Function = null;
		private var _errorFun:Function = null;
		private var _successFun:Function = null;
		public function MapObject() 
		{
			super();
			mouseChildren = false;
		}
		public function clean():void 
		{
			_urls = [];
			_marginLoadedNum = 0;
			for (var j:int = numChildren; j >0 ; j--) 
			{
				this.removeChildAt(numChildren - 1);
			}
			for (var i:int = 0; i < _loaders.length; i++) 
			{
				(_loaders[i] as Loader).unload();
			}
			_loaders = [];
		}
		public function init(md:MapDesp,mapId:String,pattern:String):void 
		{
			clean();
			_mapdesp = md;
			_mapId = mapId;
			var tempHeight:int = 0;
			var tempWidth:int = 0;
			
			var path:String = ProjectConfig.libraryPath + "地图/" + mapId + ".jpg";
			if (pattern==MapEdit.MAP_PATTERN_RES) 
			{
				var arr:Array = DataManager.library.getResCatalogNode(5);
				for (var i:int = 0; i < arr.length; i++) 
				{
					var xml:XML = arr[i];
					var export:String = xml.@export;
					var name:String = xml.@name;
					if (export==mapId) 
					{
						path=ProjectConfig.libraryPath + "地图/" + name + ".jpg";
						break;
					}
				}
			}
			App.log.info("加载地图:",path);
			var file:File =File.applicationDirectory.resolvePath(path);
			if (file.exists) 
			{
				App.loader.loadBMD("file:///"+file.nativePath, new Handler(handlerMapLoadedByFile), new Handler(handleImgLoadProgress), new Handler(handleImgLoadError), false);
			}else {
				file = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath + "map/" + mapId);
				if (file.exists&&file.isDirectory) 
				{
					var files:Array = file.getDirectoryListing();
					_time1 = getTimer();
					var reg:RegExp = new RegExp("\\\\","g");
					for (var k:int = 0; k < files.length; k++) 
					{
						var img:File = files[k];
						var obj:Object = new Object;
						obj.url = img.nativePath.replace(reg, "/");
						obj.type = ResLoader.BMD;
						obj.size = img.size;
						_urls.push(obj);
					}
					App.mloader.loadAssets(_urls, new Handler(handlerMapLoadedByFolder), new Handler(handleImgLoadProgress), new Handler(handleImgLoadError));
				}else {
					App.log.error("资源不存在");
				}
			}
		}
		private function handleImgLoadError(msg:*):void 
		{
			if (_errorFun is Function) 
			{
				_errorFun(msg);
			}
			trace(msg);
		}
		private function handleImgLoadProgress(progress:*):void 
		{
			if (_progressFun is Function) 
			{
				_progressFun(progress);
			}
		}
		private function handlerMapLoadedByFile(bmd:BitmapData):void 
		{
			var bm:Bitmap = new Bitmap(bmd);
			addChild(bm);
			this.width = bm.width;
			this.height = bm.height;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function handlerMapLoadedByFolder():void
		{
			for (var i:int = 0; i < _urls.length; i++)
			{
				var obj:Object = _urls[i];
				var url:String = obj.url;
				var bmd:BitmapData = App.mloader.getResLoaded(obj.url);
				
				url = url.replace(ProjectConfig.assetsPath + "map/" + _mapId, "");
				var fileName:String = url.replace(".jpg", "");
				var temp:Array = fileName.split("_");
				if (temp.length>1) 
				{
					var row:int = temp[1].replace("r","");
					var cel:int = temp[2].replace("c", "");
					var ground:Bitmap = new Bitmap(bmd);
					ground.x = (cel-1) * MapDesp.GROUND_W;
					ground.y = (row-1) * MapDesp.GROUND_H;
					addChild(ground);
				}
			}
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
		}
		
		public function get progressFun():Function 
		{
			return _progressFun;
		}
		
		public function set progressFun(value:Function):void 
		{
			_progressFun = value;
		}
		
		public function get errorFun():Function 
		{
			return _errorFun;
		}
		
		public function set errorFun(value:Function):void 
		{
			_errorFun = value;
		}
		
		public function get successFun():Function 
		{
			return _successFun;
		}
		
		public function set successFun(value:Function):void 
		{
			_successFun = value;
		}
	}

}