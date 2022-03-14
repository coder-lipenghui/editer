package tests.configruation 
{
	import editor.configuration.BaseAttribute;
	import editor.configuration.ItemDef;
	import editor.configuration.XmlAttribute;
	import editor.tools.Logger;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import view.window.Log;
	/**
	 * ...
	 * @author lee
	 */
	public class ItemDef_Test 
	{
		
		public function ItemDef_Test() 
		{
			
		}
		public static function test():void 
		{
			//xml后续需要挪到项目配置文件当中 所以这边先用file形式读取
			var file:File = File.applicationDirectory.resolvePath("test/xml_itemdef.xml");
			if (file.exists) 
			{
				var fs:FileStream = new FileStream;
				fs.open(file, FileMode.READ);
				var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
				fs.close();
				var itemdef:ItemDef = new ItemDef(xml);
				itemdef.Import(File.applicationDirectory.resolvePath("test/itemdef.csv").nativePath);
				if (!itemdef.data || itemdef.data.length<=0) 
				{
					App.log.error("解析文件失败:"+file.nativePath);
				}else{
					for (var i:int = 0; i < itemdef.data.length; i++) 
					{
						var ba:BaseAttribute = itemdef.data[i] as BaseAttribute;
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
							App.log.error(result.join(","));
						}else{
							App.log.error("获取ba失败");
						}
					}
				}
			}else{
				App.log.error("不存在文件:"+file.nativePath);
			}
		}
	}
}