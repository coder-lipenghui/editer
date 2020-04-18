package view 
{
	import editor.EditorManager;
	import game.data.DataManager;
	import game.data.events.AttributeEvent;
	import editor.events.EditorEvent;
	import flash.events.Event;
	import morn.core.components.View;
	import morn.core.handlers.Handler;
	import view.auto.MainWorkUI;
	import view.dialog.addComRes;
	import view.dialog.addMapRes;
	import view.dialog.crackBin;
	import view.dialog.delRes;
	import view.dialog.exportMapRes;
	import view.dialog.exprotRes;
	import view.dialog.exprotResByCatalog;
	import view.dialog.groupJiuYinRes;
	import view.dialog.welcome;
	import view.window.DropInfo;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class work extends MainWorkUI 
	{
		private static var _instance:work = null;
		//TODO 增加容器，新增视图的时候进行宽高调整（百分比调整）
		private var uv_dropinfo:DropInfo = new DropInfo();
		private var _currWindow:View = null;
		public function work() 
		{
			super();
			addEventListener(AttributeEvent.SELECTED, handleAttributeSelected);
			addEventListener(EditorEvent.ATTRIBUTE_ACTION, handleSelectAction);
			addEventListener(EditorEvent.FOCUS_IN, handleWindowFocus);
			App.stage.addEventListener(EditorEvent.CONTEXT_RES_EDIT, function (e:EditorEvent):void 
			{
				uv_editor.tab_edit.selectedIndex = 1;
			});
			App.stage.addEventListener(EditorEvent.CONTEXT_MAP_EDIT,function ():void 
			{
				uv_editor.tab_edit.selectedIndex = 0;
			});
			App.stage.addEventListener(EditorEvent.CONTEXT_MAP_EXPORT,function (e:EditorEvent):void 
			{
				App.dialog.show(new exportMapRes(e.data),true);
			});
			App.stage.addEventListener(EditorEvent.CONTEXT_RES_EXPORT,function (e:EditorEvent):void 
			{
				App.dialog.show(new exprotRes(e.data),true);
			});
			App.stage.addEventListener(EditorEvent.CONTEXT_RES_DELETE,function (e:EditorEvent):void 
			{
				App.dialog.show(new delRes(e.data));
			});
			App.stage.addEventListener(EditorEvent.CONTEXT_RES_EXPORT_CATALOG,function (e:EditorEvent):void 
			{
				App.dialog.show(new exprotResByCatalog(e.data));
			});
			btn_addComRes.clickHandler = new Handler(function ():void 
			{
				App.dialog.show(new addComRes, true);
			});
			btn_crackBin.clickHandler = new Handler(function ():void
			{
				App.dialog.show(new crackBin, true);
			});
			btn_project.clickHandler = new Handler(function ():void 
			{
				App.dialog.show(new welcome, true);
			});
			btn_addMap.clickHandler = new Handler(function ():void 
			{
				App.dialog.show(new addMapRes,true);
			});
			btn_exportCloth.clickHandler = new Handler(function ():void 
			{
				DataManager.library.exportCloth();
			});
			btn_exportWeapon.clickHandler = new Handler(function ():void 
			{
				DataManager.library.exportWeapon();
			});
			btn_exportWing.clickHandler = new Handler(function ():void 
			{
				DataManager.library.exprotWing();
			});
			btn_exportEffect.clickHandler = new Handler(function ():void 
			{
				DataManager.library.exprotEffect();
			});
			btn_exportQiege.clickHandler = new Handler(function ():void 
			{
				DataManager.library.exportQiege();
			});
			btn_group.clickHandler = new Handler(function ():void 
			{
				App.dialog.show(new groupJiuYinRes);
			});
			btn_exportMount.clickHandler = new Handler(function ():void 
			{
				DataManager.library.exprotMount();
			});
			btn_exportPet.clickHandler = new Handler(function ():void 
			{
				DataManager.library.exprotPet()
			});
			btn_export.clickHandler = new Handler(function ():void 
			{
				box_action.visible = !box_action.visible;
			});
			btn_crack.clickHandler = new Handler(function ():void 
			{
				box_crack.visible = !box_crack.visible;
			});
			uv_action.remove();
		}
		public function refesh():void 
		{
			uv_project.refesh();
		}
		private function handleSelectAction(e:EditorEvent):void 
		{
			this.addChild(uv_action);
			uv_action.showProperty(e.data);
		}
		private function handleAttributeSelected(e:AttributeEvent):void 
		{
			uv_action.remove();
			uv_dropinfo.remove();
			uv_property.showPorperty(e.attribute);
			uv_editor.uv_code.showProperty(e.attribute);
			if (e.attribute.name=="mongen") 
			{
				uv_dropinfo.show(e.attribute);
				if (!uv_dropinfo.parent) 
				{
					this.addChild(uv_dropinfo);
				}
			}
			changeSize();
		}
		
		private function handleWindowFocus(e:Event):void 
		{
			EditorManager.focus = e.target;
			//var temp:Array = [uv_project, uv_property,uv_editor,uv_dropinfo,uv_library,uv_editor.uv_resEditer,uv_editor.uv_mapEditer];
			//for (var i:int = 0; i < temp.length; i++) 
			//{
				//if (e.target==temp[i]) 
				//{
					////temp[i].clip_focus.index = 1;
					//temp[i].showBorder(0xFAFAFA,0.3);
				//}else{
					////temp[i].clip_focus.index = 0;
					//temp[i].hideBorder();
				//}
			//}
		}
		public static function get instance():work 
		{
			if (!_instance) 
			{
				_instance = new work();
			}
			return _instance;
		}
		
		public static function set instance(value:work):void 
		{
			_instance = value;
		}
		override protected function changeSize():void 
		{
			uv_library.height = stage.stageHeight - 25;
			uv_baseData.top = 25;
			uv_baseData.bottom=stage.stageHeight / 2;
			uv_project.top = stage.stageHeight / 2;
			if (uv_dropinfo.parent) 
			{
				var hh:int = stage.stageHeight - 26;
				var split:int = int(hh / 2);
				uv_property.bottom = split;
				uv_dropinfo.top = split + 26;
				uv_dropinfo.bottom = 0;
				uv_dropinfo.right = 2;
			}else{
				//uv_project.bottom = 0;
			}
			super.changeSize();
		}
	}

}