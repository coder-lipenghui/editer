package view.object 
{
	import flash.geom.Point;
	import game.data.configuration.BaseAttribute;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class NpcObject extends BaseObject 
	{
		public function NpcObject(ba:BaseAttribute,name:String="", res:String="") 
		{
			enableDrag = true;
			super(ba, name,"png", res,"00",3,0);
		}
		override protected function attributeChange(key:String, value:*):void 
		{
			super.attributeChange(key, value);
			if (key=="resid") 
			{
				trace("资源id发生变化:", value);
				resId = value;
				super.show();
			}
		}
	}
}