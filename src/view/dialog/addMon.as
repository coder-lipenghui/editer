package view.dialog 
{
	import editor.manager.DataManager;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogAddMonUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class addMon extends DialogAddMonUI 
	{
		private var _mapId:String = null;
		private var _posX:String = null;
		private var _posY:String = null;
		private var _monName:String = null;
		public function addMon(mapId:String,posX:String,posY:String,monName:String) 
		{
			super();
			_mapId = mapId;
			_posX = posX;
			_posY = posY;
			_monName = monName;
			
			btn_add.clickHandler = new Handler(handlerAddMon);
		}
		public function handlerAddMon():void 
		{
			if (_mapId=="" || _monName=="" || _posX=="" || _posY=="" || txt_number.text=="" || txt_range.text=="" || txt_refTime.text=="") 
			{
				App.log.error("请填写必要参数");
				return ;
			}
			if (int(txt_refTime.text)<=0 || int(_posX)<0 || int(_posY)<0 || int(txt_range.text)<=0) 
			{
				App.log.error("刷新时间不能小于等于0、坐标不能小于0");
				return;
			}
			//地图 x y 怪物名 范围 数量 复活时间(ms)
			//andian1 107 82 女山贼 107 6 10
			var mongen:Array = [_mapId, _posX, _posY, _monName, txt_range.text, txt_number.text, txt_refTime.text];
			var mongenStr:String = mongen.join(DataManager.monGen.separator);
			DataManager.monGen.addByString(mongenStr);
			App.log.info("添加成功:",_mapId,_monName);
		}
	}

}