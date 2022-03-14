package view.window 
{
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import editor.events.ShortcutEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import editor.configuration.BaseAttribute;
	import view.auto.window.WindowTextEditUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CodeEdit extends WindowTextEditUI 
	{
		private var keys:Array = null;
		private var _path:String = "";
		public function CodeEdit() 
		{
			keys = [
			"and ",
			"break",
			"do ",
			"else ",
			"elseif ",
			"end",
			"false",
			"for ",
			"function ",
			"if ",
			"in ",
			"local ",
			"nil",
			"not ",
			"or ",
			"repeat ",
			"return ",
			"then ",
			"true",
			"until",
			"while ",
			];
			super();
			this.addEventListener(MouseEvent.CLICK,function (e:MouseEvent):void 
			{
				dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
			});
			App.stage.addEventListener(ShortcutEvent.SHORTCUT_EVENT,handleShorcut);
		}
		public function showProperty(ba:BaseAttribute):void 
		{
			if (!ba) 
			{
				return;
			}
			var script:String = ba.getValue("script");
			//var reg:RegExp = new RegExp('\.', "g");
			
			//reg = null;
			if (script && script!="") 
			{
				script = script.replace(".", "/");
				script = script.replace(".", "/");
				script = script.replace(".","/");
				var file:File = File.applicationDirectory.resolvePath(ProjectConfig.dataPath + "script/" + script + ".lua");
				if (file.exists) 
				{
					_path = file.nativePath;
					var fs:FileStream = new FileStream();
					fs.open(file, FileMode.READ);
					var code:String = fs.readMultiByte(fs.bytesAvailable, 'utf-8');
					code = code.replace(/\r\n/g, "\n");
					txt_code.text = code;// tinter(code);
					fs.close();
					file = null;
					fs = null;
				}
			}
		}
		private function tinter(code:String):String 
		{
			return code;
			code = replace(code, "if ");
			code = replace(code, "end");
			code = replace(code, "for ");
			code = replace(code, "end");
			code = replace(code, "function ");
			code = replace(code, "local ");
			code = replace(code, "not ");
			code = replace(code, "nil");
			code = replace(code, "and ");
			code = replace(code, " then");
			//用for替换不好使，暂时未研究
			//for (var i:int = 0; i < keys.length; i++) 
			//{
				//code = replace(code, "and ");
			//}
			return code;
		}
		private function replace(code:String,key:String,color:String="#E64B4B"):String 
		{
			code = code.replace(getReg(key), ("<font color='#E64B4B'>" + key + "</font>"));
			
			return code;
		}
		private function getReg(key:String):RegExp 
		{
			return new RegExp('(' + key + '){1}', "g");
		}
		private function handleShorcut(e:ShortcutEvent):void 
		{
			if (EditorManager.focus==this) 
			{
				switch (e.key) 
				{
					case "ctrl,s":
						save();
						break;
				}
			}
		}
		private function save():void 
		{
			var file:File = File.applicationDirectory.resolvePath(_path);
			if (file.exists) 
			{
				var code:String = txt_code.textField.text;
				code = code.replace(//g,"");
				_path = file.nativePath;
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.WRITE);
				fs.writeMultiByte(code, 'utf-8');
				fs.close();
				file = null;
				fs = null;
			}
		}
	}
}