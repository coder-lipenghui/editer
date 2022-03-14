package tests.configruation 
{
	import editor.manager.DataManager;
	import editor.configuration.BaseAttribute;
	import editor.configuration.XmlAttribute;
	import editor.configuration.MapInfo;
	import editor.tools.Logger;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import view.window.Log;
	/**
	 * ...
	 * @author lee
	 */
	public class MapInfo_Test 
	{
		
		public function MapInfo_Test() 
		{
			
		}
		static public function importTest():void 
		{
			//xml后续需要挪到项目配置文件当中 所以这边先用file形式读取
			var file:File = File.applicationDirectory.resolvePath("test/xml_mapinfo.xml");
			if (file.exists) 
			{
				var fs:FileStream = new FileStream;
				fs.open(file, FileMode.READ);
				var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
				fs.close();
				var mapInfo:MapInfo = new MapInfo(xml);
				mapInfo.Import(File.applicationDirectory.resolvePath("test/mapinfo.txt").nativePath);
				if (!mapInfo.data || mapInfo.data.length<=0) 
				{
					App.log.error("解析文件失败:"+file.nativePath);
				}else{
					for (var i:int = 0; i < mapInfo.data.length; i++) 
					{
						var ba:BaseAttribute = mapInfo.data[i] as BaseAttribute;
						if (ba) 
						{
							var result:Array = [];
							for (var j:int = 0; j < ba.group1.length; j++) 
							{
								var value:*= ba.getValue(ba.group1[j].key);
								if (value) 
								{
									result.push(ba.group1[j].name+"="+value);
								}
							}
							for (var k:int = 0; k < ba.group2.length; k++) 
							{
								value= ba.getValue(ba.group2[k].key);
								if (value) 
								{
									result.push(ba.group2[k].name+"="+value);
								}
							}
						}else{
							App.log.error("获取ba失败");
						}
					}
				}
			}else{
				App.log.error("不存在文件:"+file.nativePath);
			}
		}
		
		public static function exportTest():void 
		{
			var exportPath:String = "";
			//DataManager.mapInfo.Export(exportPath);
		}
	}

}