package view.dialog 
{
	import editor.manager.DataManager;
	import morn.core.handlers.Handler;
	import view.auto.dialog.DialogAddNpcUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class addNpc extends DialogAddNpcUI 
	{
		private var _mapId:String = "";
		private var _x:int = 0;
		private var _y:int = 0;
		private var _npcResId:String = "";
		public function addNpc(npcResId:String,mapId:String,x:int,y:int) 
		{
			super();
			_mapId = mapId;
			_x = x;
			_y = y;
			_npcResId = npcResId;
			txt_id.text = (DataManager.npcGen.maxId(mapId)+1)+"";
			btn_add.clickHandler = new Handler(handlerAddNpc);
		}
		public function handlerAddNpc():void 
		{
			if (_mapId=="" || _x<0 || _y<0|| _npcResId=="") 
			{
				App.log.error("地图信息获取失败:",_mapId,_x,_y,_npcResId);
				return ;
			}
			if (
				txt_id.text==""||
				txt_name.text==""||
				txt_script.text == ""||
				txt_shopScript.text == ""||
				txt_flyid.text==""
			) 
			{
				App.log.error("请填写必要参数");
				return ;
			}
			
			//#编号, 名称,		脚本,			商店脚本, 地图ID, 坐标X,  坐标Y, 地图资源ID,方向,传送ID, 名称缩写,别名,Flag,默认对话, 对话编号,类型,打开界面,跳转地图,跳转坐标X,跳转坐标Y,跳转范围
			//4005005,十面埋伏,npc.yxshacheng,  null,	  tucheng, 69,     42,   40020,       4,  4930003,null,    0,   0,  我是默认对话,100,   3,,yxbiqi,0,0,0
			
			var npcgen:Array = [
				txt_id.text,//#编号
				txt_name.text,//
				txt_script.text,//
				txt_shopScript.text,//
				_mapId,//
				_x + "",//
				_y + "",//
				_npcResId,//
				txt_dir.text,//
				0,//
				"null",//
				0,//
				0,//
				"我是默认对话",//
				100,//
				3,//
				"",//
				"",//
				0,//
				0,//
				0//
			];
			var npcgenStr:String = npcgen.join(DataManager.monGen.separator);
			DataManager.npcGen.addByString(npcgenStr);
			App.log.info("添加成功:",_mapId,_x,_y,txt_name.text);
		}
	}

}