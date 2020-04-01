package game.tools 
{
	import flash.events.Event;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class BrowseTools 
	{
		private static var _targetPath:String = "";
		
		private static var _directoryFun:Function=null;
		private static var _saveFun:Function=null;
		private static var _multipleFun:Function=null;
		
		public function BrowseTools() 
		{
			
		}
		public static function browseForDirectory(title:String,origin:String="",callBack:Function=null):void 
		{
			var file:File = getFile(origin);
			file.browseForDirectory(title);
			file.addEventListener(Event.SELECT, handleSelect);
			_directoryFun = callBack;
		}
		public static function browseForOpen(title:String,origin:String="",callBack:Function=null):void 
		{
			
		}
		public static function browseForSave(title:String,origin:String="",callBack:Function=null):void 
		{
			
		}
		public static function browseForOpenMultiple():void 
		{
			
		}
		
		private static function handleSelect(e:Event):void 
		{
			var file:File = e.target as File;
			file.removeEventListener(Event.SELECT, handleSelect);
			var reg:RegExp = new RegExp("\\\\","g");
			_targetPath = file.nativePath.replace(reg, "/");
			reg = null;
			if (_directoryFun is Function) 
			{
				_directoryFun(file,_targetPath);
			}
		}
		private static function handleMultipleSelect(e:Event):void 
		{
			
		}
		private static function getFile(path:String):File 
		{
			var file:File = File.applicationDirectory.resolvePath(path);
			if (!file.exists) 
			{
				file = File.desktopDirectory;
			}
			return file;
		}
	}
}