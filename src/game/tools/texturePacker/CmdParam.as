package game.tools.texturePacker 
{
	import editor.log.Logger;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	import view.window.Log;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class CmdParam 
	{
		private static var _instance:CmdParam = null;
		
		private var _cmdParamList:Dictionary = null;
		
		public function CmdParam() 
		{
			_cmdParamList = new Dictionary();
		}
		public function getParams(path:String):Vector.<String>
		{
			if (_cmdParamList[path]) 
			{
				return _cmdParamList[path];
			}
			_cmdParamList[path] = parserParams(path);
			return _cmdParamList[path];
		}
		/**
		 * TexturePacke命令行参数文件路径
		 * 具体TexturePacker命令请参照：https://www.codeandweb.com/texturepacker/documentation
		 * 或者使用TexturePacker.exe --help参看各命令行
		 * @example --data=main-hd.plist 
		 * 			--format=cocos2d
		 * 			--sheet=main-hd.png 
		 * 			assets same as above, but with output files main-hd.plist, main-hd.png
		 */
		private function parserParams(path:String):Vector.<String>
		{
			var _processArg:Vector.<String> = null;
			var file:File = new File(File.applicationDirectory.resolvePath(path).nativePath);
			if (file.exists) 
			{
				_processArg=new Vector.<String>;
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				var paramsStr:String = fileStream.readMultiByte(fileStream.bytesAvailable, "utf-8");
				fileStream.close();
				fileStream = null;
				var paramsLine:Array = paramsStr.split("\r\n");
				for (var i:int = 0; i < paramsLine.length; i++) 
				{
					if (paramsLine[i].indexOf("#")>-1 || paramsLine[i]=="") 
					{
						continue;
					}
					var param:Array = String(paramsLine[i]).split("=");
					var key:String = "";
					var value:String = "";
					key = param[0];
					if (key=="TPPath") 
					{
						if (param[1]) 
						{
							TexturePacker.tpPath = param[1];
						}else{
							App.log.error("必须先设置texturepacker.exe路径");
						}
					}else{
						_processArg.push(key);
						if (param.length>1) 
						{
							value = param[1];
							_processArg.push(value);
						}
					}
				}
			}else{
				App.log.error(TexturePacker.TP_ERROR_NO_PARAMS);
			}
			return _processArg;
		}
		
		static public function get instance():CmdParam 
		{
			if (_instance==null) 
			{
				_instance = new CmdParam();
			}
			return _instance;
		}
		
		static public function set instance(value:CmdParam):void 
		{
			_instance = value;
		}
	}

}