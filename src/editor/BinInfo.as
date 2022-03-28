package editor 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import editor.AnimatInfo;
	import editor.manager.LibraryManager;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class BinInfo
	{
		public var inited:Boolean = false;
		public var path:String = "";
		public var dirCount:int = 0;
		public var imgNum:int = 0;
		
		public var id:int = 0;
		public var ww:int = 0;
		public var hh:int = 0;
		public var frameCount:int = 0;
		
		public var keyFrameData:Array = [];
		public var frameData:Array = [];
		
		public function BinInfo(path:String) 
		{
			this.path = path;
			var file:File = File.applicationDirectory.resolvePath(this.path);
			if (!file.exists) 
			{
				return;
			}
			var ba:ByteArray = new ByteArray();
				ba.endian = Endian.LITTLE_ENDIAN;
			var binStream:FileStream = new FileStream();
				binStream.open(file, FileMode.READ);
				binStream.readBytes(ba);
				binStream.close();
				
			var frameCount:int = 0;
			var keyFrameData:Array = [];
			
			id=ba.readInt();			//file_id
			ww=ba.readShort();			//file_width=ba->readShort(); 	//文件尺寸 width
			hh = ba.readShort();		//file_height=ba->readShort();	//文件尺寸 height
			frameCount=ba.readShort();	//方向数×图片数
			dirCount=ba.readShort();	//方向数
			imgNum = ba.readShort();	//图片数量
			
			try 
			{
				for (var i:int=0; i < dirCount; i++)
				{
					for (var j:int = 0; j < imgNum; j++)
					{
						var index:int = (i * imgNum) + j;
						var fraemId:int=ba.readInt();
						var x:int=ba.readShort();
						var y:int=ba.readShort();
						var w:int=ba.readShort();
						var h:int=ba.readShort();
						var cx:int=ba.readShort();
						var cy:int = ba.readShort();
						var sw:int=ba.readShort();// 原图width大小
						var sh:int=ba.readShort();//原图height大小
						var rotated:int = ba.readShort();
						frameData[index] = [fraemId, x, y, w, h, cx, cy, sw, sh, rotated];
					}
				}
				inited = true;
			}catch (err:Error)
			{
				inited = false;
				trace("出现异常");
			}
		}
		
		public function changeCenter(center:Point):void 
		{
			if (inited) 
			{
				var file:File = File.applicationDirectory.resolvePath(this.path);
				if (file.exists) 
				{
					file.deleteFile();
				}
				var binStream:FileStream = new FileStream();
				binStream.endian=Endian.LITTLE_ENDIAN;
				binStream.open(file,FileMode.WRITE);
				
				binStream.writeInt(id);
				binStream.writeShort(ww);
				binStream.writeShort(hh);
				binStream.writeShort(imgNum * dirCount);
				binStream.writeShort(dirCount);
				binStream.writeShort(imgNum);
				
				for (var i:int=0; i < dirCount; i++)
				{
					for (var j:int = 0; j < imgNum; j++)
					{
						var index:int = (i * imgNum) + j;
						var info:Array = frameData[index];
						binStream.writeInt(info[0]);
						binStream.writeShort(info[1]);
						binStream.writeShort(info[2]);
						binStream.writeShort(info[3]);
						binStream.writeShort(info[4]);
						binStream.writeShort(info[5] + center.x);
						binStream.writeShort(info[6] + center.y);
						binStream.writeShort(info[7]);
						binStream.writeShort(info[8]);
						binStream.writeShort(info[9]);
					}
				}
				binStream.close();
				App.log.info("中心点已修改");
			}
		}
	}
}