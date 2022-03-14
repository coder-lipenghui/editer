package 
{
	import editor.events.EditorEvent;
	import editor.configuration.MapDesp;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import editor.manager.CatalogManager;

	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class ProjectConfig 
	{
		/**项目路径*/
		public static var projectPath:String = "";
		/**资源库目录*/
		public static var libraryPath:String = "";
		/**资源目录*/
		public static var assetsPath:String = "";
		/**脚本路径*/
		public static var dataPath:String = "";
		
		public static var actionModelPath:String = "";
		public static var textureModelPath:String = "";
		public static var descriptionModelPath:String = "";
		/*当前采用的动作*/
		public static var adoptAction:String = "";
		
		/**逻辑格子宽度*/
		public static var CELL_W:int = 0;
		/**逻辑格子高度*/
		public static var CELL_H:int = 0;
		/**切图宽度*/
		public static var GROUND_W:int = 0;
		/**切图高度*/
		public static var GROUND_H:int = 0;
		
		public function ProjectConfig() 
		{
			
		}
		public static function loadProjectXML(path:String):Boolean
		{
			var file:File = new File(File.applicationDirectory.resolvePath(path).nativePath);
			if (file.exists) 
			{
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				var projectXML:XML = new XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
				fileStream.close();
				projectPath = projectXML.@path;
				
				var config:XMLList = projectXML.config;
				var mapsetting:XMLList = projectXML.mapsetting;
				
				actionModelPath 		= projectPath+"/"+config.child("action").@path;
				descriptionModelPath 	= projectPath+"/"+config.child("description").@path;
				textureModelPath 		= projectPath+"/"+config.child("texturepacker").@path;
				adoptAction				= config.child("action").@selected;
				
				var logic:String = mapsetting.logic;
				var cutcell:String = mapsetting.cutcell;
				
				var tmp:Array = logic.split(",");
				CELL_W = int(tmp[0]);
				CELL_H = int(tmp[1]);
				
				tmp = cutcell.split(",");
				GROUND_W = int(tmp[0]);
				GROUND_H = int(tmp[1]);
				
				var library:XMLList = projectXML.library;
				libraryPath = library.@path;
				var catalog:XMLList = library.catalog;
				CatalogManager.instance.analysisXml(catalog[0]);
				assetsPath = projectXML.child("assets").@path;
				dataPath = projectXML.child("data").@path;
				App.stage.dispatchEvent(new EditorEvent(EditorEvent.PROJECT_FILE_LOADED));
				return true;
			}
			return false;
		}
	}

}