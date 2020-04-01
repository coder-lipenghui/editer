package 
{
	import editor.events.EditorEvent;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import game.library.CatalogManager;

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
				
				actionModelPath 		= projectPath+"/"+config.child("action").@path;
				descriptionModelPath 	= projectPath+"/"+config.child("description").@path;
				textureModelPath 		= projectPath+"/"+config.child("texturepacker").@path;
				adoptAction				= config.child("action").@selected;
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