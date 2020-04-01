package view.window 
{
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import editor.events.ShortcutEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import game.assets.action.Action;
	import game.data.DataManager;
	import game.library.CatalogManager;
	import morn.core.handlers.Handler;
	import view.auto.window.WindowResEditUI;
	import view.common.ResPreview;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class ResEdit extends WindowResEditUI 
	{
		private var _id:String = "";
		private var _catalog:int = 0;
		private var _displayId:int = 0;
		public function ResEdit() 
		{
			super();
			this.addEventListener(MouseEvent.CLICK,function (e:Event):void 
			{
				dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
			});
			list_preview.array = [];
			list_preview.renderHandler = new Handler(handlerResRender);
			list_preview.selectHandler = new Handler(handlerSelectList);
			tab_action.selectHandler = new Handler(handlerSelectTab);
			
			btn_playOnce.clickHandler = new Handler(play,[false]);
			btn_playRepeat.clickHandler = new Handler(play,[true]);
			btn_turn_left.clickHandler = new Handler(turn,[0]);
			btn_turn_right.clickHandler = new Handler(turn, [1]);
			btn_unselected.clickHandler = new Handler(function ():void 
			{
				list_preview.selectedIndex =-1;
			});
			App.stage.addEventListener(ShortcutEvent.SHORTCUT_EVENT, handlerShortcut);
			App.stage.addEventListener(EditorEvent.ACTION_LOAD_COMPLETED, handlActionLoaded);
			App.stage.addEventListener(EditorEvent.CONTEXT_RES_EDIT, handlerShowRes);
		}
		private function handlerShowRes(e:EditorEvent):void 
		{
			if (e.data as XML) 
			{
				var xml:XML = e.data as XML;
				_id = xml.@id;
				_catalog = xml.@catalog;
			}else{
				_id = e.data.id;
				_catalog = e.data.catalog;
			}
			
			_displayId = CatalogManager.instance.getDisplayIdByCatalogId(_catalog);
			
			list_preview.array = DataManager.action.getActions(ProjectConfig.adoptAction,true);
		}
		private function handlActionLoaded(e:Event):void 
		{
			list_preview.array = DataManager.action.getActions(ProjectConfig.adoptAction,true);
		}
		private function play(repeat:Boolean):void 
		{
			for each(var resview:ResPreview in list_preview.cells) 
			{
				resview.play(repeat);
			}
		}
		private function turn(direction:int):void 
		{
			for each(var resview:ResPreview in list_preview.cells) 
			{
				resview.turn(direction);
			}
		}
		private function handlerSelectTab(index:int):void 
		{
			list_preview.selectedIndex = index;
		}
		private function handlerSelectList(index:int):void 
		{
			var obj:Object = list_preview.array[index];
			for each(var view:ResPreview in list_preview.cells) 
			{
				view.hideAssistant();
			}
			if (obj) 
			{
				(list_preview.selection as ResPreview).showAssistant();
			}
		}
		private function handlerResRender(item:ResPreview,index:int):void 
		{
			if (list_preview.array[index]) 
			{
				var obj:Action = list_preview.array[index];
				item.actionName = obj.name;
				item.actionId = obj.id;
			}else{
				item.hideAssistant();
			}
		}
		private function showTabAction():void
		{
			var modelName:String = ProjectConfig.adoptAction;
			var actions:Array = DataManager.action.getActions(modelName);
			if (actions) 
			{
				var actionLabel:Array = [];
				for (var i:int = 0; i < actions.length; i++)
				{
					var action:Action = actions[i];
					actionLabel.push(action.name);
				}
				tab_action.labels = actionLabel.join(",");
			}
		}
		/**
		 * 快捷键处理
		 * @param	e
		 */
		private function handlerShortcut(e:ShortcutEvent):void 
		{
			var key:String = e.key;
			if (key=="") 
			{
				return;
			}
			if (EditorManager.focus==this && list_preview.selectedIndex<0) 
			{
				var tempX:int = 0;
				var tempY:int = 0;
				switch (key) 
				{
					case "shift,left":
						tempX =10;
						break;
					case "shift,right":
						tempX =-10;
						break;
					case "shift,up":
						tempY =10;
						break;
					case "shift,down":
						tempY = -10;
						break;
					case "ctrl,down":
						tempY =-1;
						break;
					case "ctrl,up":
						tempY = 1;
						break;
					case "ctrl,right":
						tempX = -1;
						break;
					case "ctrl,left":
						tempX =1;
						break;
				}
				trace("正在批量调整:",list_preview.selectedIndex);
				for (var i:int = 0; i < list_preview.array.length; i++) 
				{
					var resView:ResPreview = list_preview.getCell(i) as ResPreview;
					resView.changeCenterPos(tempX, tempY,cb_model.selectedIndex);
				}
			}
		}
	}

}