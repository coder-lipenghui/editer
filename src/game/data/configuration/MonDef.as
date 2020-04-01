package game.data.configuration 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class MonDef extends BaseConfiguration 
	{
		private var _groupByName:Dictionary = new Dictionary;
		public function MonDef(xml:XML=null) 
		{
			super(xml);
		}
		override public function Import(path:String, type:String = "csv", keys:Array = null, dics:Array = null):Boolean 
		{
			return super.Import(path, type, ["name"], [_groupByName]);
		}
		public function getMonBaByName(name:String):BaseAttribute
		{
			if (_groupByName[name]) 
			{
				return _groupByName[name][0];
			}
			return null;
		}
	}

}