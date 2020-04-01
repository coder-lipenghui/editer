package game.assets.action 
{
	import flash.utils.Dictionary;
	/**
	 * 动作描述信息
	 * 例：
	 * 编号 名称 帧数  矫正 	启用
	 * 00 	待机   2  3,3,3,3   true
	 * @author 3464285@gmail.com
	 */
	public class Action 
	{
		public var id:String = "";
		public var name:String = "";
		public var frame:String = "";
		public var adjust:String = "";
		public var enable:Boolean = true;
		public var publish:Boolean = true;
		public function Action(xml:XML) 
		{
			create(xml);
		}
		public function create(xml:XML):void 
		{
			if (xml) 
			{
				id = String(xml.@id);
				name = String(xml.@name);
				frame =String(xml.@frame);
				adjust = String(xml.@adjust);
				enable = String(xml.@enable)=="true"?true:false;
				publish = String(xml.@publish)=="true"?true:false;
			}
		}
	}

}