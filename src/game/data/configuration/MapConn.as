package game.data.configuration 
{
	import flash.utils.Dictionary;
	import game.tools.fileParser.BaseFileParser;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class MapConn extends BaseConfiguration 
	{
		private var _mapconnList:Dictionary = new Dictionary;
		public function MapConn(xml:XML=null) 
		{
			super(xml);
		}
		override public function Import(path:String, type:String = "csv", keys:Array = null, dics:Array = null):Boolean 
		{
			return super.Import(path, BaseFileParser.TYPE_CSV, ["name"], [_mapconnList]);
		}
		
		public function get mapconnList():Dictionary 
		{
			return _mapconnList;
		}
		
		public function set mapconnList(value:Dictionary):void 
		{
			_mapconnList = value;
		}
	}

}