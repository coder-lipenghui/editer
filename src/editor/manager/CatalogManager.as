package editor.manager 
{
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class CatalogManager 
	{
		private var _directoryList:Array = [];
		private static var _instance:CatalogManager = null;
		public function CatalogManager() 
		{
			var dir:catalog = new  catalog(-1,0,"","",-1,"",0);
			_directoryList.push(dir);
		}
		public function analysisXml(xml:XML):void
		{
			var xmlList:XMLList = xml.children();
			for (var i:int = 0; i < xmlList.length(); i++) 
			{
				var child:XML = xmlList[i] as XML;
				var pid:int = int(child.@parent);
				var name:String = child.@name;
				var path:String = child.@path;
				var display:int =-1;
				var icon:String = child.@icon;
				var defaultDir:int = child.@defaultDir;
				var enable:Boolean = child.@enable == "false"?false:true;
				if (String(child.@display)!="") 
				{
					display = child.@display;
				}
				addCatalog(pid, name, path,display,icon,defaultDir,enable);
			}
		}
		
		/**
		 * 根据显示组件ID获取目录ID
		 * @param	id
		 * @return 目录ID数组
		 */
		public function getCatalogIdByDisplayId(displayId:int):Array 
		{
			var catalogArr:Array = [];
			for (var i:int = 0; i < _directoryList.length; i++) 
			{
				var cl:catalog = _directoryList[i];
				if (cl.display===displayId) 
				{
					catalogArr.push(cl.index);
				}
			}
			return catalogArr;
		}
		public function getDirByCatalogId(id:int):int 
		{
			var node:catalog = _directoryList[id];
			if (node) 
			{
				return node.defaultDir;
			}
			return 0;
		}
		/**
		 * 根据目录id获取该目录绑定的显示组件id
		 * @param	id
		 */
		public function getDisplayIdByCatalogId(id:int):int 
		{
			var node:catalog = _directoryList[id];
			if (node) 
			{
				return node.display;
			}
			return -1;
		}
		/**
		 * 根据id获取目录对象
		 * @param	id
		 */
		public function getCatalogById(id:int):catalog 
		{
			return _directoryList[id];
		}
		/**
		 * 获取某个id下的所有目录，不递归
		 * @param	id
		 */
		public function getCatalogByParentId(id:int):Array 
		{
			var result:Array = [];
			for (var i:int = 0; i < _directoryList.length; i++) 
			{
				var temp:catalog = _directoryList[i];
				if (temp.parent==id && temp.enable) 
				{
					result.push(temp);
				}
			}
			return result;
		}
		
		/**
		 * 获取备份目录地址
		 * @param	id
		 */
		public function getAbsolutePath(id:int):String 
		{
			var node:catalog = _directoryList[id];
			var path:Array = [];
			if (node) 
			{
				while (node) 
				{
					if (node.name!="") 
					{
						path.push(node.name);
					}
					node = _directoryList[node.parent];
				}
			}
			path = path.reverse();
			return path.join("/");
		}
		/**
		 * 获取发布目录地址
		 * @param	id
		 */
		public function getOutputPathById(id:int):String 
		{
			var node:catalog = _directoryList[id];
			var path:Array = [];
			if (node) 
			{
				while (node) 
				{
					if (node.path!="") 
					{
						path.push(node.path);
					}
					node = _directoryList[node.parent];
				}
			}
			path = path.reverse();
			return path.join("/");
		}
		/**
		 * 
		 * @param	parent  父目录ID，默认为根目录
		 * @param	n		目录名称
		 * @param	path    目录实际地址
		 */
		public function addCatalog(parent:int = 0, n:String = "", path:String = "", display:int =-1, icon:String = "", defaultDir:int = 0, enable:Boolean = true):void 
		{
			App.log.info("新增目录:",n,path,display);
			var dir:catalog = new catalog(parent,_directoryList.length,n, path,display,icon,defaultDir,enable);
			_directoryList.push(dir);
		}
		/**
		 * 根据index删除目录
		 * @param	index
		 */
		public function remDirByIndex(index:int):void
		{
			for (var i:int = 0; i < _directoryList.length; i++) 
			{
				var dir:catalog = _directoryList[i];
				if (dir.index==index) 
				{
					_directoryList = _directoryList.slice(i, 1);
				}
			}
		}
		public function isEffectCatalog(id:int):Boolean 
		{
			switch (id) 
			{
				case 10:
				case 11:
				case 12:
				case 13:
				case 17:
				case 18:
					return true;
					break;
				default:
					return false;
			}
		}
		public function getIconById(id:int):String
		{
			for (var i:int = 0; i < _directoryList.length; i++) 
			{
				if (_directoryList[i].index==id)
				{
					return _directoryList[i].icon;
				}
			}
			return "";
		}
		public function remDir(dir:catalog):void 
		{
			//删除目录需要将该目录下的所有节点全部删除
			//并且需要重新整理当前目录
			//删掉了1，之前的2则变成1，所以需要将所有parent=2的换成等于1 
			//xml
			if (_directoryList.indexOf(dir)>-1) 
			{
				_directoryList = _directoryList.slice(_directoryList.indexOf(dir), 1);
			}else
			{
				remDirByIndex(dir.index);
			}
		}
		
		static public function get instance():CatalogManager 
		{
			if (!_instance) 
			{
				_instance = new CatalogManager;
			}
			return _instance;
		}
		
		static public function set instance(value:CatalogManager):void 
		{
			_instance = value;
		}
		
		public function get directoryList():Array 
		{
			return _directoryList;
		}
		
		public function set directoryList(value:Array):void 
		{
			_directoryList = value;
		}
	}
}
class catalog
{
	public var parent:int;
	public var index:int;
	public var child:Array = [];
	public var name:String = "";
	public var path:String = "";
	public var display:int = 0;//组件id
	public var icon:String = "";
	public var defaultDir:int = 0;
	public var enable:Boolean = true;
	public function catalog(parent:int,index:int,name:String,path:String,display:int,icon:String,defaultDir:int,enable:Boolean=true):void 
	{
		this.parent=parent
		this.index = index;
		this.name = name;
		this.path = path;
		this.display = display;
		this.icon = icon;
		this.defaultDir = defaultDir;
		this.enable = enable;
	}
}