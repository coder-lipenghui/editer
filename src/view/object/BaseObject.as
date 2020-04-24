package view.object 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import game.assets.AnimateManager;
	import game.data.configuration.BaseAttribute;
	import game.data.configuration.MapDesp;
	import game.data.events.AttributeEvent;
	import morn.core.components.Image;
	import view.events.AttributeChangeEvent;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class BaseObject extends Sprite 
	{
		private var _enableDrag:Boolean = false;
		protected var _oname:TextField = new TextField;
		protected var _body:Bitmap = new Bitmap;
		
		protected var _gameObject:GameDisplayObject = new GameDisplayObject;
		protected var _ba:BaseAttribute;
		protected var _shadow:Image = new Image;
		
		private var _mouseDown:Boolean = false;
		private var _catalogId:int = 2;
		private var _action:String = "00";
		private var _resId:String = "";
		private var _dir:int = 4;
		private var _bname:String = "";
		private var _selected:Boolean = false;
		public function BaseObject(ba:BaseAttribute,objName:String,res:String,action:String,catalog:int,dir:int) 
		{
			super();
			_bname = objName;
			_resId = res;
			_action = action;
			_catalogId = catalog;
			_dir = dir;
			_body = new Bitmap();
			this.graphics.clear();
			this.graphics.beginFill(0x0,0.2);
			this.graphics.drawEllipse(0, 0, ProjectConfig.CELL_W, ProjectConfig.CELL_H);
			this.graphics.endFill();
			init();
			this.addEventListener(MouseEvent.CLICK, handleClick);
			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemoved);
			this.addEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			App.stage.addEventListener(AttributeEvent.SELECTED, handleSelected);
			
			_ba = ba;
			if (_ba)
			{
				_ba.addEventListener(AttributeChangeEvent.ATTRIBUTE_CHANGE, handleAttributeChanged);
			}
			_oname.text = _bname;
			_oname.mouseEnabled = false;
			
			var tf:TextFormat = new TextFormat;
			tf.size = 16;
			tf.align = "center";
			_oname.filters = [new GlowFilter(0xFF0000, 1, 5, 5)];
			_oname.defaultTextFormat = tf;
			_oname.text = _oname.text == ""?"显示名称":_oname.text;
			_oname.textColor = 0xFFFFFF;
			//_oname.width = 150;
			_oname.height = 22;
			
			_shadow.skin = "shadow.png";
			this.addChild(_shadow);
			this.addChild(_body);
			this.addChild(_oname);
			
			show();
		}
		/**
		 * 处理属性变化时对应的刷新
		 * @param	e
		 */
		private function handleAttributeChanged(e:AttributeChangeEvent):void 
		{
			if (e.attribute=="x") 
			{
				this.x = int(e.value) * ProjectConfig.CELL_W;
			}
			if (e.attribute=="y") 
			{
				this.y = int(e.value) * ProjectConfig.CELL_H;
			}
			if (e.attribute=="name") 
			{
				_oname.text = e.value;
			}
			attributeChange(e.attribute,e.value);
		}
		protected function attributeChange(key:String,value:*):void 
		{
			
		}
		/**
		 * 显示资源
		 * @param	resId
		 * @param	resName
		 * @param	action
		 * @param	catalogId
		 */
		protected function show():void 
		{
			_gameObject.show(_body.bitmapData, new Point(_body.width/2,_body.height), int(resId), _bname, action, catalogId);
			_gameObject.changeDir(_dir);
		}
		private function handleSelected(e:AttributeEvent):void 
		{
			if (e.attribute!=this._ba) 
			{
				this.filters = [];
			}
		}
		private function handleClick(e:Event):void 
		{
			//selected();
			selected = true;
			e.stopImmediatePropagation();
		}
		
		private function handleRemoved(e:Event):void 
		{
			this.removeEventListener(MouseEvent.CLICK, handleClick);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			this.removeEventListener(MouseEvent.MOUSE_MOVE,handleMouseMove);
			if (_ba) 
			{
				_ba.removeEventListener(AttributeChangeEvent.ATTRIBUTE_CHANGE, handleAttributeChanged);
			}
			if (_body.bitmapData) 
			{
				_body.bitmapData.dispose();
			}
			_body = null;
			_gameObject = null;
			_ba = null;
		}
		private function handleMouseMove(e:MouseEvent):void 
		{
			
		}
		private function handleMouseDown(e:MouseEvent):void 
		{
			_mouseDown = true;
			if (_enableDrag) 
			{
				startDrag();
			}
		}
		private function handleMouseUp(e:MouseEvent):void 
		{
			_mouseDown = false;
			if (ba && _enableDrag) 
			{
				var xx:int = int(this.x / ProjectConfig.CELL_W);
				var yy:int = int(this.y / ProjectConfig.CELL_H);
				ba.setValue("x", xx);
				ba.setValue("y", yy);
			}
			stopDrag();
		}
		protected function change():void 
		{
			
		}
		public function init():void 
		{
			var info:Array = AnimateManager.getAnimateInfo(catalogId,"", resId, action);
			if (info) 
			{
				var ww:int = info[_dir][0][2];
				var hh:int = info[_dir][0][3];
				if (_body.bitmapData) 
				{
					_body.bitmapData.dispose();
				}
				_body.y =-hh+this.height/2;
				_body.bitmapData = new BitmapData(ww, hh,true,0x00FFFFFF);
				_body.x = int(this.width - ww) / 2;
				_oname.y =-hh;
				_oname.x = int(this.width-_oname.width)/2;
			}
		}
		public function render():void
		{
			
		}
		public function changeRes(resid:int):void 
		{
			
		}
		
		public function get ba():BaseAttribute 
		{
			return _ba;
		}
		
		public function set ba(value:BaseAttribute):void 
		{
			_ba = value;
		}
		
		public function get enableDrag():Boolean 
		{
			return _enableDrag;
		}
		
		public function set enableDrag(value:Boolean):void 
		{
			_enableDrag = value;
		}
		
		public function get gameObject():GameDisplayObject 
		{
			return _gameObject;
		}
		
		public function set gameObject(value:GameDisplayObject):void 
		{
			_gameObject = value;
		}
		public function get catalogId():int 
		{
			return _catalogId;
		}
		
		public function set catalogId(value:int):void 
		{
			_catalogId = value;
		}
		
		public function get action():String 
		{
			return _action;
		}
		
		public function set action(value:String):void 
		{
			_action = value;
		}
		
		public function get resId():String 
		{
			return _resId;
		}
		
		public function set resId(value:String):void 
		{
			if (value!=_resId) 
			{
				init();
			}
			_resId = value;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			if (_ba) 
			{
				dispatchEvent(new AttributeEvent(AttributeEvent.SELECTED, _ba, null, true));
			}
			this.filters = [];
			this.filters = [new GlowFilter(0xFF0000,1)];
			_selected = value;
		}
	}

}