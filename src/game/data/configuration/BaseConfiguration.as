package game.data.configuration 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import editor.log.Logger;
	import game.tools.fileParser.BaseFileParser;
	import game.tools.fileParser.CsvParser;
	import game.tools.fileParser.ExcelParser;
	import game.tools.fileParser.TxtParser;
	import game.data.configuration.BaseAttribute;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import view.window.Log;
	/**
	 * ...
	 * @author lee
	 */
	public class BaseConfiguration 
	{
		/**
		 * 存放未分组的BaseAttribute的数组
		 */
		private var _data:Array = [];
		
		/**
		 * 解析后按行插入的原始数据数组
		 */
		private var _originalData:Array = [];
		
		/**
		 * 
		 */
		private var _path:String = "";
		
		/**
		 * 属性XML描述信息
		 */
		private var _xml:XML = null;
		
		/**
		 * 文件编码格式，默认ANSI格式
		 */
		public var charSet:String = "ANSI";
		/**
		 * 配置文件的解析格式，txt文件用“ ” csv文件用“,”
		 */
		public var separator:String = " ";
		
		/**
		 * 用于快速创建对象的clone体
		 */
		public var cloneTarget:BaseAttribute = null;
		
		protected var _categoryKeys:Array = null;
		protected var _categoryDics:Array = null;
		
		public function BaseConfiguration(xml:XML=null) 
		{
			if (xml) 
			{
				init(xml);
			}
		}
		public function init(xml:XML):void 
		{
			_xml = xml;
			if (String(xml.@charSet)!="") 
			{
				charSet = String(xml.@charSet);
			}
			if (String(xml.@separator)!="") 
			{
				separator = String(xml.@separator);
			}
			cloneTarget = new BaseAttribute(xml);
		}
		/**
		 * 导入游戏配置文件
		 * @param	path 文件路径
		 * @param	type 文件类型，目前仅支持csv跟txt两种格式
		 * @param	keys 按照给定的keys，dics对解析后的数据进行归类
		 * @param	dics 按照给定的keys，dics对解析后的数据进行归类
		 * @return
		 */
		public function Import(path:String, type:String = "csv", keys:Array = null, dics:Array = null):Boolean 
		{
			_categoryKeys = keys;
			_categoryDics = dics;
			_originalData = readFile(path, type);
			for (var i:int = 0; i < _originalData.length; i++) 
			{
				var info:Array = _originalData[i];
				parser(info);
			}
			classify();
			return true;
		}
		/**
		 * 导出
		 * @param	path 导出路径
		 * @return
		 */
		public function export(path:String = null):Boolean {
			if (!path || path=="") 
			{
				trace("未设置路劲");
				return false;
			}
			var result:Array = [];
			for (var k:int = 0; k < _data.length; k++) 
			{
				var output:Array = [];
				for (var i:int = 0; i < cloneTarget.group1.length; i++) 
				{
					var xa:XmlAttribute = cloneTarget.group1[i];
					var ba:BaseAttribute = _data[k];
					output.push(ba.values[xa.key]);
				}
				var group2:Array = [];
				for (var j:int = 0; j < cloneTarget.group2.length; j++) 
				{
					xa = cloneTarget.group2[j];
					ba = _data[k];
					if (ba.values[xa.key] && ba.values[xa.key]!="") 
					{
						switch (xa.type) 
						{
							case "bool":
							case "check":
								group2.push(xa.key);
								break;
							case "array":
								var temp:Array = ba.values[xa.key];
								for (var l:int = 0; l < temp.length; l++) 
								{
									group2.push(xa.key+"("+temp[l]+")")
								}
								break;
						}
					}
				}
				if (group2.length>0) 
				{
					output.push(group2.join("|"));
				}
				result.push(output.join(separator));
			}
			var resultStr:String = result.join("\r\n");
			var filePath:String = File.applicationDirectory.resolvePath(path).nativePath;
			var file:File = new File(filePath);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(resultStr,charSet);
			fs.close();
			file = null;
			fs = null;
			return true;
		}
		/**
		 * 增加一条数据
		 * @param	ba
		 */
		public function push(ba:BaseAttribute):void 
		{
			this.data.push(ba);
			classify();
		}
		/**
		 * 移除一条数据
		 * @param	ba
		 */
		public function remove(ba:BaseAttribute):void 
		{
			//从分类过的数组中删除
			if (_categoryKeys && _categoryDics) 
			{
				for (var i:int = 0; i < _categoryKeys.length; i++) 
				{
					var key:String = _categoryKeys[i];
					var dic:Dictionary = _categoryDics[i];
					var value:String = ba.getValue(key);
					if (value)
					{
						var categoryArr:Array = dic[value];
						if (categoryArr)
						{
							var index:int = categoryArr.indexOf(ba);
							categoryArr.removeAt(index);
						}
					}
				}
			}
			//从未分类的原始数组中删除
			index = data.indexOf(ba);
			if (index>-1) 
			{
				data.removeAt(index);
			}
		}
		/**
		 * 将数据按照给定的key进行分类
		 * 分类后存储到给定的dictionary中
		 */
		public function classify():void 
		{
			if (_categoryKeys && _categoryDics && _categoryKeys.length==_categoryDics.length) 
			{
				for (var i:int = 0; i < _categoryKeys.length; i++) 
				{
					var key:String = _categoryKeys[i];
					var dic:Dictionary = _categoryDics[i];
					for each(var ba:BaseAttribute in data) 
					{
						var value:String = ba.getValue(key);
						if (value)
						{
							var categoryArr:Array = dic[value];
							if (!categoryArr)
							{
								dic[value] = categoryArr = [];
							}
							categoryArr.push(ba);
						}
					}
				}
			}
		}
		/**
		 * 行配置数据解析
		 * @param	data 从配置文件中接出来的原始数据Array
		 * @param	keys keys 按照给定的keys，dics对解析后的数据进行归类
		 * @param	dics 按照给定的keys，dics对解析后的数据进行归类
		 */
		protected function parser(data:Array):BaseAttribute 
		{
			var ba:BaseAttribute = cloneTarget.clone();
			var key:String = null;
			var keyIndex:int = -1;
			for (var j:int = 0; j < data.length; j++)
			{
				var value:*= null;
				if (j<ba.group1.length) 
				{
					key = ba.group1[j].key;
					value = data[j];
					setValue(ba, key, value);
				}else{
					var group2:Array = String(data[j]).split("|");
					for (var k:int = 0; k < group2.length; k++){
						key = group2[k];
						if (key.indexOf("(") >= 0){
							var temp:Array = key.split("(");
							key = temp[0];
							value = String(temp[1]).replace(")", "");
						}else{
							key = value = group2[k];
						}
						setValue(ba, key, value);
					}
				}
			}
			this.data.push(ba);
			return ba;
		}
		/**
		 * 按行读取数据
		 * @param	path
		 * @param	type
		 * @return 行数组信息
		 */
		protected function readFile(path:String,type:String):Array 
		{
			_path = path;
			var time1:int = getTimer();
			var fileParser:BaseFileParser = null;
			switch (type) 
			{
				case BaseFileParser.TYPE_CSV:
					fileParser = new CsvParser();
					break;
				case BaseFileParser.TYPE_TXT:
					fileParser = new TxtParser();
					break;
				case BaseFileParser.TYPE_EXCEL:
					fileParser = new ExcelParser();
					break;
			}
			if (!fileParser) 
			{
				App.log.error("没有文本解析类");
				return null;
			}
			fileParser.charSet = charSet;
			fileParser.separator = separator;
			try
			{
				return fileParser.Read(path);
			}catch (e:Error){
				App.log.error(e.message+e.getStackTrace());
				return null;
			}
			return null;
		}
		
		/**
		 * 默认排序方法
		 */
		protected function sort():void 
		{
			_data = _data.sort();
		}
		/**
		 * 设置BaseAttribute对象的值
		 * @param	ba
		 * @param	key
		 * @param	value
		 */
		protected function setValue(ba:BaseAttribute,key:String,value:*):void 
		{
			var xa:XmlAttribute = ba.haveKey(key);
			if (xa) 
			{
				switch (xa.type) 
				{
					case "string":
						value = String(value);
						break;
					case "bool":
					case "check":
						value = true;
						break;
					case "array":
						value = [String(value)];
						break;
					case "int":
						value = int(value);
						break;
					default:
				}
				ba.setValue(xa.key, value);
			}
		}
		public function get data():Array 
		{
			return _data;
		}
		
		public function set data(value:Array):void 
		{
			_data = value;
		}
	}
}