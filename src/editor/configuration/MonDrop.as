package editor.configuration 
{
	import flash.utils.Dictionary;
	/**
	 * 物品掉落组
	 * @author 3464285@gmail.com
	 */
	public class MonDrop extends BaseConfiguration 
	{
		private var _dropList:Dictionary = new Dictionary;
		public function MonDrop(xml:XML=null) 
		{
			super(xml);
		}
		override public function Import(path:String, type:String = "csv", keys:Array = null, dics:Array = null):Boolean 
		{
			return super.Import(path, type,["id"], [_dropList]);
		}
		public function getDespNameById(id:int):String 
		{
			if (_dropList[id]) 
			{
				var ba:BaseAttribute = _dropList[id][0];
				return ba.getValue("name");
			}
			return null;
		}
		public function getItemsById(id:int):String 
		{
			if (_dropList[id]) 
			{
				var ba:BaseAttribute = _dropList[id][0];
				return ba.getValue("items");
			}
			return null;
		}
		/**
		 * 掉落组信息、group by id
		 */
		public function get dropList():Dictionary 
		{
			return _dropList;
		}
		
		public function set dropList(value:Dictionary):void 
		{
			_dropList = value;
		}
	}

}