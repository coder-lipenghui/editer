package editor.tools.fileParser 
{
	import editor.tools.Logger;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import view.window.Log;
	/**
	 * ...
	 * @author lee
	 */
	public class BaseFileParser implements IFileParser 
	{
		public static var TYPE_CSV:String = "csv";
		public static var TYPE_TXT:String = "txt";
		public static var TYPE_EXCEL:String = "excel";
		
		private var _data:Array = null;
		private var _remark:Array = null;
		private var _separator:String = ",";
		private var _charSet:String = "utf-8";
		public function BaseFileParser() 
		{
			
		}
		
		
		/* INTERFACE Tools.FileParser.IFileParser */
		
		public function Read(path:String):Array 
		{
			App.log.info("开始读取文件:" + path+"文件编码:"+_charSet+",分隔符:["+_separator+"]");
			var file:File = File.applicationDirectory.resolvePath(path);
			if (file.exists) 
			{
				_data = [];
				_remark = [];
				var fs:FileStream = new FileStream;
				fs.open(file, FileMode.READ);
				var fileStr:String = fs.readMultiByte(fs.bytesAvailable, _charSet);
				fs.close();
				fs = null;
				var tempData:Array = fileStr.split("\r\n");
				if (tempData.length>0) 
				{
					for (var i:int = 0; i < tempData.length; i++) 
					{
						var info:String = tempData[i];
						trace(info);
						var value:Array = info.split(_separator);
						if (info=="" || info.indexOf("#")>=0 || info==" ") 
						{
							if (info.indexOf("#") >= 0 && value)
							{
								_remark.push(value);
							}
						}else{
							if (value[0]=="") 
							{
								continue;
							}
							_data.push(value);
						}
					}
					return _data;
				}else{
					App.log.warn("Read(): 文件内容为空或解析失败。");
				}
			}
			App.log.warn("没有找到文件:",path);
			return null;
		}
		
		public function Write(path:String):Boolean
		{
			return false;
		}
		
		public function get data():Array 
		{
			return _data;
		}
		
		public function set data(value:Array):void 
		{
			_data = value;
		}
		/**
		 * 按分隔符解析文件行，默认","
		 * csv使用"," txt使用" "
		 */
		public function get separator():String 
		{
			return _separator;
		}
		
		public function set separator(value:String):void 
		{
			_separator = value;
		}
		/**
		 * 文件编码
		 */
		public function get charSet():String 
		{
			return _charSet;
		}
		
		public function set charSet(value:String):void 
		{
			_charSet = value;
		}
		
		public function get remark():Array 
		{
			return _remark;
		}
		
		public function set remark(value:Array):void 
		{
			_remark = value;
		}
		
	}

}