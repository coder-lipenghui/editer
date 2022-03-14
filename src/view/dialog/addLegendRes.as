package view.dialog 
{
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NativeDragEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogAddLegendResUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class addLegendRes extends DialogAddLegendResUI 
	{
		private var source:String = "";
		public function addLegendRes() 
		{
			super();
			btn_browse.clickHandler = new Handler(hanlderBrow);
			//this.addEventListener(NativeDragEvent)
			btn_ok.clickHandler = new Handler(function ():void 
			{
				if (txt_path.text!="") 
				{
					source = txt_path.text;
					execu();
				}else 
				{
					hanlderBrow();
				}
			});
		}
		public function hanlderBrow():void 
		{
			var file:File = File.desktopDirectory;
			if (txt_path.text!="") 
			{
				file = File.desktopDirectory.resolvePath(txt_path.text);
			}
			file.addEventListener(Event.SELECT,function (e:Event):void 
			{
				txt_path.text=source = (e.target as File).nativePath;
				execu();
			})
			file.browseForDirectory("请选择资源目录")
		}
		public function execu():void 
		{
			App.log.debug("正在制作资源:", source);
			if (NativeProcess.isSupported) 
			{
				var exePath:String ="tools/legend.exe"
				var cmd:File = File.applicationDirectory;
				cmd = cmd.resolvePath(exePath);
				trace(cmd.nativePath);
				if (!cmd.exists) 
				{
					App.log.error("legend.exe文件未找到");
					return;
				}
				
				var args:Vector.<String> = new Vector.<String>;
				args.push(source);//文件
				args.push(ck_batch.selected?1:0);
				//args.push(name);
				//args.push(size);
				var process:NativeProcess = new NativeProcess();
				NativeApplication.nativeApplication.autoExit = true;
					
				process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, function (e:ProgressEvent):void 
				{
					if (process.standardError.bytesAvailable) 
					{
						var info:String = process.standardError.readUTFBytes(process.standardError.bytesAvailable);
						App.log.info(info);
					}
				});
				process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, function (e:ProgressEvent):void 
				{
					var info:String = process.standardError.readUTFBytes(process.standardError.bytesAvailable);
					App.log.error(info)
				});
				process.addEventListener(NativeProcessExitEvent.EXIT, function (e:NativeProcessExitEvent):void 
				{
					App.log.info("done");
				});
				process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, function (e:IOErrorEvent):void 
				{
					App.log.error("STANDARD_OUTPUT_IO_ERROR");
				});
				process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, function (e:IOErrorEvent):void 
				{
					App.log.error("STANDARD_ERROR_IO_ERROR");
				});
				
				var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
				info.executable = cmd;
				info.arguments = args;
				process.start(info);
			}else{
				App.log.error("当前环境不支持执行exe文件");
			}	
		}
	}

}