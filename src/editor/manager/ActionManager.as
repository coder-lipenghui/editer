package editor.manager 
{
	import editor.events.EditorEvent;
	import editor.Action;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	/**
	 * @author 3464285@gmail.com
	 */
	public class ActionManager 
	{
		//private static var _instance:ActionManager = null;
		private var _model:Dictionary = new Dictionary;
		
		public function ActionManager() 
		{
			
		}
		public function init():void 
		{
			_model = new Dictionary;
			//TODO 遍历action文件夹，解析xml 创建action
			var folder:File = new File(File.applicationDirectory.resolvePath(ProjectConfig.actionModelPath).nativePath);
			if (folder.exists && folder.isDirectory) 
			{
				var files:Array = folder.getDirectoryListing();
				for each(var file:File in files)
				{
					var fs:FileStream = new FileStream();
					if (!file.exists || file.isDirectory) 
					{
						continue;
					}
					fs.open(file, FileMode.READ);
					var xml:XML = new XML(fs.readMultiByte(fs.bytesAvailable, "utf-8"));
					fs.close();
					
					var modelName:String = String(xml.@name);
					var xmllist:XMLList=xml.children()
					_model[modelName] = [];
					for (var i:int = 0; i < xmllist.length(); i++) 
					{
						var action:Action = new Action(xmllist[i] as XML);
						_model[modelName].push(action);
					}
				}
			}
			App.stage.dispatchEvent(new EditorEvent(EditorEvent.ACTION_LOAD_COMPLETED,null,null,true));
		}
		public function refresh():void 
		{
			
		}
		public function getActions(modelName:String, ignoreUnenabled:Boolean = false):Array
		{
			var result:Array = null;
			if (_model[modelName]) 
			{
				if (ignoreUnenabled) 
				{
					var temp:Array = _model[modelName];
					result = [];
					for (var i:int = 0; i < temp.length ; i++) 
					{
						var ac:Action = temp[i] as Action;
						if (ac.enable) 
						{
							result.push(ac);
						}
					}
					return result.length>0?result:null;
				}else{
					return _model[modelName];
				}
			}
			return null;
		}
		public function getModels():Array 
		{
			var result:Array = [];
			for (var key:String in _model) 
			{
				result.push(key);
			}
			return result;
		}
		/**
		 * 动作资源是否导出
		 * @param	modelName
		 * @param	actionId
		 * @return
		 */
		public function getActionPublish(modelName:String,actionId:String):Boolean 
		{
			if (model[modelName]) 
			{
				for each(var action:Action in model[modelName])
				{
					if (action.id==actionId && action.publish) 
					{
						return true;
					}
				}
			}
			return false;
		}
		/**
		 * 动作是否可用
		 * @param	modelName
		 * @param	actionId
		 * @return
		 */
		public function getActionEnable(modelName:String,actionId:String):Boolean 
		{
			if (model[modelName]) 
			{
				for each(var action:Action in model[modelName])
				{
					if (action.id==actionId && action.enable) 
					{
						return true;
					}
				}
			}
			return false;
		}
		/**
		 * 获取动作名称
		 * @param	modelName
		 * @param	actionId
		 * @return
		 */
		public function getActionNameById(modelName:String,actionId:String):String 
		{
			if (model[modelName]) 
			{
				for each(var action:Action in model[modelName])
				{
					if (action.id==actionId) 
					{
						return action.name;
					}
				}
			}
			App.log.error("unknow aciton:",actionId);
			return null;
		}
		/**
		 * 根据动作名称获取动作ID
		 * @param	modelName model名称
		 * @param	actionName 动作名称
		 * @return string 动作编号
		 */
		public function getActionIdByName(modelName:String,actionName:String):String 
		{
			if (model[modelName]) 
			{
				for each(var action:Action in model[modelName])
				{
					if (action.name==actionName || action.id==actionName) 
					{
						return action.id;
					}
				}
			}
			App.log.error("unknow aciton:",actionName);
			return null;
		}
		public function getActionByName(modelName:String,name:String):Action 
		{
			if (model[modelName]) 
			{
				for each(var action:Action in model[modelName])
				{
					if (action.name==name || action.id==name) 
					{
						return action;
					}
				}
			}
			return null;
		}
		//static public function get instance():ActionManager 
		//{
			//if (!_instance) 
			//{
				//_instance = new ActionManager;
			//}
			//return _instance;
		//}
		//
		//static public function set instance(value:ActionManager):void 
		//{
			//_instance = value;
		//}
		
		public function get model():Dictionary 
		{
			return _model;
		}
		
		public function set model(value:Dictionary):void 
		{
			_model = value;
		}
	}

}