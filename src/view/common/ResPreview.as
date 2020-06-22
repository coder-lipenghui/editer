package view.common 
{
	import editor.events.EditorEvent;
	import editor.events.ShortcutEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import game.assets.animat.Animat;
	import game.assets.bin.BinInfo;
	import game.data.DataManager;
	import game.library.CatalogManager;
	import morn.core.components.Box;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	import view.auto.common.CommResPreviewUI;
	import view.object.GameDisplayObject;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class ResPreview extends CommResPreviewUI
	{
		private var _canvas:Bitmap = new Bitmap();
		private var _resId:int = 0;
		private var _catalog:int = 0;
		private var _gameObject:GameDisplayObject = new GameDisplayObject();
		private var _actionName:String = "";
		private var _actionId:String = "";
		private var _frameCount:int = 0;
		private var _displayModel:Array = [];
		private var _displayId:Array = [0,1,2,3,4];
		private var _displayName:Array = ["衣服", "武器", "翅膀", "特效","坐骑"];
		private var _currDisplayModel:Object = null;
		public function ResPreview() 
		{
			App.stage.addEventListener(ShortcutEvent.SHORTCUT_EVENT, handlerShortcut);
			App.stage.addEventListener(EditorEvent.CONTEXT_RES_EDIT, handlerShowRes);
			App.stage.addEventListener(EditorEvent.CONTEXT_EFFECT_EDIT, handlerShowRes);
			this.addChild(_canvas);
			initCanvas();
			btn_playOnce.clickHandler = new Handler(play, [false]);
			btn_playRepeat.clickHandler = new Handler(play, [true]);
			
			btn_turn_left.clickHandler = new Handler(turn,[0]);
			btn_turn_right.clickHandler = new Handler(turn,[1]);
			btn_trigger.clickHandler = new Handler(function ():void 
			{
				list_displayModel.visible = !list_displayModel.visible;
			});
			list_displayModel.renderHandler = new Handler(handlerDisplayModelRender);
			list_displayModel.selectHandler = new Handler(handlerDisplayModelSelected);
			hideAssistant();
			
			list_displayModel.array = _displayName;
		}
		public function clean():void 
		{
			_displayModel = [];
			_gameObject.clean();
		}
		public function play(repeat:Boolean):void 
		{
			_gameObject.play(repeat);
		}
		public function turn(type:int):void 
		{
			_gameObject.turn(type);
		}
		private function initCanvas():void 
		{
			_canvas.bitmapData = new BitmapData(this.width, this.height ,true, 0x00FFFFFF);
		}
		override protected function resetPosition():void 
		{
			super.resetPosition();
			initCanvas();
		}
		private function handlerShowRes(e:EditorEvent):void 
		{
			clean();
			var obj:Object = e.data;
			var resNode:XML = null;
			if (obj as XML) 
			{
				resNode = obj as XML;
				_catalog = resNode.@catalog;
				_resId = resNode.@id;
			}else{
				_resId = e.data.id;
				_catalog = e.data.catalog;
				resNode = DataManager.library.getResNode(_resId+"", int(_catalog));
			}
			
			if (_actionName==""  && !(_catalog==10||_catalog==11||_catalog==12||_catalog==13))
			{
				return;
			}
			var displayId:int = CatalogManager.instance.getDisplayIdByCatalogId(_catalog);
			if (!resNode) 
			{
				trace("没有资源");
				clean();
				return;
			}
			var effectObj:Object = null;
			if (displayId==3 && _actionId==String(resNode.@action)) 
			{
				effectObj = new Object;
				effectObj.id = int(resNode.@id);
				effectObj.action = String(resNode.@action);
				effectObj.type = String(resNode.@type);
				if (!effectObj.action||effectObj.action=="") 
				{
					effectObj.action = "00";
				}
				effectObj.name = String(resNode.@name);
				effectObj.catalog = int(resNode.@catalog);
				_displayModel[displayId] = effectObj;
				draw(effectObj);
			}else{
				var xmlList:XMLList = resNode.children();
				var res:Array = new Array;
				for (var i:int = 0; i < xmlList.length(); i++) 
				{
					var child:XML = xmlList[i];
					if (int(child.@id) == int(DataManager.action.getActionIdByName(ProjectConfig.adoptAction, _actionName))) 
					{
						var resObj:Object = new Object;
						resObj.id = int(resNode.@id);
						resObj.action = String(child.@id);
						resObj.name = String(resNode.@name);
						resObj.catalog = int(resNode.@catalog);
						resObj.type = String(resNode.@type);//png jpg
						_displayModel[displayId] = resObj;
						draw(resObj);
						break;
					}
				}
			}
		}
		public function draw(obj:Object):void 
		{
			var pos:Point = new Point(img_pos.x+(img_pos.width)/2,img_pos.y+img_pos.height/2);
			_gameObject.show(_canvas.bitmapData, pos, obj.id, obj.name,obj.type,obj.action, obj.catalog);
		}
		public function get actionName():String 
		{
			return _actionName;
		}
		
		public function set actionName(value:String):void 
		{
			txt_name.text=_actionName = value;
		}
		
		public function get actionId():String 
		{
			return _actionId;
		}
		
		public function set actionId(value:String):void 
		{
			_actionId = value;
		}
		
		public function get displayModel():Array 
		{
			return _displayModel;
		}
		
		public function set displayModel(value:Array):void 
		{
			_displayModel = value;
		}
		public function showAssistant():void 
		{
			box_play.visible = 
			img_h.visible = 
			img_v.visible = 
			btn_turn_left.visible =
			btn_turn_right.visible = 
			list_displayModel.visible = true;
			
			list_displayModel.selectedIndex = 0;
		}
		public function hideAssistant():void 
		{
			box_play.visible = 
			img_h.visible = 
			img_v.visible = 
			btn_turn_left.visible =
			list_displayModel.visible=
			btn_turn_right.visible = false;
			
			list_displayModel.selectedIndex =-1;
		}
		private function handlerDisplayModelSelected(index:int):void 
		{
			var obj:Object = _displayModel[index]
			if (obj) 
			{
				_currDisplayModel = obj;
				dispatchEvent(new EditorEvent(EditorEvent.ATTRIBUTE_ACTION,obj ,null,true));
			}
		}
		private function handlerDisplayModelRender(item:Box,index:int):void 
		{
			if (list_displayModel.array[index]) 
			{
				var txt_displayName:Label = item.getChildByName("txt_displayModelName") as Label;
				txt_displayName.text = list_displayModel.array[index];
			}
		}
		/**
		 * 快捷键处理
		 * @param	e
		 */
		private function handlerShortcut(e:ShortcutEvent):void 
		{
			if (!list_displayModel.array || list_displayModel.array.length==0 || !list_displayModel.visible) 
			{
				return;
			}
			var key:String = e.key;
			var tempX:int = 0;
			var tempY:int = 0;
			var doSave:Boolean = true;
			switch (key) 
			{
				case "shift,left":
					tempX =-10;
					break;
				case "shift,right":
					tempX =10;
					break;
				case "shift,up":
					tempY =-10;
					break;
				case "shift,down":
					tempY =10;
					break;
				case "ctrl,down":
				case "down":
					tempY =1;
					break;
				case "ctrl,up":
				case "up":
					tempY =-1;
					break;
				case "ctrl,right":
				case "right":
					tempX = 1;
					break;
				case "ctrl,left":
				case "left":
					tempX =-1;
					break;
				default :
					doSave = false;
			}
			if (doSave) 
			{
				changeCenterPos(tempX, tempY,list_displayModel.selectedIndex);
			}
		}
		public function changeCenterPos(tempX:int,tempY:int,selecteIndex:int):void 
		{
			var obj:Object =_displayModel[selecteIndex];
			if (obj) 
			{
				var node:XML = DataManager.library.getResNode(obj.id, obj.catalog);
				var center:String = node.@center;
				var point:Array = center.split(",");
				var pointX:int = int(point[0]);
				var pointY:int = int(point[1]);
				var catalogId:int=int(node.@catalog)
				//pointX += tempX;
				//pointY += tempY;
				//node.@center = pointX + "," + pointY;
				
				var childXmlList:XMLList = node.children();
				if (!childXmlList || !childXmlList[0]) 
				{
					node.@center = pointX + "," + pointY;
				}
				if (CatalogManager.instance.isEffectCatalog(catalogId)) 
				{
					childXmlList = new XMLList(node);
				}
				for each(var xml:XML in childXmlList) 
				{
					if (xml.@id==_actionId || CatalogManager.instance.isEffectCatalog(catalogId)) 
					{
						var childCenter:String = xml.@center;
						if (childCenter && childCenter!="") 
						{
							center = childCenter;
						}
						point = center.split(",");
						pointX = int(point[0]);
						pointY = int(point[1]);
						pointX += tempX;
						pointY += tempY;
						xml.@center = pointX + "," + pointY;
						var type:String=String(xml.@type)=="jpg"?"jpg":"png";
						var resId:String = String(xml.@id) + "." + type;
						var path:String =[ProjectConfig.libraryPath,CatalogManager.instance.getAbsolutePath(catalogId),node.@name,"export",resId].join("/");
						var bin:BinInfo = new BinInfo(path.replace("."+type,".bin"));
						bin.changeCenter(new Point(tempX,tempY));
						break;
					}
				}
				DataManager.library.addResNode(node);
				draw(obj);
				dispatchEvent(new EditorEvent(EditorEvent.ATTRIBUTE_ACTION,obj ,null,true));
			}
		}
	}

}