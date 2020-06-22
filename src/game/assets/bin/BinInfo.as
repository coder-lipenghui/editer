package game.assets.bin 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import game.assets.animat.AnimatInfo;
	import game.library.LibraryManager;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class BinInfo
	{
		public var inited:Boolean = false;
		public var path:String = "";
		public var dirCount:int = 0;
		public var tmp:int = 0;
		public var imgNum:int = 0;
		
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
			dirCount = ba.readByte();  	// 方向数
			tmp=ba.readByte();  		// 暂时无用
			imgNum=ba.readByte(); 		// 图片数量
			var frameCount:int = 0;
			for (var i:int = 0; i < imgNum; i++) 
			{
				var temp:int=ba.readByte();
				keyFrameData[i] = temp;
				frameCount += temp;
			}
			i = 0;
			try 
			{
				for (i; i < dirCount; i++)
				{
					var index:int = 0;
					frameData[i] = [];
					for (var j:int = 0; j < imgNum; j++)
					{
						var x:int=ba.readShort();
						var y:int=ba.readShort();
						var w:int=ba.readShort();
						var h:int=ba.readShort();
						var cx:int=ba.readShort();
						var cy:int=ba.readShort();
						var rotated:int = ba.readShort();
						frameData[i][j] = [x,y,w,h,cx,cy,rotated];
					}
				}
				inited = true;
			}catch (err:Error)
			{
				App.log.error("出现异常", err.message);
				inited = false;
			}
		}
		
		public function changeCenter(center:Point):void 
		{
			if (inited) 
			{
				var file:File = File.applicationDirectory.resolvePath(this.path);
				var binStream:FileStream = new FileStream();
				binStream.endian=Endian.LITTLE_ENDIAN;
				binStream.open(file,FileMode.WRITE);
				
				binStream.writeByte(dirCount);  	// 方向数
				binStream.writeByte(tmp);  			// 暂时无用
				binStream.writeByte(imgNum); 		// 图片数量
				
				for (var i:int = 0; i < keyFrameData.length; i++) 
				{
					binStream.writeByte(keyFrameData[i]);
				}
				for (var j:int=0; j < dirCount; j++)
				{
					for (var k:int = 0; k <imgNum; k++) 
					{
						var info:Array = frameData[j][k];
						binStream.writeShort(info[0]);			//x
						binStream.writeShort(info[1]);			//y
						binStream.writeShort(info[2]);			//w
						binStream.writeShort(info[3]);			//h
						binStream.writeShort(info[4]+center.x); //cx
						binStream.writeShort(info[5]+center.y); //cy
						binStream.writeShort(info[6]);			//rotated
					}
				}
				binStream.close();
				App.log.info("中心点已修改");
			}
		}
	}
}