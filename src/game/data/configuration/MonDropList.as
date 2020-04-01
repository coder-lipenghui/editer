package game.data.configuration 
{
	import adobe.utils.CustomActions;
	import game.data.DataManager;
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	/**
	 * 怪物爆率配置表
	 * @author 3464285@gmail.com
	 */
	public class MonDropList extends BaseConfiguration
	{
		private var _droplist:Array = [];
		//private var _monDropList:Dictionary = new Dictionary;
		private var _mon2item:Dictionary = new Dictionary;
		private var _item2mon:Dictionary = new Dictionary;
		public function MonDropList(xml:XML=null) 
		{
			super(xml);
		}
		
		override public function Import(path:String, type:String = "csv", keys:Array = null, dics:Array = null):Boolean 
		{
			return super.Import(path, type, ["name"], [_mon2item]);
		}
		public function createXml(path:String,type:String ="csv"):void 
		{
			super.separator = ",";
			var temp:Array = readFile(path, type);
			var attrs:Array = [];
			var found:Boolean = false;
			for (var i:int = 0; i < temp.length; i++) 
			{
				var temp2:Array = temp[i];
				for (var j:int = 0; j < temp2.length; j++) 
				{
					if (temp2[j]=="&mdl_name")
					{
						found = true;
						attrs = temp2.concat();
						break;
					}
				}
				if (found)break;
			}
			var xml:XML = new XML("<mondroplist charSet=\"ANSI\"/>");
			for (var k:int = 0; k < attrs.length; k++) 
			{
				var child:XML = new XML("<attr/>");
				if (k==0) 
				{
					child.@key = "name";
					child.@name = "怪物名称";
				}else{
					child.@key = attrs[k];
					child.@name = DataManager.monDrop.getDespNameById(int(attrs[k]));
					var tipItems:String = DataManager.monDrop.getItemsById(int(attrs[k]));
					var tipsArr:Array = tipItems.split(";");
					child.@tips = tipsArr.join("<br/>")
				}
				child.@type = "string";
				//child.@tips = "循环次数;多少分之一;是否绑定";
				child.@group = 1;
				//child.@default= "0";
				xml.appendChild(child);
			}
			var fpath:String = File.applicationDirectory.resolvePath("D:/newproject/xml_mondroplist.xml").nativePath;
			var file:File = new File(fpath);
			var fs:FileStream = new FileStream;
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(xml.toString(), "utf-8");
			fs.close();
			fs = null;
		}
		override protected function parser(info:Array):BaseAttribute 
		{
			if (info[0]=="&mdl_name"||info[0]=="$STRING") 
			{
				return null;
			}
			return super.parser(info);
		}
		
		public function get mon2item():Dictionary 
		{
			return _mon2item;
		}
		
		public function set mon2item(value:Dictionary):void 
		{
			_mon2item = value;
		}
	}

}