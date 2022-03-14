package editor.configuration 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class CustomConfig extends BaseConfiguration 
	{
		private var list:Dictionary = new Dictionary;
		public function CustomConfig(xml:XML=null) 
		{
			super(xml);
			
		}
		override public function Import(path:String, type:String = "csv", keys:Array = null, dics:Array = null):Boolean 
		{
			return super.Import(path, type, ["mapid"], [list]);
		}
	}

}