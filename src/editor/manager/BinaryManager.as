package editor.manager 
{
	import editor.BinInfo;
	import editor.FrameInfo;
	import editor.Texture;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import editor.tools.Logger;
	import view.window.Log;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class BinaryManager 
	{
		//private static var _instance:BinaryManager = null;
		
		public var data:Dictionary = new Dictionary;
		
		public function BinaryManager() 
		{
			
		}
		public function init():void 
		{
			//loadBiz("effect");
			loadBiz("cloth");
			//loadBiz("weapon");
			//loadBiz("wing");
		}
		/**
		 * 加载biz文件
		 * @param	name
		 */
		public function loadBiz(name:String):void 
		{
			App.log.info("开始加载BIZ:",name);
			var path:String = ProjectConfig.assetsPath+"/biz/"+name+".biz";
			var tempPath:String = File.applicationDirectory.resolvePath(path).nativePath;
			var file:File = new File(tempPath);
			var errorNum:int = 0;
			if (file.exists) 
			{
				data[name] = new Dictionary;
				var ba:ByteArray = new ByteArray();
					ba.endian = Endian.LITTLE_ENDIAN;
				var binStream:FileStream = new FileStream();
					binStream.open(file, FileMode.READ);
					binStream.readBytes(ba);
					binStream.close();
				
				var fileCount:int = ba.readInt();
				var fileName:int = 0;
				var placeholder:int = 0;
				for (var i:int = 0; i < fileCount; i++) 
				{
					try 
					{
						fileName = ba.readInt();
						var bin:FrameInfo = loadBin("",ba);
					}catch (e:Error){
						errorNum++;
						continue;
					}
				}
				ba = null;
				binStream = null;
				App.log.info(path+"加载结束，共"+fileCount+"个文件，存在:",errorNum,"个错误文件,最后加载的文件为:",fileName);
			}else{
				App.log.warn("不存在文件:",path);
			}
		}
		
		public function exportBiz():void 
		{
			
		}
		/**
		 * 加载单个描述文件
		 * @param	path 文件路径，ba参数传递后该值无用
		 * @param	ba 
		 * @return
		 */
		public function loadBin(path:String, ba:ByteArray = null):FrameInfo 
		{
			var bin:FrameInfo = new FrameInfo;
			var type:int = 0;
			if (!ba) 
			{
				type = 1;
				var binFilePath:String = File.applicationDirectory.resolvePath(path).nativePath;
				var file:File = new File(binFilePath);
				if (file.exists) 
				{
					ba = new ByteArray();
						ba.endian = Endian.LITTLE_ENDIAN;
					var binStream:FileStream = new FileStream();
						binStream.open(file, FileMode.READ);
						binStream.readBytes(ba);
						binStream.close();
					binStream = null;
				}else{
					trace("不存在bin文件:",file.nativePath);
				}
			}
			var ww:int = ba.readShort();
			var hh:int = ba.readShort();
			var imgNum:int = bin.imgNum = ba.readShort();//图片数量
			var dirCount:int = bin.dir = ba.readShort();//方向数
			var frameCount:int = ba.readShort();
			bin.frameCount = frameCount;
			for (var j:int = 0; j < imgNum; j++)
			{
				var frame_id:int=ba.readInt();
				var fx:int=ba.readShort();//小图在大图的x坐标
				var fy:int=ba.readShort();//小图在大图的y坐标
				var fw:int=ba.readShort();//小图在大图的占有宽度
				var fh:int=ba.readShort();//小图在大图的占有高度
				var ox:int=ba.readShort();// x方向偏移量
				var oy:int=ba.readShort();// y方向偏移量
				var sw:int=ba.readShort();// 原图width大小
				var sh:int=ba.readShort();//原图height大小
				var ro:int = ba.readShort();
				
				trace(frame_id, fx, fy, fw, fh, ox, oy, sw, sh, ro);
			}
			if (type==1) 
			{
				ba = null;
			}
			return bin;
		}
		
		/**
		 * 
		 * @param	inPath
		 * @param	outPath
		 */
		public function convertBin(inPath:String):void 
		{
			var targetFile:File = File.applicationDirectory.resolvePath(inPath);
			var bins:Array = [];
			if (targetFile.isDirectory) 
			{
				var files:Array = targetFile.getDirectoryListing();
				for (var l:int = 0; l < files.length; l++) 
				{
					var tmp:File = files[l] as File;
					
					if (tmp.extension=="bin") 
					{
						var jpg:File = File.applicationDirectory.resolvePath(tmp.nativePath.replace("." + tmp.extension, ".jpg"));
						if (jpg.exists)
						{
							bins.push(tmp);
							var newJpg:File = File.applicationDirectory.resolvePath(inPath + "/jpg/" + jpg.name);
							jpg.copyToAsync(newJpg, true);
						}
					}
				}
			}else{
				if (targetFile.extension=="bin") 
				{
					bins = [targetFile];
				}
			}
			for (var k:int = 0; k <bins.length ; k++) 
			{
				var bin:File = bins[k] as File;
				var outPath:String = bin.nativePath.replace(".bin", "_tmp.bin");
				var newBinFile:File = File.applicationDirectory.resolvePath(outPath);
				try 
				{
					var fs1:FileStream = new FileStream();
					var stream:FileStream = new FileStream();
					fs1.endian=stream.endian = Endian.LITTLE_ENDIAN;
					stream.open(bin, FileMode.READ);
					fs1.open(newBinFile, FileMode.WRITE);
					var _flag:int = stream.readByte();
					var dircount:int = stream.readByte();
					fs1.writeByte(dircount);
					fs1.writeByte(_flag);
					var imgCount:int = stream.readByte();//图片数量
					fs1.writeByte(imgCount);
					var frame:int=0
					for (var i:int = 0; i < imgCount; i++)
					{
						frame = stream.readByte();
						fs1.writeByte(frame);
					}
					for (i = 0; i < dircount;i++)
					{
						for (var j:int = 0; j < imgCount;j++ )
						{
							var xx:int = stream.readShort();
							fs1.writeShort(xx);
							var yy:int = stream.readShort();
							fs1.writeShort(yy);
							var ww:int = stream.readShort();
							fs1.writeShort(ww);
							var hh:int = stream.readShort();
							fs1.writeShort(hh);
							var cx:int = stream.readShort();
							fs1.writeShort(cx);
							var cy:int = stream.readShort();
							fs1.writeShort(cy);
							fs1.writeShort(1);//老素材没有旋转选项
						}
					}
					fs1.close();
					stream.close();
					stream = null;
				}catch (err:Error)
				{
					App.log.error(err.message)
				}
				trace("转换完成");
			}
		}
	}
}