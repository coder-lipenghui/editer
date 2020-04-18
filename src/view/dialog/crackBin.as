package view.dialog 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.PNGEncoderOptions;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogCrackUI;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class crackBin extends DialogCrackUI 
	{
		private static var _instance:crackBin = null;
		private var _files:Array = [];
		private var _pngfiles:Dictionary = new Dictionary;
		private var _rootFolderPath:String = ""; 
		private var _totalPng:int = 0;
		private var _totalBin:int = 0;
		private var _currStep:int = 0;
		public function crackBin() 
		{
			super();
			btn_select.clickHandler = new Handler(handlerSelect);
			btn_start.clickHandler = new Handler(handlerStart);
		}
		private function handlerSelect():void 
		{
			var file:File = null;
			if (_rootFolderPath=="") 
			{
				file = File.desktopDirectory;
			}else
			{
				file =File.applicationDirectory.resolvePath(_rootFolderPath);
			}
			function handlerSelected(e:Event):void 
			{
				var folder:File = File.applicationDirectory.resolvePath(e.target.nativePath);
				txt_file.text = _rootFolderPath = folder.nativePath;
				if (folder.isDirectory) 
				{
					var files:Array = folder.getDirectoryListing();
					for (var i:int = 0; i < files.length; i++) 
					{
						var png:File = files[i] as File;
						if (png.extension=="png") 
						{
							_totalBin++;
						}
					}
					_currStep = 0;
					txt_file.text = "当前进度: 0/" + _totalBin;
				}else{
					_totalBin = 1;
					_currStep = 0;
					
				}
				
			}
			if (ck_batch.selected) 
			{
				file.browseForDirectory("请选择资源目录");
			}else{
				file.browseForOpen("请选择png");
			}
			
			file.addEventListener(Event.SELECT,handlerSelected);
		}
		
		private function handlerStart():void
		{
			var folder:File = File.applicationDirectory.resolvePath(_rootFolderPath);
			if (folder.isDirectory) 
			{
				_files=folder.getDirectoryListing();
			}else{
				_files = [folder];
			}
			for (var i:int = 0; i < _files.length; i++) 
			{
				var pngFile:File = _files[i] as File;
				if (pngFile.extension=="png") 
				{
					var reg:RegExp = new RegExp("\\\\","g");
					var tempPath:String = pngFile.nativePath.replace(reg, "/");
					var loader:Loader = new Loader;
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handlerPngLoad);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handlerPngLoadError);
					loader.load(new URLRequest(pngFile.nativePath));
					_pngfiles[tempPath] = loader;
					reg = null;
				}
			}
		}
		private function handlerPngLoadError(e:Event):void 
		{
			App.log.warn("[ 加载异常 ]");
		}
		private function handlerPngLoad(e:Event):void
		{
			var loaderinfo:LoaderInfo = e.target as LoaderInfo;
			var bm:Bitmap = loaderinfo.content as Bitmap;
			var path:String = loaderinfo.url.replace("file:///", "");
			createNewImg(path, bm);
		}
		private function createNewImg(path:String,source:Bitmap):void 
		{
			//获取对应名称的binbin文件
			var binFilePath:String = path.replace(".png", ".bin");
			var binFile:File = File.applicationDirectory.resolvePath(binFilePath);
			var tempArr:Array = path.split("/");
			var fileName:String = tempArr[tempArr.length - 1];
			var id:int = int(fileName.replace(".png", ""));
			var fristId:int = int(int(fileName.replace(".png", "")) / 100);
			var secondId:int = id % 100;
			//var folderNameArr:Array = txt_action.text.split(",");
			var folderNameArr:Array = ["待机", "走路", "跑步", "预备", "攻击", "施法", "受伤", "死亡", "打坐", "挖矿", "骑待", "骑走", "骑跑", "跳跃"];
			//这个是千年的动作列表
			//folderNameArr=["待机", "走路", "跑步", "预备","拳","腿","刀","斧","剑","棍","弓","抱拳","打坐","受伤","死亡","待机2","攻击","死亡2" ]
			var folderName:String = folderNameArr[secondId];
			//trace(fristId,folderName);
			if (binFile.exists)
			{
				//解析bin文件
				try 
				{
					var stream:FileStream = new FileStream();
					stream.endian = Endian.LITTLE_ENDIAN;
					stream.open(binFile, FileMode.READ);
					var _flag:int = stream.readByte(); 
					var dircount:int = stream.readByte();
					var imgCount:int = stream.readByte(); //图片数量
					var framecount:int = 0;
					var frameData:Array = [];
					var frame:int=0
					for (var i:int = 0; i < imgCount; i++)
					{
						frame = stream.readByte();
						framecount += frame;
					}
					for (i = 0; i < dircount; i++ ) 
					{
						for (var j:int = 0; j < imgCount;j++ )
						{
							//按照bin文件描述的位置copyPixes图像到新的bmd上
							id = i * imgCount+j;
							var xx:int = stream.readShort();
							var yy:int = stream.readShort();
							var ww:int = stream.readShort();
							var hh:int = stream.readShort();
							var cx:int = stream.readShort();
							var cy:int = stream.readShort();
							if (binFile.parent.nativePath) 
							{
								_rootFolderPath = binFile.parent.nativePath;
							}
							var newPngFilePath:String = _rootFolderPath + "/" + fristId + "/" + folderName+"/" + (id<10?"0"+id:id+"") + ".png";
							if (!File.applicationDirectory.resolvePath(newPngFilePath).exists) 
							{
								var newBmd:BitmapData = new BitmapData(512, 512,true,0x00FFFFFF);
								newBmd.copyPixels(source.bitmapData, new Rectangle(xx, yy, ww, hh), new Point(256 + cx, 256 + cy));
								try 
								{
									var compressor:*=new PNGEncoderOptions(true);
									var byteArray:ByteArray = newBmd.encode(newBmd.rect,compressor);
									var file:File = new File(File.applicationDirectory.resolvePath(newPngFilePath).nativePath);
									var fs:FileStream = new FileStream();
									fs.open(file,FileMode.WRITE);
									fs.writeBytes(byteArray);
									fs.close();
									fs = null;
									file = null;
									newBmd.dispose();
									byteArray = null;
									App.log.info("成功:",newPngFilePath);
								}catch (e:Error)
								{
									App.log.warn("[ 创建素材出现异常 ]"); 
									App.log.warn(e.message)
								}
								newBmd = null;
							}
						}
					}
					stream.close();
					stream = null;
					if (_pngfiles[path])
					{
						var pngFile:File = File.applicationDirectory.resolvePath(binFile.nativePath.replace(".bin", ".png"));
						if (pngFile.exists && ck_delete.selected) 
						{
							binFile.moveToTrash();
							pngFile.moveToTrash();
						}
						var loader:Loader = _pngfiles[path] as Loader;
						loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handlerPngLoad);
						loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handlerPngLoadError);
						_currStep++;
						loader.unload();
						loader = null;
						_pngfiles[path] = null;
						txt_file.text = "当前进度: " + _currStep + "/" + _totalBin + "(" + int((_currStep / _totalBin) * 100) + "%)";
						
					}
				}catch (err:Error)
				{
					App.log.error(err.message)
				}
			}else
			{
				App.log.warn("[ 没有找到bin文件 ]");
			}
			//生成新的png素材。
		}
		static public function get instance():crackBin 
		{
			if (!_instance) 
			{
				_instance = new crackBin();
			}
			return _instance;
		}
		
		static public function set instance(value:crackBin):void 
		{
			_instance = value;
		}
	}

}