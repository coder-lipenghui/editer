package view.object 
{
	import game.data.DataManager;
	import game.data.configuration.BaseAttribute;
	import game.data.configuration.MapDesp;
	import morn.core.components.Image;
	import morn.core.events.UIEvent;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class ConnObject extends BaseObject 
	{
		private var _img:Image = new Image;
		public function ConnObject(ba:BaseAttribute,name:String="",res:String="") 
		{
			this.name = "connObject";
			enableDrag = true;
			super(ba, name,"png", res, "00", 0, 0);
			
			_img.addEventListener(UIEvent.IMAGE_LOADED,function ():void 
			{
				var ww:int = _img.bitmapData.width;
				var hh:int = _img.bitmapData.height;
				_img.y =-hh+ProjectConfig.CELL_H/2;
				_img.x =-ww / 2;
				_oname.y =-hh - 20;
				_oname.x = (ww - _oname.width) / 2-ProjectConfig.CELL_W/2;
				_shadow.x = (ww - 64) / 2-ProjectConfig.CELL_W/2;
			});
			_img.skin = "conn.png";
			this.addChild(_img);
		}
		override protected function attributeChange(key:String, value:*):void 
		{
			super.attributeChange(key, value);
			var xx:int = ba.getValue("sx");
			var yy:int = ba.getValue("sy");
			if (key=="x") 
			{
				xx = int(value);
				ba.setValue("sx", xx);
			}
			if (key=="y") 
			{
				yy = int(value);
				ba.setValue("sy", yy);
			}
			if (key=="name") 
			{
				var toMapId:String = ba.getValue("to")
				var toMapName:String = DataManager.mapInfo.getMapNameById(toMapId);
				_oname.text =toMapName==null?toMapId:toMapName;
			}
		}
	}
}