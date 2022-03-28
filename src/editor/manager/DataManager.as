package editor.manager 
{
	import editor.events.EditorEvent;
	import flash.events.Event;
	import editor.manager.ActionManager;
	import editor.manager.BinaryManager;
	import editor.configuration.BaseAttribute;
	import editor.configuration.BaseConfiguration;
	import editor.configuration.ItemDef;
	import editor.configuration.LevelInfo;
	import editor.configuration.MapConn;
	import editor.configuration.MapInfo;
	import editor.configuration.MonDef;
	import editor.configuration.MonDrop;
	import editor.configuration.MonDropList;
	import editor.configuration.MonGen;
	import editor.configuration.NpcGen;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import editor.tools.Logger;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import editor.manager.LibraryManager;
	import morn.core.handlers.Handler;
	import editor.tools.fileParser.BaseFileParser;
	import view.window.Log;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class DataManager 
	{
		/**地图表*/
		public static var mapInfo:MapInfo = new MapInfo;
		/**物品表*/
		public static var itemDef:ItemDef = new ItemDef;
		/**经验表*/
		public static var levelInfo:LevelInfo = new LevelInfo;
		/**怪物表*/
		public static var monDef:MonDef = new MonDef;
		/**掉落表*/
		public static var monDrop:MonDrop = new MonDrop;
		/**刷怪配置*/
		public static var monGen:MonGen = new MonGen;
		/**刷npc配置*/
		public static var npcGen:NpcGen = new NpcGen;
		/**掉落配置*/
		public static var monDropList:MonDropList = new MonDropList;
		/**地图传送点配置*/
		public static var mapConn:MapConn = new MapConn;
		
		public static var binManager:BinaryManager = new BinaryManager;
		
		public static var library:LibraryManager = new LibraryManager();
		public static var action:ActionManager = new ActionManager();
		
		private static var _configs:Dictionary = new Dictionary();
		
		public function DataManager() 
		{
			
		}
		public static function init():Boolean 
		{
			App.stage.addEventListener(EditorEvent.PROJECT_FILE_LOADED,handlerProjectFileLoaded);
			return true;
		}
		private static function handlerProjectFileLoaded(e:Event=null):void 
		{
			try 
			{
				var configs:Array = [
					{"xml":ProjectConfig.descriptionModelPath+"xml_mapinfo.xml", "file":ProjectConfig.dataPath+"mapinfo.csv","target":mapInfo},
					{"xml":ProjectConfig.descriptionModelPath+"xml_itemdef.xml", "file":ProjectConfig.dataPath+"itemdef.csv","target":itemDef},
					{"xml":ProjectConfig.descriptionModelPath+"xml_mongen.xml", "file":ProjectConfig.dataPath+"mongen.csv","target":monGen},
					{"xml":ProjectConfig.descriptionModelPath+"xml_npcgen.xml", "file":ProjectConfig.dataPath+"npcgen.csv","target":npcGen},
					{"xml":ProjectConfig.descriptionModelPath+"xml_mondef.xml", "file":ProjectConfig.dataPath+"mondef.csv","target":monDef},
					{"xml":ProjectConfig.descriptionModelPath+"xml_levelinfo.xml", "file":ProjectConfig.dataPath+"levelinfo.csv","target":levelInfo},
					{"xml":ProjectConfig.descriptionModelPath+"xml_mapconn.xml", "file":ProjectConfig.dataPath+"mapconn.csv","target":mapConn}
				];
				if (false) 
				{
					//新版本的怪物掉落信息
					configs.push({"xml":ProjectConfig.descriptionModelPath + "xml_mondroplist.xml", "file":ProjectConfig.dataPath + "mondroplist.csv", "target":monDropList});
					configs.push({"xml":ProjectConfig.descriptionModelPath+"xml_mondrop.xml", "file":ProjectConfig.dataPath+"mondrop.csv","target":monDrop});
				}
				for (var i:int = 0; i < configs.length; i++) 
				{
					var config:Object = configs[i];
					if (config.target==monDropList) 
					{
						monDropList.createXml(config.file);
					}
					var file:File = File.applicationDirectory.resolvePath(config.xml);
					if (file.exists) 
					{
						var fs:FileStream = new FileStream;
						fs.open(file, FileMode.READ);
						var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
						_configs[String(xml.name())] = config.target;
						fs.close();
						config.target.init(xml);
						config.target.Import(config.file);
					}else{
						trace("文件不存在:",config.xml);
					}
				}
			}catch (e:Error){
				App.log.error("DataManager初始化失败:\r\n"+e.message+"\r\n"+e.getStackTrace());
			}
			binManager.init();
			trace("加载动作信息");
			action.init();
			trace("加载资源信息");
			library.init();
		}
		/**
		 * 
		 * @param	ba
		 * @param	callBack 回调参数:[index:int,ba:baseAttribute]
		 */
		static public function addBaseAttribute(ba:BaseAttribute,callBack:Handler=null):void 
		{
			var index:int =-1;
			if (_configs[ba.name]) 
			{
				var bc:BaseConfiguration = _configs[ba.name] as BaseConfiguration;
				//TODO 需要进行ID查重
				bc.data.push(ba);
				index = bc.data.length - 1;
			}
			if (callBack) 
			{
				callBack.executeWith([index,ba]);
			}
		}
		static public function delBaseAttribute(ba:BaseAttribute,callBack:Handler=null):void 
		{
			var index:int =-1;
			if (_configs[ba.name]) 
			{
				var bc:BaseConfiguration = _configs[ba.name] as BaseConfiguration;
				index = bc.data.indexOf(ba);
				if (index>-1) 
				{
					bc.data.removeAt(index);
				}
			}
			if (callBack) 
			{
				callBack.executeWith([index]);
			}
		}
		/**
		 * 复制并且在复制条目下插入一条数据
		 * @param	ba
		 * @param	callBack
		 */
		static public function copyAndPasteBaseAttribute(ba:BaseAttribute,callBack:Handler=null):void 
		{
			var index:int =-1;
			var newBa:BaseAttribute = null;
			if (_configs[ba.name]) 
			{
				var bc:BaseConfiguration = _configs[ba.name] as BaseConfiguration;
				index = bc.data.indexOf(ba);
				if (index>-1) 
				{
					newBa = ba.clone(true);
					newBa.displayGroup = ba.displayGroup;
					bc.data.insertAt(index,newBa);
				}
			}
			if (callBack) 
			{
				callBack.executeWith([index,newBa]);
			}
		}
		static public function findBaseAttribute():void 
		{
			trace("查找操作");
		}
	}

}