package game.data.configuration 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class NpcGen extends BaseConfiguration 
	{
		private var _npcList:Dictionary = new Dictionary;
		public function NpcGen(xml:XML=null) 
		{
			super(xml);
		}
		override public function Import(path:String, type:String = "csv", keys:Array = null, dics:Array = null):Boolean 
		{
			return super.Import(path, type, ["mapid"], [_npcList]);
		}
		
		public function get npcList():Dictionary 
		{
			return _npcList;
		}
		
		public function set npcList(value:Dictionary):void 
		{
			_npcList = value;
		}
	}

}