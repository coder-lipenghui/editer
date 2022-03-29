package editor.tools.texturePacker 
{
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import editor.tools.Logger;
	import flash.utils.Dictionary;
	import editor.AnimatInfo;
	import view.window.Log;
	/**
	 * 利用TexturePacker的命令行工具执行图集打包
	 * @author 3464285@gmail.com
	 */
	public class TexturePacker extends EventDispatcher
	{
		public static var TP_ERROR_NO_PARAMS:String = "命令行文件不存在";
		public static var TP_ERROR_NOT_FIND:String = "未找到TexturePacker.exe";
		public static var TP_ERROR_NOT_ACTIVATED:String = "当前版本为未激活版本，图片上会出现红字";
		public static var TP_ERROR_OUT_RANGE:String = "超过当前定义的最大尺寸";
		public static var TP_ERROR_PARAM:String = "参数错误";
		public static var TP_ERROR_CMD_SUPPORT:String = "当前环境不支持cmd命令行";
		/**texturepacker.exe路径*/
		private static var _tpPath:String = "";
		private var _name:String = "";
		private var _rootPath:String = "";
		private var _inputPath:String = "";
		private var _outputPath:String = "";
		private var _data:String = "";
		private var _sheet:String = "";
		private var _source:String = "";
		private var _center:String = "";
		private  var _paramsPath:String = "";
		private var _adjustSize:int = 1024;
		private var _allowRotation:Boolean = true;
		private var _process:NativeProcess = null;
		private var _errorHandler:Function = null;
		private var _progressHandler:Function = null;
		private var _successHandler:Function = null;
		private var _ioErrorHandler:Function = null;
		private var _state:int = -1;
		private var _stateMsg:String = "";
		/**参数列表 static形式 批量操作的时候可以快速创建参数*/
		//private static var _processArg:Vector.<String> = new Vector.<String>;
		
		/**
		 * 生成图集
		 * @param	name data、sheet名称参数
		 * @param	inputPath 源资源路径
		 * @param	outputPath 导出路径
		 * @param	paramPath texturepacker.exe命令行描述文件路径
		 */
		public function TexturePacker(name:String,inputPath:String="",outputPath:String="",paramsPath:String="") 
		{
			_name = name;
			_data = outputPath+"/"+name + ".plist";
			_sheet = outputPath+"/"+name + ".png";
			this.inputPath = inputPath;
			this.outputPath = outputPath;
			this.paramsPath = paramsPath;
		}
		public function start():void 
		{
			if (NativeProcess.isSupported) 
			{
				if (_tpPath=="") 
				{
					App.log.error("未设置TexturePacker.exe的路径");
					return;
				}
				var cmd:File = new File();
				
				//_tpPath="/Applications/TexturePacker.app/Contents/MacOS/TexturePacker";
				cmd = cmd.resolvePath(_tpPath);
				if (!cmd.exists) 
				{
					var msg:String =TP_ERROR_NOT_FIND;
					if (_errorHandler is Function) 
					{
						_errorHandler(this,msg);
					}
					App.log.error("TexturePacker.exe文件未找到");
					return;
				}
				var tempArg:Vector.<String> = new Vector.<String>;
				tempArg.push("--data");
				tempArg.push(_data);
				tempArg.push("--sheet");
				tempArg.push(_sheet);
				tempArg.push(_inputPath);
				
				var exceu:Vector.<String> = new Vector.<String>;
				var processArg:Vector.<String> = CmdParam.instance.getParams(_paramsPath);
				//修正max-size
				for (var i:int = 0; i < processArg.length; i++) 
				{
					if (processArg[i]=="--max-size") 
					{
						
						if (processArg[i+1])
						{
							//trace("--->old size:",int(processArg[i+1]));
							if (int(processArg[i+1])< _adjustSize)
							{
								processArg[i + 1] = _adjustSize+"";
								break;
							}
						}
					}
				}
				if (!allowRotation) 
				{
					if (processArg.indexOf("--disable-rotation")<0) 
					{
						processArg.push("--disable-rotation");
					}
				}
				if (processArg) 
				{
					exceu = exceu.concat(processArg, tempArg);
					_process = new NativeProcess();
					NativeApplication.nativeApplication.autoExit = true;
					
					_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
					_process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
					_process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
					_process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
					_process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
					
					var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
					info.executable = cmd;
					info.arguments = exceu;
					_process.start(info);
				}else{
					App.log.error("Textpacker参数构建失败,请检查参数文件路径");
				}
			}else{
				App.log.error("当前环境不支持执行exe文件");
			}
		}
		
		public function dispose():void
		{
			if (_process) 
			{
				_process.exit();
				_process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
				_process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
				_process.removeEventListener(NativeProcessExitEvent.EXIT, onExit);
				_process.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
				_process.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
				_process = null;
			}
			_successHandler = null;
			_errorHandler = null;
			_progressHandler = null;
		}
		private function onExit(e:Event):void 
		{
			if (_state) 
			{
				if (_successHandler is Function) 
				{
					_successHandler(this);
				}
			}
			dispose();
		}
		private function onOutputData(e:Event):void 
		{
			var info:String = _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable);
			if (info.indexOf("You must agree to the license agreement before using TexturePacker")>-1) 
			{
				_state = 0;
				if (_errorHandler is Function) 
				{
					var msg:String = TP_ERROR_NOT_ACTIVATED;
					_errorHandler(this, msg);
					dispose();
				}
				App.log.error("当前TexturePacker未激活，无法使用");
				return;
			}
			trace(info);
			if (_progressHandler is Function) 
			{
				_progressHandler(info);
			}
		}
		private function onErrorData(e:Event):void
		{
			_process.exit();
			_state = 0;
			var info:String = _process.standardError.readUTFBytes(_process.standardError.bytesAvailable);
			if (info.indexOf("Not all sprites could be packed into the texture")>-1) 
			{
				info = TP_ERROR_OUT_RANGE;
			}
			if (info.indexOf("No space left to pack the following sprites")>-1) 
			{
				info = TP_ERROR_OUT_RANGE;
			}
			if (info.indexOf("You are using some advanced features which will cause some sprites to")>-1) 
			{
				info = TP_ERROR_NOT_ACTIVATED;
			}
			trace(info);
			if (_errorHandler is Function) 
			{
				_errorHandler(this, info);
				dispose();
			}
		}
		private function onIOError(e:Event):void 
		{
			_process.exit();
			_state = 0;
			if (_ioErrorHandler is Function) 
			{
				_ioErrorHandler(this,"IO Error");
			}
		}
		public function get inputPath():String 
		{
			return _inputPath;
		}
		
		public function set inputPath(value:String):void 
		{
			_inputPath = value;
			//var tempIndex:int = _inputPath.lastIndexOf("\\");
			//var fileName:String = _inputPath.substr(tempIndex, _inputPath.length);
			//var tempArr:Array = fileName.split("(");
			//if (tempArr.length>0)
			//{
				//var id:String = tempArr[0];
				//_data = File.applicationDirectory.resolvePath(_outputPath).nativePath+"/"+id+".plist";
				//_sheet = File.applicationDirectory.resolvePath(_outputPath).nativePath + "/" + id + ".png";
			//}
			//tempArr = null;
		}
		public static function plistData(filePath:String):Array 
		{
			var result:Array =[];
			var plistXml:XML = null;
			var file:File =  File.applicationDirectory.resolvePath(filePath);
			if (file.exists)
			{
				plistXml = null;
				if (file.exists) 
				{
					var fs:FileStream = new FileStream;
					fs.open(file, FileMode.READ);
					var xmlString:String = fs.readUTFBytes(fs.bytesAvailable);
					fs.close();
					plistXml = new XML(xmlString);
				}else
				{
					trace("文件不存在");
					return null;
				}
				var dict:XMLList = plistXml.dict.children();
				var framesXML:XMLList = dict[1].children();
				var meta:XML = dict[3];
				var format:int = int(meta.child(1).text());
				var size:Array = String(meta.child(5).text()).split(",");
				var step:int = 1;
				for (var i:int = 0; i <framesXML.length() ; i++) 
				{
					if (step % 2 == 0)
					{
						if (framesXML[i])
						{
							var key:XML = framesXML[i-1];
							var frame:XML = framesXML[i];
							var animat:AnimatInfo = new AnimatInfo;
							animat.name = key.text();
							var imgName:String = animat.name.split(".")[0];
							var reg:RegExp = new RegExp("[\{|\}]", "g");
							var keyDic:Dictionary = new Dictionary;
							var rect:Array = [];
							var offset:Array = [];
							var rotated:int = 0;
							var sourceColorRect:Array = [];
							var sourceSize:Array = [];
							
							var frameDic:Dictionary = new Dictionary;
							
							var temp:int = 1;
							var xmllist:XMLList = frame.children();
							var k:String = "";
							var v:String = "";
							for (var j:int = 0; j < xmllist.length(); j++)
							{
								var x:XML = xmllist[j] as XML;
								
								if (temp%2==0) 
								{
									var type:String = x.name().toString();
									switch (type) 
									{
										case "string":
											frameDic[k] = x.text().toString();
											break;
										case "integer":
											frameDic[k] = int(x.text().toString());
											break;
										case "true":
										case "false":
											frameDic[k] = type == "true"?true:false;
											break;
										case "array":
											frameDic[k] = null;//暂时用不上
											break;
										default:
									}
								}else {
									k = x.text().toString();
								}
								temp++;
							}
							if (format==2)
							{
								rect 			= frameDic["frame"].replace(reg, "").split(",");			 //frame           在新图中的位置
								offset 			= frameDic["offset"].replace(reg,"").split(",");		 	 //offset	  	  暂时没研究
								rotated 		= frameDic["rotated"];		 	 							 //rotated         是否旋转
								sourceColorRect	= frameDic["sourceColorRect"].replace(reg, "").split(","); 	 //sourceColorRect 在原始图中的位置
								sourceSize 		= frameDic["sourceSize"].replace(reg, "").split(",");	 	 //sourceSize      实际大小
								animat.sourceW = uint(sourceSize[0]);
								animat.sourceH = uint(sourceSize[1]);
								animat.oldX = uint(sourceColorRect[0]);
								animat.oldY = uint(sourceColorRect[1]);
							}else if (format==3)
							{
								var spriteSize:Array=frameDic["spriteSize"].replace(reg, "").split(",");
								rect 			= frameDic["textureRect"].replace(reg, "").split(",");
								offset 			= frameDic["spriteOffset"].replace(reg, "").split(",");
								rotated 		= frameDic["textureRotated"];
								sourceSize 		= frameDic["spriteSourceSize"].replace(reg, "").split(",");
								
								var ow:int = sourceSize[0];//原始尺寸
								var oh:int = sourceSize[1];//
								var cw:int = ow / 2; //大图中心点
								var ch:int = oh / 2;
								var sw:int = int(spriteSize[0]);//截取后的大小
								var sh:int = int(spriteSize[1]);
								animat.oldX = cw + int(offset[0]) - sw / 2;
								animat.oldY = ch - int(offset[1]) - sh / 2;
								animat.sourceW = sw;
								animat.sourceH = sh;
							}
							animat.offestX = offset[0];
							animat.offestY = offset[1];
							animat.rotated = rotated?1:0;
							
							if (rect.length>0)
							{
								animat.x = uint(rect[0]);
								animat.y = uint(rect[1]);
								animat.w = uint(rect[2]);
								animat.h = uint(rect[3]);
							}
							result.push(animat);
							result = result.sortOn("name");
						}
					}
					step++;
				}
			}else
			{
				App.log.error("文件不存在",filePath);
			}
			return result;
		}
		public function get outputPath():String
		{
			return _outputPath;
		}
		
		public function set outputPath(value:String):void 
		{
			_outputPath = value;
		}
		
		public function get paramsPath():String 
		{
			return _paramsPath;
		}
		/**
		 * 设置命令行文件路径
		 * 
		 */
		public function set paramsPath(value:String):void 
		{
			if (_paramsPath!=value) 
			{
				_paramsPath = value;
			}
		}
		
		public function get successHandler():Function 
		{
			return _successHandler;
		}
		
		public function set successHandler(value:Function):void 
		{
			_successHandler = value;
		}
		
		static public function get tpPath():String 
		{
			return _tpPath;
		}
		
		static public function set tpPath(value:String):void 
		{
			_tpPath = value;
		}
		
		public function get rootPath():String 
		{
			return _rootPath;
		}
		
		public function get data():String 
		{
			return _data;
		}
		
		public function get sheet():String 
		{
			return _sheet;
		}
		
		public function set rootPath(value:String):void 
		{
			_rootPath = value;
		}
		
		public function get center():String 
		{
			return _center;
		}
		
		public function set center(value:String):void 
		{
			_center = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get errorHandler():Function 
		{
			return _errorHandler;
		}
		
		public function set errorHandler(value:Function):void 
		{
			_errorHandler = value;
		}
		
		public function get adjustSize():int 
		{
			return _adjustSize;
		}
		
		public function set adjustSize(value:int):void 
		{
			_adjustSize = value;
		}
		
		public function get allowRotation():Boolean 
		{
			return _allowRotation;
		}
		
		public function set allowRotation(value:Boolean):void 
		{
			_allowRotation = value;
		}
	}

}