package view.window 
{
	import editor.events.ShortcutEvent;
	import flash.events.Event;
	import game.data.DataManager;
	import game.data.configuration.BaseAttribute;
	import game.data.configuration.BaseConfiguration;
	import game.data.configuration.MapDesp;
	import editor.EditorManager;
	import editor.events.EditorEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import game.data.events.AttributeEvent;
	import morn.core.components.Box;
	import morn.core.components.Label;
	import morn.core.events.DragEvent;
	import morn.core.handlers.Handler;
	import game.tools.other.MapTools;
	import view.auto.window.WindowMapEditUI;
	import view.dialog.addMon;
	import view.object.BaseObject;
	import view.object.ConnObject;
	import view.object.MapObject;
	import view.object.MonObject;
	import view.object.NpcObject;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class MapEdit extends WindowMapEditUI 
	{
		public var MAP_LINE_COLOR:uint = 0xFFFFFF;
		public var MAP_MASK_COLOR:uint = 0x00FF00;
		public var MAP_BLOCK_COLOR:uint = 0xFF0000;
		public var MAP_COLOR_ALPHA:Number = 0.3;
		public static var MAP_PATTERN_RES:String = "map_pattern_res";
		public static var MAP_PATTERN_LIB:String = "map_pattern_lib";
		
		private var _container:Sprite = new Sprite;
		
		private var _map:MapObject = new MapObject;
		
		private var _mapDesp:MapDesp = new MapDesp;
		
		private var _bottomLayer:Sprite = new Sprite;
		private var _graphicsLayer:Sprite = new Sprite;
		private var _displayObjLayer:Sprite = new Sprite;
		
		private var _rcd:Boolean = false;
		
		private var _lcd:Boolean = false;
		
		private var _cScale:Number = 1.0;
		private var _editType:int = 0;//编辑模式：0-绘制地图模式 1-位置布局模式
		private var _clickPoint:Point = new Point();
		
		private var _monSpList:Array = [];//怪物显示对象
		private var _npcSpList:Array = [];//NPC显示对象
		private var _conSpList:Array = [];//传送点显示对象
		private var _safeList:Array = []; //安全区显示对象
		
		private var _tools:MapTools;
		private var _currSelecteTarget:BaseAttribute = null;
		private var _linePoint:Point = new Point( -1, -1);
		/**绘制类型:0路点 1阻挡 2遮罩*/
		private var _drawType:int = 1;
		
		public function MapEdit() 
		{
			this.addEventListener(MouseEvent.MOUSE_OUT,function (e:Event):void 
			{
				if (e.target==this) 
				{
					_container.stopDrag();
				}
			});
			App.stage.addEventListener(EditorEvent.CONTEXT_MAP_EDIT, hanldeShowMap);
			App.stage.addEventListener(ShortcutEvent.SHORTCUT_EVENT, handlerShortcut);
			App.stage.addEventListener(AttributeEvent.SELECTED, handleGameDisplayObjectSelected);
			App.stage.addEventListener(EditorEvent.ADD_ONE_MONGEN,handlerAddMonGenAttribute);
			_tools = new MapTools(this);
			
			_container.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_container.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_container.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
			_container.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, handleRightMouseDown);
			_container.addEventListener(MouseEvent.RIGHT_MOUSE_UP, handleRightMouseUp);
			_container.addEventListener(MouseEvent.RIGHT_CLICK,handleRightClick);
			_container.addEventListener(MouseEvent.CLICK, handlerClick);
			_container.addEventListener(DragEvent.DRAG_DROP,handlerDrop2AddMon);
			_map.x = _map.y = 2;
			_map.progressFun = handlerProgress;
			_map.addEventListener(Event.COMPLETE,function (e:Event):void 
			{
				if (!_mapDesp.loaded) 
				{
					_mapDesp.build(_map.width, _map.height);
					drawGrid();
				}
				cScale =0.3;
			});
			_container.addChild(_map);
			_container.addChild(_bottomLayer);
			_container.addChild(_graphicsLayer);
			_container.addChild(_displayObjLayer);
			
			_displayObjLayer.mouseChildren = false;
			
			this.addChild(_container);
			
			super();
			
			cb_drawType.selectHandler = new Handler(function (index:int):void 
			{
				_drawType = index;
			});
			btn_export.clickHandler = new Handler(function ():void 
			{
				switch (cb_config.selectedIndex) 
				{
					case 0:
						export("mapinfo");
						export("mapconn");
						export("mongen");
						export("npcgen");
						break;
					case 1:
						export("npcgen");
						break;
					case 2:
						export("mongen");
						break;
					case 3:
						export("mapconn");
						break;
					case 4:
						export("mapinfo");
						break;
				}
			});
			//清理画布
			btn_clean.clickHandler = new Handler(function ():void 
			{
				if (_map && _map.width > 0)
				{
					_mapDesp.build(_map.width, _map.height);
					drawGrid();
					drawLogic();
				}
			});
			cb_editType.selectHandler = new Handler(function (index:int):void 
			{
				_editType = index;
				if (index==0) 
				{
					_displayObjLayer.mouseChildren = false;
				}else{
					_displayObjLayer.mouseChildren = true;
				}
				App.log.info("切换到:",index==0?"画图模式":"布局模式");
			});
			cb_drawType.selectHandler = new Handler(function (index:int):void 
			{
				_drawType = index;
			});
			cb_object.selectHandler = new Handler(function (index:int):void
			{
				if (_mapDesp) 
				{
					switch (index) 
					{
						case 1:
							list_object.array = DataManager.monGen.monList[_mapDesp.mapId];
							break;
						case 2:
							list_object.array = DataManager.npcGen.npcList[_mapDesp.mapId];
							break;
						case 3:
							list_object.array = DataManager.mapConn.mapconnList[_mapDesp.mapId];
							break;
						default:
							list_object.array = [];
					}
					if (list_object.array && list_object.array.length>0) 
					{
						box_obj.visible = true;
					}else{
						box_obj.visible = false;
					}
				}				
			});
			list_object.renderHandler = new Handler(handlerListObjRender);
			list_object.selectHandler = new Handler(handlerListObjSelected);
		}
		public function dispose():void 
		{
			App.stage.removeEventListener(EditorEvent.CONTEXT_MAP_EDIT, hanldeShowMap);
			App.stage.removeEventListener(ShortcutEvent.SHORTCUT_EVENT, handlerShortcut);
			App.stage.removeEventListener(AttributeEvent.SELECTED, handleGameDisplayObjectSelected);
			App.stage.removeEventListener(EditorEvent.ADD_ONE_MONGEN, handlerAddMonGenAttribute);
			
			_container.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_container.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_container.removeEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
			_container.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, handleRightMouseDown);
			_container.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, handleRightMouseUp);
			_container.removeEventListener(MouseEvent.RIGHT_CLICK,handleRightClick);
			_container.removeEventListener(MouseEvent.CLICK, handlerClick);
			_container.removeEventListener(DragEvent.DRAG_DROP,handlerDrop2AddMon);
			list_object.renderHandler = null;
			list_object.selectHandler = null;
			btn_export.clickHandler = null;
		}
		override protected function initialize():void
		{
			super.initialize();
			_container.mask = img_mask;
		}
		override protected function resetPosition():void 
		{
			super.resetPosition();
		}
		private function export(type:String):void
		{
			var fileName:String = "";
			var exportPath:String = ProjectConfig.dataPath + "mapinfo.csv";
			var bc:BaseConfiguration = null;
			switch (type)
			{
				case "mapo":
					_mapDesp.doExport();
					App.log.info("mapo保存成功");
					break;
				case "mapinfo":
					fileName = "mapinfo.csv";
					bc = DataManager.mapInfo;
					break;
				case "npcgen":
					fileName = "npcgen.csv";
					bc = DataManager.npcGen;
					break;
				case "mongen":
					fileName = "mongen.csv";
					bc = DataManager.monGen;
					break;
				case "mapconn":
					fileName = "mapconn.csv";
					bc = DataManager.mapConn;
					break;
			}
			if (bc) 
			{
				bc.export(ProjectConfig.dataPath + fileName);
				App.log.info(fileName,"生成成功");
			}
		}
		private function handleGameDisplayObjectSelected(e:AttributeEvent):void 
		{
			if (e.attribute) 
			{
				_currSelecteTarget = e.attribute;
			}
		}
		
		private function copyGameDisplayObject():void
		{
			
		}
		/**
		 * 复制一个[mon、npc、teleporter]对象
		 */
		private function pasteGameDisplayObject():void
		{
			if (_currSelecteTarget) 
			{
				var newBa:BaseAttribute = _currSelecteTarget.clone(true);
				if (newBa.name=="mongen" || newBa.name=="npcgen") 
				{
					var xx:int = int(newBa.getValue("x"));
					var yy:int = int(newBa.getValue("y"));
					newBa.setValue("x",  (xx + 1));
					newBa.setValue("y", (yy + 1));
				}
				switch (newBa.name) 
				{
					case "mongen":
						DataManager.monGen.push(newBa);
						break;
					case "npcgen":
						DataManager.npcGen.push(newBa);
						break;
					case "mapconn":
						DataManager.mapConn.push(newBa);
						break;
				}
				addDisplayObject(newBa);
			}
		}
		/**
		 * 删除一个[mon、npc、teleporter]对象
		 */
		private function deleteGameDisplayObject():void 
		{
			if (_currSelecteTarget) 
			{
				switch (_currSelecteTarget.name) 
				{
					case "mongen":
						DataManager.monGen.remove(_currSelecteTarget);
						break;
					case "npcgen":
						DataManager.npcGen.remove(_currSelecteTarget);
						break;
					case "mapconn":
						DataManager.mapConn.remove(_currSelecteTarget);
						break;
				}
				remDisplayObject(_currSelecteTarget);
			}
		}
		/**
		 * 在当前地图上拖动增加一个怪物
		 * @param	e DragEvent
		 */
		private function handlerDrop2AddMon(e:DragEvent):void 
		{
			trace(e.data);
			var ba:BaseAttribute = e.data as BaseAttribute;
			var xx:int = e.target.mouseX / MapDesp.CELL_W;
			var yy:int = e.target.mouseY / MapDesp.CELL_H;
			var monName:String = ba.getValue("name");
			App.dialog.show(new addMon(_mapDesp.mapId, xx + "", yy + "", monName));
		}
		private function handlerAddMonGenAttribute(e:EditorEvent):void 
		{
			var ba:BaseAttribute = e.data as BaseAttribute;
			addDisplayObject(ba);
		}
		/**
		 * 清理当前画布
		 */
		private function clean():void 
		{
			if (_mapDesp) 
			{
				_mapDesp.clean();
			}
			while (_displayObjLayer.numChildren>0)
			{
				_displayObjLayer.removeChildAt(0);
			}
			_graphicsLayer.graphics.clear();
			_monSpList = [];
			_npcSpList = [];
			_container.x = 0;
			_container.y = 0;
		}
		private function hanldeShowMap(e:EditorEvent):void 
		{
			var obj:Object = e.data;
			var mapId:String = "";
			var mapO:String = "";
			var mapRes:String = "";
			var mapName:String = "";
			if (e.data as XML) 
			{
				var xml:XML = e.data;
				mapId = xml.@export;
				mapO = xml.@name;
				mapRes = xml.@name;
				mapName = xml.@name;
			}
			else if (obj as BaseAttribute) 
			{
				var ba:BaseAttribute = obj as BaseAttribute;
				
				switch (ba.name) 
				{
					case "mapinfo":
						mapId = ba.getValue("id");
						mapRes = ba.getValue("resid");
						mapO = ba.getValue("mapo");
						txt_mapName.text = ba.getValue("name");
						break;
					case "npcgen":
					case "mongen":
						mapRes = mapId = mapO = ba.getValue("mapid");
						break;
					case "mapconn":
						mapRes = mapId=mapO=ba.getValue("name");
						break;
				}
				if (mapId!="") 
				{
					showImg(mapId, mapO, mapRes, MAP_PATTERN_RES);
				}
				return;
			}
			if (mapName!="")
			{
				txt_mapName.text = mapName;
				showImg(mapName, mapName, mapName, MAP_PATTERN_LIB);
				return;
			}
		}
		private function selecteMon(ba:BaseAttribute):void 
		{
			//TODO 跳转到对应的地图及位置
		}
		private function selectNpc(ba:BaseAttribute):void 
		{
			//TODO  跳转到对应的地图及位置
		}
		/**
		 * 显示地图
		 * @param	mapId
		 * @param	mapo
		 * @param	mapRes
		 * @param	pattern res:加载游戏资源侧地图 library:加载资源库地图
		 */
		private function showImg(mapId:String,mapo:String,mapRes:String,pattern:String):void 
		{
			_container.stopDrag();
			var xx:int = 0;
			var yy:int = 0;
			clean();
			_map.init(_mapDesp, mapo,pattern);
			var mapOPath:String = pattern == MAP_PATTERN_RES?ProjectConfig.assetsPath + "map/" + mapo + ".mapo":ProjectConfig.libraryPath + "地图/" + mapo + ".mapo";
			var haveMapConfig:Boolean = _mapDesp.doImport(mapId,mapo,mapRes,mapOPath);
			if (haveMapConfig){
				drawGrid();
				drawLogic();
			}
			var tempScale:Number = _map.width / img_mask.width;
			cScale = Math.max(img_mask.width / _map.width, img_mask.height / _map.height);
			if (pattern==MAP_PATTERN_RES) 
			{
				showMons();
				showNpcs();
				showMapconn();
			}
			dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN, null, null, true));
		}
		private function exportMons():void 
		{
			
		}
		private function showMons():void 
		{
			var id:String = _mapDesp.mapId.replace("[", "");
			showObject(DataManager.monGen.monList[id]);
		}
		private function showNpcs():void 
		{
			showObject(DataManager.npcGen.npcList[_mapDesp.mapId]);
		}
		private function showMapconn():void 
		{
			showObject(DataManager.mapConn.mapconnList[_mapDesp.mapId]);
		}
		private function showObject(list:Array):void 
		{
			if (list) 
			{
				for (var i:int = 0; i < list.length; i++)
				{
					addDisplayObject(list[i]);
				}
			}
		}
		private function remDisplayObject(ba:BaseAttribute):void 
		{
			for (var i:int = 0; i < _displayObjLayer.numChildren; i++) 
			{
				var bo:BaseObject = _displayObjLayer.getChildAt(i) as BaseObject;
				if (bo.ba==ba) 
				{
					_displayObjLayer.removeChild(bo);
				}
			}
		}
		/**
		 * 在编辑器视图中增加一个显示对象
		 * @param	type 类型
		 * @param	ba baseattribute对象
		 * @param	container 容器数组
		 */
		private function addDisplayObject(ba:BaseAttribute):void 
		{
			var container:Array = null;
			var n:String = ba.getValue("name");
			var res:String = ba.getValue("resid");
			var xx:int = ba.getValue("x");
			var yy:int = ba.getValue("y");
			var bo:BaseObject = null;
			if (ba.name=="mapconn") 
			{
				container = _conSpList;
				res = "";//暂时使用默认的素材
				//var point:Array = [int(ba.getValue("sx")),int(ba.getValue("sy"))];
				xx = int(ba.getValue("sx"));
				yy = int(ba.getValue("sy"));
				var toMapId:String = ba.getValue("to")
				var toMapName:String = DataManager.mapInfo.getMapNameById(toMapId);
				
				bo = new ConnObject(ba,toMapName==null?toMapId:toMapName, res);
			}
			if (ba.name=="mongen") 
			{
				container = _monSpList;
				res = "";
				bo = new MonObject(ba,n,res);
			}
			if (ba.name=="npcgen") 
			{
				container = _npcSpList;
				bo = new NpcObject(ba,n,res);
			}
			if (bo) 
			{
				bo.x = xx * MapDesp.CELL_W;
				bo.y = yy * MapDesp.CELL_H;
				_displayObjLayer.addChild(bo);
				container.push(bo);
			}else{
				trace("未知对象");
			}
		}
		
		/**
		 * 绘制基础网格
		 */
		private function drawGrid():void 
		{
			_bottomLayer.graphics.clear();
			_bottomLayer.graphics.beginFill(MAP_LINE_COLOR, 0);
			_bottomLayer.graphics.lineStyle(1,MAP_LINE_COLOR, 0.1);
			for (var i:int = 0; i < _mapDesp.mapCellV; i++) {
				for (var j:int = 0; j < _mapDesp.mapCellH; j++) {
					_bottomLayer.graphics.drawRect(j * MapDesp.CELL_W, i * MapDesp.CELL_H, MapDesp.CELL_W, MapDesp.CELL_H);
				}
			}
			_bottomLayer.graphics.endFill();
		}
		/**
		 * 快捷键处理
		 * @param	e
		 */
		private function handlerShortcut(e:ShortcutEvent):void 
		{
			var key:String = e.key;
			if (EditorManager.focus==this) 
			{
				switch (key) 
				{
					case "shift,1":
						App.log.info("当前画笔为:路点/橡皮");
						cb_drawType.selectedIndex = 0;
						break;
					case "shift,2":
						App.log.info("当前画笔为:阻挡");
						cb_drawType.selectedIndex = 1;
						break;
					case "shift,3":
						App.log.info("当前画笔为:遮挡");
						cb_drawType.selectedIndex = 2;
						break;
					case "ctrl,1":
						cb_editType.selectedIndex = 0;
						break;
					case "ctrl,2":
						cb_editType.selectedIndex = 1;
						break;
					case "ctrl,z":
						_tools.revocation();
						break;
					case "ctrl,s":
						export("mapo");
						break;
					case "ctrl,d":
						_tools.drawFill(_clickPoint,cb_drawType.selectedIndex);
						break;
					case "ctrl,shift,s":
						
						break;
					case "ctrl,p":
						
						break;
					case "ctrl,c":
						break;
					case "ctrl,v":
						pasteGameDisplayObject();
						break;
					case "del":
						deleteGameDisplayObject();
						break;
					case "ctrl,shift,m":
						export("mongen");
						break;
					case "ctrl,shift,n":
						export("npcgen");
						break;
					case "ctrl,shift,t":
						export("mapconn");
						break;
					case "ctrl,alt,m":
						export("mapinfo");
						break;
					default:
				}
			}
		}
		/**
		 * 绘制地图描述信息
		 */
		public function drawLogic():void 
		{
			if (!_mapDesp.logicCell) 
			{
				trace("不存在地图描述信息");
				return;
			}
			var color:int = 0x0;
			//var alpha:Number = MAP_COLOR_ALPHA;
			_graphicsLayer.graphics.clear();
			for (var i:int = 0; i < _mapDesp.mapCellH; i++) {
				for (var j:int = 0; j < _mapDesp.mapCellV; j++) {
					if (_mapDesp.logicCell[j] && _mapDesp.logicCell[j][i] &&_mapDesp.logicCell[j][i]!=0) 
					{
						var xx:int = i * MapDesp.CELL_W;
						var yy:int = j * MapDesp.CELL_H;
						var flag:int = _mapDesp.logicCell[j][i];
						switch (flag) 
						{
							case 1:
								color = MAP_BLOCK_COLOR;
								break;
							case 2:
								color = MAP_MASK_COLOR;
								break;
						}
						if (color!=0x0) 
						{
							_graphicsLayer.graphics.beginFill(color, MAP_COLOR_ALPHA);
							_graphicsLayer.graphics.drawRect(xx, yy, MapDesp.CELL_W, MapDesp.CELL_H);
							_graphicsLayer.graphics.endFill();
						}
					}
				}
			}
			_graphicsLayer.graphics.endFill();
		}
		private function handleMouseDown(e:MouseEvent):void 
		{
			setClickPoint();
			if (_editType==0) 
			{
				if (EditorManager.altDown) 
				{
					if (_linePoint.x!=-1 && _linePoint.y!=-1) 
					{
						_tools.drawLine(_linePoint, _clickPoint, _drawType);
					}
					_linePoint.x = _clickPoint.x;
					_linePoint.y = _clickPoint.y;
				}else
				{
					_linePoint.x =-1;
					_linePoint.y =-1;
					_tools.drawOne(_clickPoint,_drawType);
				}
			}
		}
		private function handleMouseUp(e:MouseEvent):void 
		{
			if (EditorManager.altDown) 
			{
				if (_linePoint.x==-1 && _linePoint.y==-1) 
				{
					
				}
			}
		}
		private function handleMouseWheel(e:MouseEvent):void 
		{
			if (e.currentTarget as BaseObject) 
			{
				return;
			}
			var step:Number = 0.05;
			if (e.delta > 0) //放大
			{
				cScale += step;
			}
			else if (e.delta < 0)//缩小
			{
				cScale -= step;
			}
			_container.x=mouseX-e.localX*cScale;
			_container.y=mouseY-e.localY*cScale;
		}
		private function handleRightMouseDown(e:MouseEvent):void 
		{
			_rcd = true;
			setClickPoint();
			App.timer.doOnce(100,function ():void 
			{
				_container.startDrag();
			});
			if (!EditorManager.altDown) 
			{
				_linePoint.x =-1;
				_linePoint.y =-1;
			}
		}
		private function handleRightMouseUp(e:MouseEvent):void 
		{
			_rcd = false;
			_container.stopDrag();
			_container.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		private function handleRightClick(e:MouseEvent):void 
		{
			
		}
		private function handleMouseMove(e:MouseEvent):void 
		{
			//trace("鼠标移动");
		}
		private function setClickPoint():void 
		{
			_clickPoint.x = Math.floor(_container.mouseX / MapDesp.CELL_W);
			_clickPoint.y = Math.floor(_container.mouseY / MapDesp.CELL_H);
			txt_point.text = _clickPoint.x + "," + _clickPoint.y;
		}
		private function handlerProgress(value:Number):void 
		{
			if (value>=1) 
			{
				pro_loaded.visible = false;
			}else {
				pro_loaded.visible = true;
				pro_loaded.label = "正在加载地图:" + int(value * 100) + "%";
				pro_loaded.value = value;
			}
		}
		private function handlerListObjRender(item:Box,index:int):void 
		{
			if (list_object.array[index]) 
			{
				var ba:BaseAttribute = list_object.array[index];
				var txt_name:Label = item.getChildByName("txt_name") as Label;
				txt_name.text = ba.getValue("name");
				if (cb_object.selectedIndex==3) 
				{
					var fromMap:String = ba.getValue("name");
					var toMap:String = ba.getValue("to");
					var fromMapBa:BaseAttribute = null;
					var toMapBa:BaseAttribute = null;
					if (DataManager.mapInfo.maplist["["+fromMap]) 
					{
						fromMapBa = DataManager.mapInfo.maplist["["+fromMap][0];
					}
					if (DataManager.mapInfo.maplist["["+toMap]) 
					{
						toMapBa = DataManager.mapInfo.maplist["["+toMap][0];
					}
					if (fromMapBa && toMapBa) 
					{
						fromMap = fromMapBa.getValue("name");
						toMap = toMapBa.getValue("name");
					}
					txt_name.text= "["+fromMap+"]" + "->" + "["+toMap+"]";
				}
			}
		}
		private function handlerListObjSelected(index:int):void 
		{
			var ba:BaseAttribute = list_object.array[index];
			var objArr:Array = [];
			switch (cb_object.selectedIndex) 
			{
				case 1:
					objArr = _monSpList;
					break;
				case 2:
					objArr = _npcSpList;
					break;
				case 3:
					objArr = _conSpList;
					break;
			}
			for (var i:int = 0; i < objArr.length; i++) 
			{
				var baseObj:BaseObject = objArr[i] as BaseObject;
				if (baseObj.ba==ba) 
				{
					baseObj.selected = true;
					var xx:int = ba.getValue("x");
					var yy:int = ba.getValue("y");
					if (cb_object.selectedIndex==3) 
					{
						xx = ba.getValue("sx");
						yy = ba.getValue("sy");
					}
					xx = xx * MapDesp.CELL_W;
					yy = yy * MapDesp.CELL_H;
					xx = xx * _cScale;
					yy = yy * _cScale;
					_container.x = -xx + this.width / 2;
					_container.y = -yy + this.height / 2;
					break;
				}
			}
		}
		private function handlerClick(e:MouseEvent):void 
		{
			dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
		}
		
		public function get cScale():Number 
		{
			return _cScale;
		}
		
		public function set cScale(value:Number):void 
		{
			var minScale:Number = 0.5;
			if (_map.width>0) 
			{
				minScale=Math.max(img_mask.width / _map.width, img_mask.height / _map.height);
			}
			var maxScale:Number = 1.5;
			if (value< minScale)
			{
				value = minScale;
			}
			if (value>maxScale)
			{
				value = maxScale;
			}
			input_scale.text=txt_scale.text = value.toFixed(2);
			_cScale = Number(value.toFixed(2));
			_container.scaleX = _container.scaleY = _cScale;
			
		}
		public function get mapDesp():MapDesp 
		{
			return _mapDesp;
		}
		
		public function set mapDesp(value:MapDesp):void 
		{
			_mapDesp = value;
		}
	}

}
/*
<b>绘图模式:</b><br/>
|-ctrl+1 切换到绘图模式<br/>
|-ctrl+2 切换到布局模式<br/>
|-alt+鼠标点击 画直线，可连续点<br/>
|-shift+1 切换到路点(橡皮)画笔<br/>
|-shift+2 切换到阻挡画笔<br/>
|-ctrl+z 撤销上一步操作<br/>
|-ctrl+s 保存<br/>
<b>布局模式:</b><br/>
|-ctrl+v 复制当前选中对象<br/>
|-delete 删除当前选中对象<br/>
|-鼠标按住拖动 可调整选中对象坐标<br/>
<b>通用:</b><br/>
|-右键按住 拖动地图<br/>
|-滚轮滚动 缩放地图<br/>
*/