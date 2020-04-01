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
	public class Bin 
	{
		
		public function Bin() 
		{
			
		}
		public function create(inputPath:String,outputPath:String,fileId:String,actionId:String):void 
		{
			
		}
		
		private function lhwc(inputPath:String,outputPath:String,animatXml:XML):void
		{
			//var result:Array =getPlist(inputPath);
			//if (result.length>0)
			//{
				//var dic:Dictionary = new Dictionary();
				//var xml:XML = animatXml;
				//var dir:int = xml.@dir;
				//var imgNum:int = 0;
				//var frameinfo:String = "";
				//var centerStr:String = xml.@center;
				//if (actionId && actionId!="") 
				//{
					//fileId = fileId + actionId;
					//var xmlList:XMLList = xml.children();
					//for (var i:int = 0; i < xmlList.length(); i++) 
					//{
						//var x:XML = xmlList[i] as XML;
						//if (x.@id==fileId) 
						//{
							//imgNum = x.@picnum;
							//frameinfo = x.@frameinfo;
							//break;
						//}
					//}
				//}else {
					//imgNum = xml.@picnum;
					//frameinfo = xml.@frameinfo;
				//}
				//var ba:ByteArray = new ByteArray();
				//ba.endian = Endian.LITTLE_ENDIAN;
				//ba.writeByte(dir);
				//ba.writeByte(dir);
				//ba.writeByte(imgNum);
				//var frameArr:Array = frameinfo.split(",");
				//var pointArr:Array = centerStr.split(",");
				//var center:Point = new Point(pointArr[0], pointArr[1]);
				//for (var k:int = 0; k < imgNum; k++) 
				//{
					//ba.writeByte(frameArr[k]);
				//}
				//for (var j:int = 0; j < dir; j++)
				//{
					//for (var l:int = 0; l < imgNum; l++)
					//{
						//var id:int = (j * imgNum) + l;
						//var pfd:Animat = result[id];
						//if (pfd)
						//{
							//ba.writeShort(pfd.x);
							//ba.writeShort(pfd.y);
							//ba.writeShort(pfd.w);
							//ba.writeShort(pfd.h);
							//ba.writeShort(pfd.oldX-center.x);
							//ba.writeShort(pfd.oldY-center.y);
							//ba.writeShort(pfd.rotated);
						//}
					//}
				//}
				////var outBinPath:String = outputPath; EditorConfig.Project_path + "/" + EditorConfig.Project_name+"/" + backupPath + "/" + fileid + ".bin";
				//var binfile:File = new File(outputPath);
				//var binStream:FileStream = new FileStream();
					//binStream.open(binfile, FileMode.WRITE);
					//binStream.writeBytes(ba,0,ba.length);
					//binStream.close();
				//ba = null;
				//binStream = null;
				//binfile = null;
				//result = null;
				//frameArr = null;
				//pointArr = null;
				////App.log.info(backupPath+"的"+fileid+".bin文件生成成功");
			//}
		}
		
		private function getXML(file:File):XML 
		{
			var xml:XML = null;
			if (file.exists) 
			{
				var fs:FileStream = new FileStream;
				fs.open(file, FileMode.READ);
				var xmlString:String = fs.readUTFBytes(fs.bytesAvailable);
				fs.close();
				xml = new XML(xmlString);
				return xml;
			}else
			{
				trace("文件不存在");
			}
			return xml;
		}
	}
	
}