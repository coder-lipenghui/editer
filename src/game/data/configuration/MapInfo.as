package game.data.configuration 
{
	import flash.utils.Dictionary;
	import editor.log.Logger;
	import game.tools.fileParser.BaseFileParser;
	import game.tools.fileParser.TxtParser;
	import game.data.configuration.BaseConfiguration;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author lee
	 */
	public class MapInfo extends BaseConfiguration
	{
		private var _maplist:Dictionary = new Dictionary;
		public function MapInfo(xml:XML=null) 
		{
			super(xml);
		}
		override public function Import(path:String, type:String = "csv",keys:Array=null,dics:Array=null):Boolean 
		{
			return super.Import(path,BaseFileParser.TYPE_CSV,["id"],[_maplist]);
		}
		override protected function sort():void 
		{
			//super.sort();
			data = data.sortOn(["mapid"]);
		}
		public function get maplist():Dictionary 
		{
			return _maplist;
		}
		
		public function set maplist(value:Dictionary):void 
		{
			_maplist = value;
		}
		public function getMapNameById(mapId:String):String 
		{
			if (_maplist["["+mapId]) 
			{
				return (_maplist["["+mapId][0] as BaseAttribute).getValue("name");
			}
			return null;
		}
	}
}