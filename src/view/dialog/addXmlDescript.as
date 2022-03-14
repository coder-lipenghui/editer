package view.dialog 
{
	import adobe.utils.CustomActions;
	import air.update.logging.Level;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.globalization.LastOperationStatus;
	import editor.tools.fileParser.BaseFileParser;
	import editor.tools.fileParser.CsvParser;
	import editor.tools.fileParser.TxtParser;
	import morn.core.components.Box;
	import morn.core.components.ComboBox;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogAddXmlDescriptUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class addXmlDescript extends DialogAddXmlDescriptUI 
	{
		private var _rootFolderPath:String = "";
		private var separator:String = ",";
		private var chatSet:String="ANSI"
		private var xml:Array = [];
		public function addXmlDescript() 
		{
			super();
			btn_select.clickHandler = new Handler(handlerSelect);
			list_despcrition.renderHandler = new Handler(handlerRender);
			btn_add.clickHandler = new Handler(handlerSave);
		}
		private function handlerSave():void 
		{
			var file:File = File.desktopDirectory;
			
			file.addEventListener(Event.SELECT,function (e:Event):void 
			{
				if (list_despcrition.array.length>0) 
				{
					var xml:String = "<node charSet=\"ANSI\" separator=\""+separator+"\">\r\n";
					for (var i:int = 0; i < list_despcrition.array.length; i++) 
					{
						var att:Object = list_despcrition.array[i];
						var node:String = "    <attr key=\"" + att.key + "\" name=\"" + att.name+"\" group=\"" + att.group + "\" tips=\"" + att.tips + "\" type=\"" + att.type+"\" default=\"" + att.def + "\" displayGroup=\"" + att.displayGroup + "\"/>\r\n";
						xml = xml + node;
					}
					xml = xml + "</node>";
					var fs:FileStream = new FileStream();
					fs.open(file, FileMode.WRITE);
					fs.writeUTFBytes(xml);
					fs.close();
				}
			});
			file.browseForSave("保存文件至");
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
				var target:File = File.applicationDirectory.resolvePath(e.target.nativePath);
				txt_file.text = _rootFolderPath = target.nativePath;
				var type:String = "txt";
				separator = " ";
				if (target.extension=="csv") 
				{
					type = "csv";
					separator = ",";
				}
				var remark:Array = readFile(_rootFolderPath, type);
				if (remark && remark.length > 0)
				{
					var descript:Array = [];
					
					for (var j:int = 0; j <3; j++) 
					{
						for (var i:int = 0; i < remark[j].length; i++) 
						{
							if (descript[i]==null) 
							{
								descript[i] = new Object;
							}
							var val:String = remark[j][i];
							if (i==0)
							{
								val=i==0?val.replace("#",""):val;
							}
							if (j==0) 
							{
								descript[i].name = val;
							}
							if (j==1) 
							{
								descript[i].key = val;
							}
							if (j==2) 
							{
								descript[i].type = val;
							}
							descript[i].group = 1;
							descript[i].tips = "";
							descript[i].displayGroup="1常用属性"
							descript[i].def = "";
						}
					}
					list_despcrition.array = descript;
				}
				
			}
			file.browseForOpen("请选择文件");
			file.addEventListener(Event.SELECT,handlerSelected);
		}
		private function handlerRender(item:Box,index:int):void 
		{
			if (list_despcrition.array[index])
			{
				var xmlNode:Object = new Object;
				var txt_name:Label = item.getChildByName("txt_name") as Label;
				var txt_key:Label = item.getChildByName("txt_key") as Label;
				var cb_type:ComboBox = item.getChildByName("cb_type") as ComboBox;
				var cb_group:ComboBox = item.getChildByName("cb_group") as ComboBox;
				var txt_group:Label = item.getChildByName("txt_group")as Label;
				var txt_tips:Label = item.getChildByName("txt_tips") as Label;
				var txt_default:Label = item.getChildByName("txt_default") as Label;
				var name:String = list_despcrition.array[index].name;
				var key:String = list_despcrition.array[index].key;
				var type:String = list_despcrition.array[index].type;
				
				txt_name.text = name == null?"":name;
				txt_key.text = key==null?"":key;
				txt_tips.text = type == null?"":type;
				var types:Array = ["int", "string", "bool", "array"];
				var idx:int = types.indexOf(type);
				if (idx>-1)
				{
					cb_group.selectedIndex = idx;
				}else{
					if (type=="string[]") 
					{
						cb_group.selectedIndex=3;
					}
				}
				txt_name.addEventListener(Event.CHANGE,function (e:Event):void 
				{
					list_despcrition.array[index].name = txt_name.text;
				});
				cb_group.selectHandler=new Handler(function (index:int):void 
				{
					list_despcrition.array[index].group = cb_group.selectedIndex + 1;
				})
				cb_type.selectHandler = new Handler(function (index:int):void 
				{
					list_despcrition.array[index].type = cb_type.selectedLabel;
				});
				txt_default.addEventListener(Event.CHANGE,function (e:Event):void 
				{
					list_despcrition.array[index].de
				});
			}
		}
		private function readFile(path:String,type:String):Array 
		{
			//_path = path;
			//var time1:int = getTimer();
			var fileParser:BaseFileParser = null;
			switch (type) 
			{
				case BaseFileParser.TYPE_CSV:
					fileParser = new CsvParser();
					break;
				case BaseFileParser.TYPE_TXT:
					fileParser = new TxtParser();
					break;
				//case BaseFileParser.TYPE_EXCEL:
					//fileParser = new ExcelParser();
					//break;
			}
			if (!fileParser) 
			{
				App.log.error("没有文本解析类");
				return null;
			}
			fileParser.charSet = "ANSI";
			fileParser.separator = separator;
			try
			{
				fileParser.Read(path);
				return fileParser.remark;
			}catch (e:Error){
				App.log.error(e.message+e.getStackTrace());
				return null;
			}
			return null;
		}
		
	}

}