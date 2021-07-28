package game.assets
{
	import adobe.utils.CustomActions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import game.data.DataManager;
	import editor.manager.CatalogManager;
	/**
	 * ...
	 * @author 李鹏辉
	 */
	public class AnimateManager 
	{
		private static var _animate:Dictionary = new Dictionary;
		private static var _actionInfo:Dictionary = new Dictionary;
		
		public function AnimateManager() 
		{
		}
		public static function getAnimateInfo(catalogId:int,resName:String,resId:String,action:String):Array 
		{
			var _path:String = ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(catalogId) + "/" + DataManager.library.getPathByExportId(catalogId,resId)+ "/export/" + action;
			return getBinAnimateInfo(_path);
		}
		public static function getBinAnimateInfo(path:String):Array 
		{
			var keyFrameData:Array = [];
			var frameData:Array = [];
			var file:File = File.applicationDirectory.resolvePath(path);
			if (!file.exists) 
			{
				App.log.error("不存在帧描述信息资源:",file.name);
				return null;
			}
			if (file.exists) 
			{
				var ba:ByteArray = new ByteArray();
					ba.endian = Endian.LITTLE_ENDIAN;
				var binStream:FileStream = new FileStream();
					binStream.open(file, FileMode.READ);
					binStream.readBytes(ba);
					binStream.close();
				var dirCount:int = ba.readByte();  	// 方向数
				ba.readByte();  					// 暂时无用
				var imgNum:int=ba.readByte(); 		// 图片数量
				var frameCount:int = 0;
				for (var i:int = 0; i < imgNum; i++) 
				{
					var temp:int=ba.readByte();
					keyFrameData[i] = temp;
					frameCount += temp;
				}
				//_actInfo.dirCount = dirCount;
				//_actInfo.frameCount = frameCount;
				var _frameCount:int = frameCount;
				i = 0;
				try 
				{
					for (i; i < dirCount; i++)
					{
						var index:int = 0; //单方向素材的帧信息
						frameData[i] = new Array;
						for (var j:int = 0; j < imgNum; j++)
						{
							var id:int = (i * imgNum) + j;
							var x:int=ba.readShort();
							var y:int=ba.readShort();
							var w:int=ba.readShort();
							var h:int=ba.readShort();
							var cx:int=ba.readShort();
							var cy:int=ba.readShort();
							var rotated:int = ba.readShort();
							for (var k:int = 0; k < keyFrameData[j]; k++) 
							{
								frameData[i][index] = new Array();
								frameData[i][index][0]=(x);
								frameData[i][index][1]=(y);
								frameData[i][index][2]=(w);
								frameData[i][index][3]=(h);
								frameData[i][index][4]=(cx);
								frameData[i][index][5]=(cy);
								frameData[i][index][6]=(rotated);
								index++;
							}
						}
					}
				}catch (err:Error)
				{
					App.log.error("出现异常",err.message);
					return null;
				}
			}
			return frameData;
		}
	}

}
