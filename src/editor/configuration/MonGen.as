package editor.configuration 
{
	import editor.events.EditorEvent;
	import editor.configuration.BaseConfiguration;
	import flash.utils.Dictionary;
	import editor.tools.fileParser.BaseFileParser;
	/**
	 * ...
	 * @author lee
	 */
	public class MonGen extends BaseConfiguration 
	{
		private var _monList:Dictionary = new Dictionary;
		public function MonGen(xml:XML=null) 
		{
			super(xml);
		}
		override public function Import(path:String, type:String = "csv",keys:Array=null,dics:Array=null):Boolean 
		{
			return super.Import(path, BaseFileParser.TYPE_CSV,["mapid"],[_monList]);
		}
		
		public function get monList():Dictionary 
		{
			return _monList;
		}
		
		public function set monList(value:Dictionary):void 
		{
			_monList = value;
		}
		public function addByString(str:String):void 
		{
			var temp:Array = str.split(this.separator);
			var ba:BaseAttribute = this.parser(temp);
			if (ba) 
			{
				App.stage.dispatchEvent(new EditorEvent(EditorEvent.ADD_ONE_MONGEN,ba));
			}
		}
	}

}