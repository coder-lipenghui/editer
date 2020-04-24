package game.data.configuration 
{
	import game.data.CmdManager;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import editor.log.Logger;
	import game.data.DataManager;
	import game.library.LibraryManager;
	import view.window.Log;
	/**
	 * 地图格子描述文件：
	 * 阻挡、遮罩信息、其他信息
	 * @author 3464285@gmail.com
	 */
	public class MapDesp 
	{
		public var mapId:String = "";
		public var mapRes:String = "";
		public var mapObj:String = "";
		
		public var mapVersion:int = 0;
		
		public var mapWidth:int = 0;
		
		public var mapHeight:int = 0;
		
		public var mapCellH:int = 0;
		
		public var mapCellV:int = 0;
		
		public var logicCell:Array = [];
		
		public var mapGroundW:int = 0;
		
		public var mapGroundH:int = 0;
		
		public var mapGroundDir:int = 0;
		
		public var loaded:Boolean = false;
		
		private var _path:String = "";
		
		public function MapDesp() 
		{
			
		}
		public function clean():void 
		{
			loaded = false;
			logicCell = [];
		}
		public function doImport(id:String,cfg:String,res:String,path:String):Boolean 
		{
			App.log.info("开始读取地图描述文件:" + path);
			mapId = id.replace("[","");
			mapRes = res;
			_path = path;
			var file:File = File.applicationDirectory.resolvePath(path);
			//mapRes = file.name.replace("."+file.extension,"");
			if (file.exists) 
			{
				var mapdata:Object = { };
				
				var byteArray:ByteArray = new ByteArray();
					byteArray.endian = Endian.LITTLE_ENDIAN;
					byteArray.position = 0;
					
				var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.READ);
					fileStream.readBytes(byteArray)
					fileStream.close();
					
				mapVersion = byteArray.readShort();
				ProjectConfig.GROUND_W = byteArray.readShort();  	//在c++代码中 此值其实是个无用的值
				ProjectConfig.GROUND_H = byteArray.readShort(); 	//在c++代码中 此值其实是个无用的值
				mapCellH = byteArray.readShort();   //横向格子数量 __height
				mapCellV = byteArray.readShort();  	//纵向格子数量 __width
				mapGroundDir = byteArray.readByte();
				
				var size:int;
				var i:int;
				
				size = byteArray.readInt();
				
				var bad:ByteArray = new ByteArray;
				var ind:int = 0;
				var b:int;
				var l:int;
				while (ind < size) {
					b = byteArray.readUnsignedByte();
					l = byteArray.readUnsignedByte();
					for (i = 0; i < l; i++) {
						bad.writeByte(b);
					}
					ind = ind + 2;
				}
				bad.position = 0;
				for (var h:int = 0; h < mapCellV; h++) {
					for (var w:int = 0; w < mapCellH; w++) {
						var flags:int = bad.readUnsignedByte();
						if (logicCell[h] == undefined) {
							logicCell[h] = new Array;
						}
						if (flags) {
							logicCell[h][w] = flags;
						}else{
							logicCell[h][w] = 0;
						}
					}
				}
				bad = null;
				fileStream = null;
				byteArray = null;
				loaded = true;
				return loaded;
			}
			return loaded;
		}
		/**
		 * 导出mapo
		 */
		public function doExport():void 
		{
			writeBin();
		}
		/**
		 * 根据地图素材实际大小构建基础描述信息
		 * @param	mw
		 * @param	mh
		 */
		public function build(mw:int,mh:int):void 
		{
			mapWidth = mw;
			mapHeight = mh;
			mapCellH = int(mw / ProjectConfig.CELL_W);
			mapCellV = int(mh / ProjectConfig.CELL_H);
			for (var i:int = 0; i < mapCellV; i++) {
				for (var j:int = 0; j < mapCellH; j++) {
					if (logicCell[i] == undefined) {
						logicCell[i] = new Array;
					}
					logicCell[i][j] = 0;
				}
			}
		}
		public function getLogicInfo(x:int,y:int):int 
		{
			if (logicCell[y] && logicCell[y][x]>-1) 
			{
				return logicCell[y][x];
			}
			return -1;
		}
		private function writeBin():void
		{
			var row:int = mapCellH;
			var cow:int = mapCellV;
			var arr:Array = new Array;
			for (var i:int = 0; i < cow; i++ )
			{
				for (var j:int = 0; j < row; j++ )
				{
					arr[i*row+j] = logicCell[i][j];
				}
			}
			var ba:ByteArray = new ByteArray;
			ba.endian = Endian.LITTLE_ENDIAN;
			ba.writeShort(4);
			ba.writeShort(ProjectConfig.GROUND_W);
			ba.writeShort(ProjectConfig.GROUND_H);
			
			ba.writeShort(row);
			ba.writeShort(cow);
			
			ba.writeByte(0);
			
			var size:int = zip_tile2(row, cow, arr);
			ba.writeInt(size);
			ba=zip_tile(row, cow, arr,ba);
			var filestream:FileStream = new FileStream;
			var mapoFile:File = new File(_path);
			filestream.open(mapoFile, FileMode.WRITE);
			filestream.writeBytes(ba, 0, ba.length);
			filestream.close();
			filestream = null;
			ba = null;
			var xml:XML = DataManager.library.getResNode(mapId, 5);
			if (xml) 
			{
				var export:String = String(xml.@export);
				if (export!="") 
				{
					var resMapoFile:File = File.applicationDirectory.resolvePath(ProjectConfig.assetsPath + "map/" + export + ".mapo");
					if (resMapoFile.exists) 
					{
						App.log.info("同步map/"+export+".mapo成功");
					}
					mapoFile.copyTo(resMapoFile, true);
				}else{
					App.log.warn("不存在导出ID");
				}
			}
		}
		private function zip_tile(ow:uint, oh:uint, arr:Array,ba:ByteArray):ByteArray
		{			
			var out:int = 0;
			var bd:uint = 0;
			var l:uint = 0;
			var str:String = "";
			for (var h:int = 0; h < oh; h++ )
			{
				for (var w:int = 0; w < ow; w++)
				{
					if (arr[h * ow + w] != bd)
					{
						if (l > 0)
						{
							ba.writeByte(bd);
							ba.writeByte(l);
						}
						bd = arr[h * ow + w];
						l = 1;
					}
					else
					{
						l++;
						if (l > 250)
						{
							ba.writeByte(bd);
							ba.writeByte(l);
							l = 0;
						}
					}
				}
				if (l > 0)
				{
					ba.writeByte(bd);
					ba.writeByte(l);
				}
				bd = 0;
				l = 0;
			}
			return ba;
		}
		private function zip_tile2(ow:uint, oh:uint, arr:Array):int
		{			
			var out:int = 0;
			var bd:uint = 0;
			var l:uint = 0;
			var str:String = "";
			for (var h:int = 0; h < oh; h++ )
			{
				for (var w:int = 0; w < ow; w++)
				{
					if (arr[h * ow + w] != bd)
					{
						if (l > 0)
						{
							out += 2;
						}
						bd = arr[h * ow + w];
						l = 1;
					}
					else
					{
						l++;
						if (l > 250)
						{
							l = 0;
							out += 2;
						}
					}
				}
				if (l > 0)
				{
					out += 2;
				}
				bd = 0;
				l = 0;
			}
			return out;
		}
		
	}
		
}