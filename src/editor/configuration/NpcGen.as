package editor.configuration
{
	import editor.events.EditorEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class NpcGen extends BaseConfiguration
	{
		private var _npcList:Dictionary = new Dictionary;
		
		public function NpcGen(xml:XML = null)
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
		public function maxId(mapId:String):int
		{
			var id:int = 0;
			
			for each(var arr:Array in _npcList) 
			{
				for (var i:int = 0; i < arr.length; i++) 
				{
					var ba:BaseAttribute = arr[i];
					var tmp:int = int(ba.getValue("id"));
					if (tmp>id) 
					{
						id = tmp;
					}
				}
			}
			return id;
		}
		public function addByString(str:String):void
		{
			var temp:Array = str.split(this.separator);
			var ba:BaseAttribute = this.parser(temp);
			var mapId:String = String(ba.getValue("mapid"));
			trace("==>数量:",_npcList[mapId].length);
			_npcList[mapId].push(ba);
			trace("==>数量:",_npcList[mapId].length);
			if (ba)
			{
				App.stage.dispatchEvent(new EditorEvent(EditorEvent.ADD_ONE_NPCGEN, ba));
			}
		}
	}

}