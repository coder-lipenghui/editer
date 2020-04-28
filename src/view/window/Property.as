package view.window 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.data.DataManager;
	import game.data.configuration.BaseAttribute;
	import editor.events.EditorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.components.Box;
	import morn.core.components.Image;
	import morn.core.events.UIEvent;
	import view.auto.window.WindowProjectUI;
	import view.auto.window.WindowPropertyUI;
	import view.common.PropertyView;
	import view.common.PulldownPanel;
	import view.object.GameDisplayObject;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class Property extends WindowPropertyUI 
	{
		private var cpv:PropertyView = null;
		private var previewIcon:Image = null;
		private var previewBm:Bitmap = null;
		private var previewObj:GameDisplayObject = null;
		public function Property() 
		{
			super();
			previewBm = new Bitmap(new BitmapData(200, 200, true, 0x00FFFFFF));
			previewObj = new GameDisplayObject();
			previewIcon = new Image;
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill(0, 1);
			mask.graphics.drawRect(0, 0, 200, 200);
			mask.graphics.endFill();
			previewBm.mask = mask;
			this.addChild(mask);
			addEventListener(MouseEvent.CLICK,function (e:Event):void 
			{
				dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
			});
		}
		override protected function initialize():void 
		{
			super.initialize();
			box_container.vScrollBar.touchScrollEnable = false;
		}
		/**
		 * 显示资源预览
		 */
		private function showPreview(ba:BaseAttribute):void 
		{
			var spaceY:int = 0;
			var resId:int = 0;
			var resName:String = "";
			var action:String = "00";
			var catalogId:int = 0;
			previewBm.bitmapData.fillRect(new Rectangle(0, 0, 200, 200), 0x00FFFFFF);
			previewObj.changeDir(4);
			previewIcon.skin = "";
			if (ba.name=="mondef" ) 
			{
				resId = ba.getValue("resid");
				catalogId = 2;
				resName = ba.getValue("name");
				spaceY = 200;
			}else if (ba.name=="npcgen")
			{
				resId = ba.getValue("resid");
				catalogId = 3;
				resName = ba.getValue("name");
				previewObj.changeDir(0);
				spaceY = 200;
			}
			else if (ba.name=="mongen")
			{
				resName = ba.getValue("name");
				catalogId = 2;
				var mon:BaseAttribute = DataManager.monDef.getMonBaByName(resName);
				if (mon) 
				{
					resId = mon.getValue("resid");
					spaceY = 200;
				}
			}else if (ba.name=="itemdef")
			{
				var iconId:String = ba.getValue("iconId");
				var isEquip:Boolean = false;
				resId = ba.getValue("resId");
				if (resId>0) 
				{
					isEquip = true;
					resName = ba.getValue("name");
					catalogId = 7;
				}
				previewIcon.skin = ProjectConfig.assetsPath + "picicon/" + iconId + ".png";
				previewIcon.addEventListener(UIEvent.IMAGE_LOADED,function ():void 
				{
					if (previewIcon.bitmapData) 
					{
						if (isEquip) 
						{
							previewIcon.x = 0;
							previewIcon.y = 200 - previewIcon.bitmapData.height;
						}else{
							previewBm.bitmapData.fillRect(new Rectangle(0, 0, 200, 200), 0x00FFFFFF);
							previewIcon.x = (200 - previewIcon.bitmapData.width) / 2;
							previewIcon.y = (200 - previewIcon.bitmapData.height) / 2;
						}
					}
				});
				spaceY = 200;
			}
			else{
				spaceY = 0;
				if (previewBm.parent) 
				{
					previewBm.parent.removeChild(previewBm);
				}
				if (previewIcon.parent) 
				{
					previewIcon.parent.removeChild(previewIcon);
				}
			}
			if (spaceY>0) 
			{
				previewObj.show(previewBm.bitmapData, new Point(100, 180),resId, resName,"png", action, catalogId);
				if (!previewBm.parent) 
				{
					this.addChild(previewBm);
				}
				if (!previewIcon.parent) 
				{
					this.addChild(previewIcon);
				}
			}
			box_container.y = spaceY;
			box_container.top = 22 + spaceY;
		}
		public function showPorperty(ba:BaseAttribute):void 
		{
			if (ba) 
			{
				if (cpv) 
				{
					cpv.remove();
					cpv = null;
					box_container.refresh();
				}
				cpv = new PropertyView(ba);
				box_container.addChild(cpv);
				showPreview(ba);
			}
		}
	}

}