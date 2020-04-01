package view.window 
{
	import editor.menu.menu;
	import flash.display.Sprite;
	import game.data.configuration.BaseAttribute;
	import game.data.DataManager;
	import game.data.events.AttributeEvent;
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import morn.core.components.Image;
	import view.auto.window.WindowProjectUI;
	import morn.core.components.Box;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class Project extends WindowProjectUI 
	{
		private var _group:Array = [];
		private var _groupName:Array = [];
		private var _type1:int = -1;
		private var _type2:int = -1;
		public function Project() 
		{
			super();
			list_config.array = [];
			
			tab_group.selectHandler = new Handler(handleTabSelected);
			com_config.selectHandler = new Handler(handleComSelected);
			
			list_config.renderHandler = new Handler(handleListRender);
			list_config.selectHandler = new Handler(handleListSelected);
			list_config.mouseHandler = new Handler(handlerDrop);
			list_config.rightClickHandler = new Handler(handleShowListMenu);
			
			txt_search.addEventListener(Event.CHANGE, handleSearchTextChange);
			
			addEventListener(MouseEvent.CLICK,function (e:Event):void 
			{
				dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
			});
			
			_group = [
				[DataManager.mapInfo.data, DataManager.monGen.data, DataManager.npcGen.data,DataManager.monDropList.data,DataManager.mapConn.data] //配置表
			];
			_groupName = [
				["地图配置", "刷怪配置", "刷NPC配置", "掉落配置","传送点"],
			];
			
			txt_search.addEventListener(FocusEvent.FOCUS_IN,function (e:Event):void 
			{
				txt_placeholder.visible = false;
			});
			txt_search.addEventListener(FocusEvent.FOCUS_OUT,function (e:Event):void 
			{
				if (txt_search.text=="") 
				{
					txt_placeholder.visible = true;
				}
			});
			tab_group.labels = "配置表";
			tab_group.selectedIndex = 0;
		}
		public function refesh():void 
		{
			list_config.refresh();
		}
		private function handleTabSelected(index:int):void 
		{
			_type1 = index;
			com_config.labels = _groupName[_type1].join(",");
		}
		private function handleComSelected(index:int):void
		{
			_type2 = index;
			if (_group[_type1] && _group[_type1][_type2]) 
			{
				list_config.array = _group[_type1][_type2];
			}
		}
		private function handleListRender(item:Box,index:int):void 
		{
			var txt_name:Label = item.getChildByName("txt_name") as Label;
			var str:String = "";
			var ba:BaseAttribute = null;
			if (list_config.array[index]) 
			{
				ba = list_config.array[index];
				if (ba) 
				{
					var id:String = ba.getValue("id") + "";
					str = ba.getValue("name");
					if (id && id!="" && id!="null") 
					{
						str = str + "<font color=\"#33cc66\">(" + id + ")</font>";
					}
				}
				if (tab_group.selectedIndex==1 && com_config.selectedIndex==4) 
				{
					var fromMapId:String = ba.getValue("name");
					var toMapId:String = ba.getValue("to");
					var fromMapName:String = DataManager.mapInfo.getMapNameById(fromMapId);
					var toMapName:String = DataManager.mapInfo.getMapNameById(toMapId);
					str = fromMapName+"->" + toMapName;
				}
			}
			txt_name.text = str;
		}
		private function handlerDrop(e:MouseEvent,index:int):void 
		{
			if (e.type==MouseEvent.MOUSE_DOWN)
			{
				var ba:BaseAttribute = list_config.array[index];
				if (ba && ba.name=="mondef") 
				{
					var resid:int = int(ba.getValue("resid"));
					var dragImg:Image = new Image("png.comp.btn_file");
					App.drag.doDrag(e.currentTarget as Sprite,dragImg as Sprite,ba);
				}
			}
		}
		private function handleListSelected(index:int):void 
		{
			var ba:BaseAttribute = list_config.array[index];
			if (ba) 
			{
				dispatchEvent(new AttributeEvent(AttributeEvent.SELECTED, ba,null,true));
			}
		}
		private function handleShowListMenu(index:int):void 
		{
			var ba:BaseAttribute = list_config.array[index];
			if (ba) 
			{
				function onCopyed(index:int,ba:BaseAttribute):void 
				{
					trace("增加成功");
					list_config.refresh();
				}
				function onDeleted(index:int):void
				{
					trace("删除成功");
					list_config.refresh();
				}
				function onShow():void 
				{
					
				}
				function onExport():void 
				{
					trace("导出成功");
				}
				var m1:menu = new menu("编辑", EditorEvent.CONTEXT_MAP_EDIT, ba, onShow);
				var m2:menu = new menu("复制", EditorEvent.CONTEXT_COPY, ba, onCopyed);
				var m3:menu = new menu("删除", EditorEvent.CONTEXT_DELETE, ba, onDeleted);
				
				var menus:Array = [m1,m2,m3];
				EditorManager.contextMenu.show(menus);
			}
		}
		private function handleSearchTextChange(e:Event):void 
		{
			var originalText:String = txt_search.text;
			var originalSearchArr:Array = originalText.split(",");
			var searchArray:Array = [];
			for (var j:int = 0; j < originalSearchArr.length; j++) 
			{
				var searchInfo:Array = originalSearchArr[j].split(":");
				var searchObj:Object = {};
				searchObj.key = searchInfo[0];
				if (searchInfo.length>=1) 
				{
					searchObj.value = searchInfo[1];
				}
				searchArray.push(searchObj);
			}
			var tempData:Array = [];
			if (_group[_type1] && _group[_type1][_type2]) 
			{
				tempData = _group[_type1][_type2];
			}
			if (trim(originalText)=="") 
			{
				list_config.array = tempData;
			}else
			{
				if (!tempData) return;
				var searchResult:Array = [];
				for (var i:int = 0; i < tempData.length; i++) 
				{
					var ba:BaseAttribute = tempData[i];
					for (var k:int = 0; k < searchArray.length; k++) 
					{
						searchObj = searchArray[k];
						var key:String = searchObj.key;
						var value:String = searchObj.value;
						if (value) 
						{
							if (ba.getValue(key) && (ba.getValue(key)+"").indexOf(value)>-1) 
							{
								searchResult.push(ba);
							}
						}else{
							if (ba.getValue("name") && ba.getValue("name").indexOf(key)>-1) 
							{
								searchResult.push(ba);
							}
						}
					}
				}
				list_config.array = searchResult;
			}
		}
		private function trim(str:String):String{
			var _str:String=str;                
			while(_str.substr(0,1)==" "){
				_str=_str.substr(1);
			}
			while(_str.substr(-1,1)==" "){
				_str=_str.substr(0,_str.length-1);
			}
			return _str;
		}
		override protected function resetPosition():void 
		{
			super.resetPosition();
		}
	}
}
//<b>常规查找:</b>检索当前列表中的显示项<br/><br>
//<b>高级查找:</b>根据[key:value,key:value]形式查找<br/><br/>
//例：刷怪物配置->map:v0001，可以检索出v0001地图的怪物信息<br>